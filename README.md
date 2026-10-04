# EV Battery Management System (BMS) with EKF State-of-Charge (SOC) Estimation

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%20%7C%20R2024b-0076A8?logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Domain](https://img.shields.io/badge/Domain-Electric%20Vehicles%20&%20Energy%20Storage-lightgrey.svg)](#)

A standalone MATLAB implementation of EV Battery Management System (BMS) with EKF State-of-Charge (SOC) Estimation. Includes the governing dynamics, analytical formulations, and an executable script you can run directly without proprietary third-party dependencies.

## Overview

This repository provides a standalone MATLAB implementation of an Extended Kalman Filter (EKF) for estimating lithium-ion battery state-of-charge (SOC). It models cell dynamics using a Thevenin 1-RC equivalent circuit and tracks battery states under a dynamic charge-discharge drive cycle.

## Governing Equations & Mathematical Formulation

### State Update Equation (Thevenin 1-RC Model)

$$
\begin{bmatrix}
SOC_k \\
V_{1,k}
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 \\
0 & e^{-\Delta t / (R_1 C_1)}
\end{bmatrix}
\begin{bmatrix}
SOC_{k-1} \\
V_{1,k-1}
\end{bmatrix}
+
\begin{bmatrix}
-\frac{\eta \Delta t}{3600 Q_n} \\
R_1 \left(1 - e^{-\Delta t / (R_1 C_1)}\right)
\end{bmatrix}
I_k + w_k
$$

### Terminal Voltage Output Equation

$$
V_{t,k} = OCV(SOC_k) - R_0 I_k - V_{1,k} + v_k
$$

where $SOC_k$ is the state of charge, $V_{1,k}$ is the polarization capacitor voltage, $OCV(SOC_k)$ is the open-circuit voltage polynomial, $R_0$ is the ohmic internal resistance, and $I_k$ is the load current.

## Getting Started

### Prerequisites
- MATLAB (tested on R2022b through R2024b)
- Standard base MATLAB installation (no paid external toolboxes required for this starter script)

### Running the Code
1. Clone the repository:
   ```bash
   git clone https://github.com/matlabsolutions-simulink/ev-battery-management-system-ekf-simscape.git
   cd ev-battery-management-system-ekf-simscape
   ```
2. Open MATLAB, navigate to the cloned folder, and run:
   ```matlab
   run_bms_ekf_simulation
   ```

## Need the Complete Simulink or Simscape Model?

If you are working on a university capstone, thesis, or lab assignment and need the complete `.slx` model with Simscape physical networks, custom parameter lookup tables, or automated test harnesses, our team at [MATLABSolutions.com](https://www.matlabsolutions.com/order-now.php?ref=github_ev_battery_management_system_ekf_simscape) provides custom academic simulation and consulting support.

## Technical Inquiries & Contact
- Website: [matlabsolutions.com](https://www.matlabsolutions.com)
- Custom Consulting Portal: [matlabsolutions.com/order-now.php](https://www.matlabsolutions.com/order-now.php)
- Email: info@matlabsolutions.com

## License
This project is open-source under the [MIT License](LICENSE).
