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
# Applications
Processor Applications

Logical calculations

Arithmatic Calculations
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

# Synthesis
**Synthesis:** Synthesis transforms the simple RTL design into a gate-level netlist with all the constraints as specified by the designer. In simple language, Synthesis is a process that converts the abstract form of design to a properly implemented chip in terms of logic gates.

Synthesis takes place in multiple steps:

* Converting RTL into simple logic gates.
* Mapping those gates to actual technology-dependent logic gates available in the technology libraries.
* Optimizing the mapped netlist keeping the constraints set by the designer intact.
**Synthesizer:** It is a tool we use to convert out RTL design code to netlist. Yosys is the tool I've used in this project.

**About Yosys**
Yosys is a framework for Verilog RTL synthesis. It currently has extensive Verilog-2005 support and provides a basic set of synthesis algorithms for various application domains.

more at https://yosyshq.net/yosys/
To install yosys follow the instructions in this github repository

* https://github.com/YosysHQ/yosys
Now you need to create a yosys_run.sh file , which is the yosys script file used to run the synthesis. The contents of the yosys_run file are given below:

note: Identify the .lib file path in cloned folder and change the path in highlighted text to indentified path
```
# read design

read_verilog iiitb_alu.v

# generic synthesis
synth -top iiitb_alu

# mapping to mycells.lib
dfflibmap -liberty /home/aashish/asic/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/aashish/asic/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_alu_synth.v
show
stat
```
Now, in the terminal of your verilog files folder, run the following commands:
to synthesize
```
$   yosys
$   yosys>    script yosys_run.sh
```
to see diffarent types of cells after synthesys
```
$   yosys>    stat
```
to generate schematics
```
$   yosys>    show
```
Now the synthesized netlist is written in "iiitb_alu_synth.v" file.
**GATE LEVEL SIMULATION(GLS)**

GLS is generating the simulation output by running test bench with netlist file generated from synthesis as design under test. Netlist is logically same as RTL code, therefore, same test bench can be used for it.We perform this to verify logical correctness of the design after synthesizing it. Also ensuring the timing of the design is met. Folllowing are the commands to run the GLS simulation:
```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 primitives.v sky130_fd_sc_hd.v iiitb_alu_synth.v iiitb_alu_tb.v
```
The gtkwave output for the netlist should match the output waveform for the RTL design file. As netlist and design code have same set of inputs and outputs, we can use the same testbench and compare the waveforms.

#GLS Waveforms

![Gls Waveform](https://user-images.githubusercontent.com/110485513/185358744-8c19ca0d-e1a7-448b-8453-4403b0f85453.png)

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
