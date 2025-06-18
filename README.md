# 4-bit Barrel Shifter in Verilog

## Overview

In this project, I implemented a 4-bit barrel shifter in Verilog using structural modeling. My goal was to create a circuit that shifts a 4-bit input either left or right by a specified amount (0 to 3 bits), controlled by a direction signal and a 2-bit shift amount. For example, with input 0110, a left shift by 1 (direction=1, shift_bit=01) produces 1100, while a right shift by 1 (direction=0, shift_bit=01) produces 0011. I used 4-to-1 and 2-to-1 multiplexers to select the appropriate shifted bits and wrote a testbench to verify the functionality with specific input cases. I confirmed the design works as expected through simulation.

Module: mux4X1





What I Did: I designed a 4-to-1 multiplexer as a building block for the shifters.



Inputs:





I[3:0]: 4-bit input data.



sel[1:0]: 2-bit select signal.



Outputs:





out: Selected output bit.



How It Works:





I used a continuous assignment: out = I[sel], selecting one of the four input bits based on the select signal.



Style: Behavioral modeling with a continuous assignment.

Module: mux2X1





What I Did: I designed a 2-to-1 multiplexer to choose between left and right shift outputs.



Inputs:





I[1:0]: 2-bit input data.



sel: 1-bit select signal.



Outputs:





out: Selected output bit.



How It Works:





I used a continuous assignment: out = I[sel], selecting one of the two input bits based on the select signal.



Style: Behavioral modeling with a continuous assignment.

Module: shift_right





What I Did: I designed a 4-bit right shifter using 4-to-1 multiplexers.



Inputs:





w[3:0]: 4-bit input to be shifted.



shift[1:0]: 2-bit shift amount (0 to 3).



Outputs:





y[3:0]: 4-bit right-shifted output.



How It Works:





I instantiated four mux4X1 modules, each selecting a bit for the output based on the shift amount.



The input connections to each multiplexer are arranged to perform a right shift (e.g., for y[3], inputs are {w[2], w[1], w[0], w[3]} for shifts of 0, 1, 2, 3).



For example, with w=0110 and shift=01:





y[3] = w[2] = 0



y[2] = w[1] = 1



y[1] = w[0] = 1



y[0] = w[3] = 0



Output: y=0011



Style: Structural modeling with multiplexers.

Module: shift_left





What I Did: I designed a 4-bit left shifter using 4-to-1 multiplexers.



Inputs:





w[3:0]: 4-bit input to be shifted.



shift[1:0]: 2-bit shift amount (0 to 3).



Outputs:





y[3:0]: 4-bit left-shifted output.



How It Works:





I instantiated four mux4X1 modules, each selecting a bit for the output based on the shift amount.



The input connections to each multiplexer are arranged to perform a left shift (e.g., for y[3], inputs are {w[3], w[2], w[1], w[0]} for shifts of 0, 1, 2, 3).



For example, with w=0110 and shift=01:





y[3] = w[2] = 1



y[2] = w[1] = 1



y[1] = w[0] = 0



y[0] = w[3] = 0



Output: y=1100



Style: Structural modeling with multiplexers.

Module: barrel_shifter





What I Did: I designed a 4-bit barrel shifter that supports both left and right shifts.



Inputs:





in[3:0]: 4-bit input to be shifted.



direction: Direction control (1 for left, 0 for right).



shift_bit[2:0]: Shift amount (only 2 bits [1:0] are used).



Outputs:





out[3:0]: 4-bit shifted output.



How It Works:





I instantiated a shift_right module to compute the right-shifted output (t1).



I instantiated a shift_left module to compute the left-shifted output (t2).



I used four mux2X1 modules to select between t1[i] (right shift) and t2[i] (left shift) for each output bit, based on the direction signal.



For example, with in=0110, direction=1, shift_bit=01:





Left shift output: t2=1100



Right shift output: t1=0011



direction=1 selects t2, so out=1100.



Style: Structural modeling with shifters and multiplexers.

Testbench: testbench





What I Did: I created a testbench to verify the 4-bit barrel shifter.



How It Works:





I defined a 4-bit input in, a direction bit direction, a 2-bit shift amount shift_bit, and a 4-bit output y.



I tested two specific cases:





Case 1: in=0110, direction=1 (left), shift_bit=01 (shift by 1).



Case 2: in=0110, direction=0 (right), shift_bit=01 (shift by 1).



Each test case runs for 10ns, and I used $display to print the input, shift amount, direction, and output in binary format.



Time Scale: I set 1ns / 1ps for precise simulation timing.



Purpose: My testbench ensures the barrel shifter correctly performs left and right shifts for the specified input and shift amount.

Files





mux4X1.v: Verilog module for the 4-to-1 multiplexer.



mux2X1.v: Verilog module for the 2-to-1 multiplexer.



shift_right.v: Verilog module for the right shifter.



shift_left.v: Verilog module for the left shifter.



barrel_shifter.v: Verilog module for the barrel shifter.



testbench.v: Testbench for simulation.

## Circuit Diagram

Below is the circuit diagram for the 4-bit barrel shifter.


![Screenshot 2025-06-18 212610](https://github.com/user-attachments/assets/4849fbc7-a64b-479f-a102-8e800947ccb3)

## Simulation Waveform

Below is the simulation waveform, showing inputs in[3:0], direction, shift_bit[1:0], and output y[3:0] over time.


![Screenshot 2025-06-18 212252](https://github.com/user-attachments/assets/1e1e1701-a776-4d8b-902b-15e3d5e1bcbd)


## Console Output

Below is the console output from my testbench simulation.


![Screenshot 2025-06-18 212310](https://github.com/user-attachments/assets/137d7e04-32c8-4161-93f9-d6175bcbfc50)






input is 0110 shift=1 direction=1 output is 1100



input is 0110 shift=1 direction=0 output is 0011
