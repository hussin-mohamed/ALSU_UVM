# ALSU_UVM
# Overview
This project involves verifying the Arithmetic Logic and Shift Unit (ALSU) using the Universal Verification Methodology (UVM) and SystemVerilog. The ALSU module performs basic arithmetic, logic, and shift operations, and the verification environment ensures its functional correctness by applying a structured UVM methodology.

The goal of this project is to develop a robust testbench that validates the ALSU's functionality against its specification, covering all corner cases and edge conditions. The project achieves 100% functional and code coverage and involves debugging and fixing design issues identified during the verification process.

# Features
UVM-Based Testbench: A complete UVM verification environment, including agents, drivers, monitors, and scoreboards.
Assertions: Assertions are used to check key states and conditions in the ALSU, ensuring operations such as shifts, logical operations, and arithmetic functions are correct.
Functional Coverage: Coverage points for all operational modes, including edge cases like overflows and underflows.
Sequence Generation: Randomized test sequences generated for thorough testing of the ALSU's capabilities.
Design Under Test (DUT): The ALSU module that performs arithmetic, logic, and shift operations.
# Directory Structure
doc: Project documentation, including ALSU specifications.

src: Source files for ALSU design in SystemVerilog.

tb: Testbench files, including UVM components like agents, scoreboard, and sequences.

sim: Simulation directory, where results and logs are stored.

# How to Run the Simulation
Set Up the Environment: Ensure you have the necessary simulation tools installed (such as QuestaSim or ModelSim).

Compile the Testbench: Use the provided Makefile or a similar method to compile the project.

Run the Simulation: After compiling, run the simulation to execute the testbench on the ALSU.

Analyze the Results: Upon completion, review the coverage and assertion reports generated.

# Key Components
ALSU Interface: Connects the UVM components to the ALSU module for communication.

ALSU Agent: Includes both a driver and a monitor. The driver sends sequences to the ALSU, while the monitor observes and compares the responses using the scoreboard.

ALSU Scoreboard: Compares the actual output from the ALSU with the expected output to identify errors.

ALSU Coverage: Ensures that all important functionalities of the ALSU are covered by the tests.

# Features Tested
Arithmetic Operations: Addition, Multiplication.

Logic Operations: OR, XOR.

Shift Operations: Left shift, right shift, and rotaions.

Corner Cases: Handling of overflow, and edge-case values.

Error Conditions: Verifies if the ALSU handles invalid operations or states correctly.

# UVM testbench
![fifo_uvm_testbench drawio](https://github.com/user-attachments/assets/c40266b8-da4e-4ed1-8a05-fc6014f54ec3)
