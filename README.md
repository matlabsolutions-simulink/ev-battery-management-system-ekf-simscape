# EV Battery Management System (BMS) with EKF State-of-Charge (SOC) Estimation

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%20%7C%20R2024b-0076A8?logo=mathworks&logoColor=white)](https://www.mathworks.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Engineering Domain](https://img.shields.io/badge/Domain-Electric%20Vehicles%20&%20Energy%20Storage-blue.svg)](#)
[![Status](https://img.shields.io/badge/Simulations-Verified%20Passing-success.svg)](#)

> **Official Open-Source Engineering Package by [MATLABSolutions.com](https://www.matlabsolutions.com)**  
> High-performance numerical simulation, algorithm modeling, and verified state equations.

---

## 🎯 Overview & Problem Statement
Discrete Extended Kalman Filter (EKF) implementing a Thevenin 1-RC equivalent circuit model for high-precision Lithium-ion battery SOC estimation under dynamic current drive cycles.

This repository provides verified, modular MATLAB source code and analytical formulas designed for university research, ABET/CEAB engineering labs, capstone design, and industrial modeling.

---

## 📐 Mathematical Formulation & Governing Equations

- **State Update Equation:**
  $$\begin{bmatrix} SOC_{k} \\ V_{1,k} \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 0 & e^{-\Delta t / (R_1 C_1)} \end{bmatrix} \begin{bmatrix} SOC_{k-1} \\ V_{1,k-1} \end{bmatrix} + \begin{bmatrix} -\frac{\eta \Delta t}{3600 Q_n} \\ R_1 (1 - e^{-\Delta t / (R_1 C_1)}) \end{bmatrix} I_k + w_k$$
- **Terminal Voltage Measurement Equation:**
  $$V_{t,k} = OCV(SOC_k) - R_0 I_k - V_{1,k} + v_k$$

---

## 🚀 Quickstart & Execution

### Prerequisites
- MATLAB R2022b, R2023b, R2024a, or R2024b
- Base MATLAB (Zero paid proprietary third-party toolboxes required for this starter script)

### Running the Benchmark Simulation
1. Clone this repository:
   ```bash
   git clone https://github.com/matlabsolutions-simulink/ev-battery-management-system-ekf-simscape.git
   cd ev-battery-management-system-ekf-simscape
   ```
2. Open MATLAB and navigate to the project directory.
3. Run the primary entry script in the MATLAB Command Window:
   ```matlab
   run_bms_ekf_simulation
   ```

---

## 💡 Need the Full Parameterized Simulink (.slx) Model or Custom Help?

> [!TIP]
> ### 🎓 24/7 Academic & Industrial Consulting from PhD Engineers
> Are you working on a senior design capstone, master's thesis, or strict coursework deadline?
> 
> Our team of **500+ PhD Engineers** at **[MATLABSolutions.com](https://www.matlabsolutions.com)** provides:
> - **Complete Pre-Parameterized Simulink (`.slx`) & Simscape Models**
> - **Custom Parameter Tuning & Hardware-in-the-Loop (HIL) Integration**
> - **Line-by-Line Code Documentation & 1-on-1 Walkthroughs**
> - **100% Plagiarism-Free Turnitin Verification Reports**
> - **Fast Turnaround:** Urgent deliveries from 6 hours to 3 days
>
> 🚀 **[Request Custom Solution & Instant Quote on MATLABSolutions.com](https://www.matlabsolutions.com/order-now.php?ref=github_ev_battery_management_system_ekf_simscape)**

---

## 📚 Technical Support & Contact
- **Website:** [https://www.matlabsolutions.com](https://www.matlabsolutions.com)
- **Direct Order Portal:** [https://www.matlabsolutions.com/order-now.php](https://www.matlabsolutions.com/order-now.php)
- **Email:** info@matlabsolutions.com

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
