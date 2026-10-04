%% Extended Kalman Filter (EKF) for Battery SOC Estimation
% Developed by MATLABSolutions Research Team (https://www.matlabsolutions.com)
% Reference & Full Simulink Models: https://www.matlabsolutions.com/order-now.php?ref=github_ev_bms

clear; clc; close all;

fprintf('=======================================================\n');
fprintf('  MATLABSolutions: EV Battery BMS EKF SOC Estimation  \n');
fprintf('=======================================================\n');

%% 1. Simulation & Battery Cell Parameters
dt = 0.5;                     % Sampling interval [s]
t_final = 1800;               % Simulation time (30 mins) [s]
time = 0:dt:t_final;
N = length(time);

Qn = 2.5 * 3600;              % Nominal capacity: 2.5 Ah in Coulombs
R0 = 0.035;                   % Ohmic internal resistance [Ohms]
R1 = 0.025;                   % Charge transfer resistance [Ohms]
C1 = 1200;                    % Double-layer capacitance [Farads]
tau = R1 * C1;                % RC time constant
eta = 0.99;                   % Coulombic efficiency

%% 2. Generate Dynamic Current Profile (Urban Drive Cycle)
rng(42);
I_profile = 2.0 * sin(2*pi*time / 300) + 1.2 * sin(2*pi*time / 60) + 0.8 * randn(1, N);
I_profile(I_profile < -5) = -5;  % Regen braking current limit
I_profile(I_profile > 8) = 8;    % Discharge current limit

%% 3. True Plant Simulation
soc_true = zeros(1, N);
V1_true = zeros(1, N);
Vt_true = zeros(1, N);
soc_true(1) = 0.90;           % Initial true SOC (90%)

% Non-linear OCV-SOC polynomial approximation
ocv_func = @(s) 3.1 + 1.15*s - 0.9*(s.^2) + 0.85*(s.^3);
docv_func = @(s) 1.15 - 1.8*s + 2.55*(s.^2);

for k = 1:N-1
    soc_true(k+1) = soc_true(k) - (eta * dt / Qn) * I_profile(k);
    soc_true(k+1) = max(0, min(1, soc_true(k+1)));
    V1_true(k+1) = exp(-dt/tau) * V1_true(k) + R1*(1 - exp(-dt/tau)) * I_profile(k);
    Vt_true(k) = ocv_func(soc_true(k)) - R0 * I_profile(k) - V1_true(k) + 0.005*randn;
end
Vt_true(N) = ocv_func(soc_true(N)) - R0 * I_profile(N) - V1_true(N) + 0.005*randn;

%% 4. Discrete Extended Kalman Filter (EKF) Implementation
x_est = zeros(2, N);          % State: [SOC; V1]
x_est(:, 1) = [0.75; 0];       % Deliberate initial error (75% estimated vs 90% true)

P = diag([0.05, 0.01]);       % Initial state covariance
Q = diag([1e-6, 1e-5]);       % Process noise covariance
R = 2.5e-3;                   % Measurement noise covariance

A_k = [1, 0; 0, exp(-dt/tau)];
B_k = [-eta*dt/Qn; R1*(1 - exp(-dt/tau))];

for k = 2:N
    % Time Update (Predict)
    x_pred = A_k * x_est(:, k-1) + B_k * I_profile(k-1);
    x_pred(1) = max(0, min(1, x_pred(1)));
    P_pred = A_k * P * A_k' + Q;
    
    % Measurement Update (Correct)
    H_k = [docv_func(x_pred(1)), -1];
    y_meas = Vt_true(k);
    y_pred = ocv_func(x_pred(1)) - R0 * I_profile(k) - x_pred(2);
    residual = y_meas - y_pred;
    
    S = H_k * P_pred * H_k' + R;
    K = P_pred * H_k' / S;
    
    x_est(:, k) = x_pred + K * residual;
    x_est(1, k) = max(0, min(1, x_est(1, k)));
    P = (eye(2) - K * H_k) * P_pred;
end

%% 5. Performance Metrics
rmse_soc = sqrt(mean((soc_true - x_est(1, :)).^2)) * 100;
fprintf('EKF SOC Tracking Complete!\n');
fprintf('Root Mean Square Error (RMSE): %.3f %%%%\n', rmse_soc);
fprintf('Final True SOC:      %.2f %%%%\n', soc_true(end)*100);
fprintf('Final Estimated SOC: %.2f %%%%\n', x_est(1, end)*100);
