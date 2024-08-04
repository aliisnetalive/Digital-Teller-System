# Digital Teller System

This project implements a digital teller system using Verilog. The system includes modules for counting, displaying values on a 7-segment display, managing teller statuses, and reading predefined waiting times from a ROM.

## Project Structure

### Files

- **main.v**: Contains the Verilog code for the entire project.
- **waiting_time.txt**: A text file containing hexadecimal values representing waiting times.

### Modules

1. **ROM**
    - **Inputs**: `count` (3 bits), `teller` (2 bits)
    - **Output**: `data` (5 bits)
    - **Description**: Reads waiting times from the `waiting_time.txt` file and provides the data based on the combined address of `teller` and `count`.

2. **sevensegment**
    - **Input**: `data` (5 bits)
    - **Output**: `display` (7 bits)
    - **Description**: Converts a 5-bit binary input into a 7-segment display output for numbers 0-9.

3. **Teller**
    - **Inputs**: `teller1`, `teller2`, `teller3` (1 bit each)
    - **Output**: `tellersCount` (2 bits)
    - **Description**: Determines the number of active tellers based on three input signals.

4. **Control_Unit**
    - **Inputs**: `up`, `down`, `reset`, `T1`, `T2`, `T3` (1 bit each)
    - **Outputs**: `count` (3 bits), `time_segment`, `count_segment` (7 bits each), `empty`, `full` (1 bit each)
    - **Description**: Manages counting, displaying the count, and displaying a corresponding time from the ROM.

5. **counter**
    - **Inputs**: `up`, `down`, `reset` (1 bit each)
    - **Outputs**: `count` (3 bits), `full`, `empty` (1 bit each)
    - **Description**: Implements an up/down counter with a reset function and flags for full and empty states.

6. **Control_Unit_MUT**
    - **Description**: A test bench for the `Control_Unit`, applying various signals over time to test its behavior.

### `waiting_time.txt` File

The `waiting_time.txt` file contains 32 lines of 5-bit hexadecimal values representing waiting times. These values are loaded into the ROM at startup.


## How to Run the Project

1. **Setup**: Ensure you have a Verilog simulator (e.g., ModelSim, Vivado) installed on your system.
2. **Compilation**: Compile `main.v` using your Verilog simulator.
3. **Simulation**: Run the test bench `Control_Unit_MUT` to simulate the behavior of the system.
4. **Verification**: Observe the waveforms or outputs to verify the functionality of the digital teller system.

## Functionality Testing

The test bench `Control_Unit_MUT` applies various signals to the `Control_Unit` to test its behavior. Key scenarios include counting up, counting down, and resetting the counter. The outputs `time_segment` and `count_segment` display the current time and count on 7-segment displays.

## Contact

For any queries or support, please contact me at [alialiabed088@gmail.com].
``` &#8203;:citation[oaicite:0]{index=0}&#8203;
