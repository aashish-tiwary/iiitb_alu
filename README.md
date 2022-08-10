# Arithmatic Logic Unit
ALU is a processor unit which performs the task
of addition, subtraction, multiplication, and division. In order to
support CPU for its arithmatic and logical processes, ALU has
AU (i.e) arithmatic unit and LU (i.e) Logical Unit. This paper
deals with its analysis and functioning of this important unit of
CPU using verilog.
# Introduction
An arithmatic logic unit is an important part of central
processing unit and performs arithmatic and logic operations.
It can take inputs as multiple bits through an input register.
It is the fundamental building block of the central processing
unit of a computer.The ALU is the mathematical brain of a
computer. The first ALU was INTEL 74181 implemented as
a 7400 series is a TTL integrated circuit that was released in
1970.[1]
# Description
This is a ALU model which receives two input operands ’A’
and ’B’ which are 8 bits long. The result is denoted by ’R’
which is also 8 bit long. The input signal ’Op’ is a 3 bit value
which tells the ALU what operation has to be performed by
the ALU. Since ’Op’ is 3 bits long we can have a maximum
of 2 3 = 8operations.[2] 

![ALU](https://user-images.githubusercontent.com/110485513/183733226-f09f742b-024a-4064-9e50-d9c7b03d7bb6.JPG)

This ALU is capable of doing the following operations: Add
Signed : R = A + B ( Treating A, B, and R as signed two’s
complement integers.) Subtract Signed : R = A - B (Treating
A, B, and R as signed two’s complement integers.) Bitwise
AND : R(i) = A(i) AND B(i). Bitwise NOR : R(i) = A(i)
NOR B(i). Bitwise OR : R(i) = A(i) OR B(i). Bitwise NAND
: R(i) = A(i) NAND B(i). Bitwise XOR : R(i) = A(i) XOR
B(i). Biwise NOT : R(i) = NOT A(i).
![BasicBlockDiagram](https://user-images.githubusercontent.com/110485513/183733199-b26eac47-a5c7-4687-9595-8458340d26d4.jpg)
# Output Waveform
![output](https://user-images.githubusercontent.com/110485513/183733693-34f8a02b-40c4-4e0e-89f2-94c457e310af.png)
# About iverilog
Icarus Verilog is an implementation of the Verilog hardware description language.

# About GTKWave
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing

# Installing iverilog and GTKWave
For Ubuntu
Open your terminal and type the following to install iverilog and GTKWave
```
$   sudo apt-get update
$   sudo apt-get install iverilog gtkwave
```
# Functional Simulation
To clone the Repository and download the Netlist files for Simulation, enter the following commands in your terminal.
```
$   sudo apt install -y git
$   git clone https://https://github.com/aashish-tiwary/ALU
$   cd iiitb_ALU
$   iverilog iiitb_ALU.v iiitb_module_tb_alu.v
$   ./a.out
$   gtkwave ALU.vcd
```
# Functional Characteristics
![ALU_sim](https://user-images.githubusercontent.com/110485513/183991147-e5a41ab6-8fb2-487e-9de5-9befe8322b56.jpg)

# Contributors
**Aashish Tiwary**
**Kunal Ghosh**
# Acknowledgments
Kunal Ghosh, Director, VSD Corp. Pvt. Ltd.
# Contact Information
Aashish Tiwary, Postgraduate Student, International Institute of Information Technology, Bangalore aashish.tiwary@iiitb.ac.in
Kunal Ghosh, Director, VSD Corp. Pvt. Ltd. kunalghosh@gmail.com
# References:
[1] https://www.geeksforgeeks.org/introduction-of-alu-and-data-path/,
some content was taken from here.

[2] https://verilogcodes.blogspot.com/2015/10/verilog-code-for-simple-alu.
verilog code was taken from here.
