DESIGN OF AHB TO APB BRIDGE
The Advanced Microcontroller Bus Architecture (AMBA) specification defines an on-chip communications standard for designing high-performance embedded microcontrollers. Three distinct buses are defined within the AMBA specification:

Advanced High-performance Bus (AHB)

Advanced System Bus (ASB)

Advanced Peripheral Bus (APB)

Overview / Description
This project focuses on designing a high-performance bridge to connect the Advanced High-performance Bus (AHB) with the Advanced Peripheral Bus (APB), facilitating communication between high-speed masters and low-speed peripheral devices. The bridge ensures protocol compatibility, efficient data transfer, and proper handshaking mechanisms.

Features
1)Supports AHB master transactions (read/write).

2)Converts AHB signals to APB-compliant signals.

3)Handles multiple APB peripherals using address decoding.

4)Implements proper handshaking and wait-state generation.

5)Easily integrable into larger SoC designs.

Architecture
The bridge architecture consists of the following blocks:

AHB Interface – Receives address, control, and data from AHB master.

Address Decoder – Maps AHB addresses to specific APB peripherals.

Control & Handshaking Logic – Generates APB select and enable signals.

APB Interface – Drives APB read/write transactions to the slave peripherals.

Design Files
File Name	Description
ahb_to_apb_bridge.sv	Main RTL module for the bridge
ahb_master.sv	Optional AHB master module for testing
apb_slave.sv	APB slave peripheral module(s)
tb_ahb_apb_bridge.sv	Testbench for functional verification
compile_sim.tcl	Simulation compile/run script (optional)
Simulation
Tools Required: ModelSim, Xcelium, or Vivado Simulator

Simulation Steps:

Compile all design files:

vlog ahb_to_apb_bridge.sv ahb_master.sv apb_slave.sv tb_ahb_apb_bridge.sv

Run the testbench:

vsim tb_ahb_apb_bridge run -all

Requirements
HDL Simulator: ModelSim, Xcelium, or Vivado Simulator

System: Windows/Linux with basic Verilog/SystemVerilog environment

Dependencies: No external libraries required

Results
Simulation of the bridge should produce:

Correct waveform showing data transfer from AHB to APB peripherals.

Address decoding correctly selecting the target APB peripheral.

Read/write operations completing without error or data corruption.

Future Work / Improvements
Support for AHB burst transfers to improve throughput.

Implement low-power optimizations using clock gating or power-aware logic.

Expand support for additional APB peripherals with dynamic mapping.

Integrate with real SoC designs and perform timing analysis.

References
1)ARM AMBA AHB & APB Protocol Specification

2)Digital Design and Computer Architecture – David Harris, Sarah Harris

3)Online tutorials on SystemVerilog-based bus interface design
