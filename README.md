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
* Processor Applications
* Logical calculations
* Arithmatic Calculations
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

# GLS Waveforms

![Gls Waveform](https://user-images.githubusercontent.com/110485513/185358744-8c19ca0d-e1a7-448b-8453-4403b0f85453.png)

# Advance Physical Design Using OpenLANE/Sky130
OpenLANE is an opensource tool or flow used for opensource tape-outs. The OpenLANE flow comprises a variety of tools such as Yosys, ABC, OpenSTA, Fault, OpenROAD app, Netgen and Magic which are used to harden chips and macros, i.e. generate final GDSII from the design RTL. The primary goal of OpenLANE is to produce clean GDSII with no human intervention. OpenLANE has been tuned to function for the Google-Skywater130 Opensource Process Design Kit.

**SoC Design & OpenLANE**

Components of opensource digital ASIC design
The design of digital Application Specific Integrated Circuit (ASIC) requires three enablers or elements - Resistor Transistor Logic Intellectual Property (RTL IPs), Electronic Design Automation (EDA) Tools and Process Design Kit (PDK) data.

![image](https://user-images.githubusercontent.com/110485513/187842672-e0c003c2-7355-4c00-8c60-8a49030fec70.png)

 * Opensource RTL Designs: github, librecores, opencores
 * Opensource EDA tools: QFlow, OpenROAD, OpenLANE
 * Opensource PDK data: Google Skywater130 PDK

The ASIC flow objective is to convert RTL design to GDSII format used for final layout. The flow is essentially a software also known as automated PnR (Place & route).

This project is done in the course "Advanced Physical Design using OpenLANE/Sky130" by VLSI System Design Corporation. In this project a complete RTL to GDSII flow for PicoRV32a SoC is executed with Openlane using Skywater130nm PDK. Custom designed standard cells with Sky130 PDK are also used in the flow. Timing Optimisations are carried out. Slack violations are removed. DRC is verified.

![image](https://user-images.githubusercontent.com/110485513/187840332-0a8269cf-d90a-45e4-93fa-2d4354a533b3.png)

**OpenLANE ASIC Flow**
![image](https://user-images.githubusercontent.com/110485513/187843298-571e2d9c-882c-4d59-9b40-642cdb57d422.png)

From conception to product, the ASIC design flow is an iterative process that is not static for every design. The details of the flow may change depending on ECO’s, IP requirements, DFT insertion, and SDC constraints, however the base concepts still remain. The flow can be broken down into 11 steps:

1. Architectural Design – A system engineer will provide the VLSI engineer with specifications for the system that are determined through physical constraints. The VLSI engineer will be required to design a circuit that meets these constraints at a microarchitecture modeling level.

2. RTL Design/Behavioral Modeling – RTL design and behavioral modeling are performed with a hardware description language (HDL). EDA tools will use the HDL to perform mapping of higher-level components to the transistor level needed for physical implementation. HDL modeling is normally performed using either Verilog or VHDL. One of two design methods may be employed while creating the HDL of a microarchitecture:

    a. RTL Design – Stands for Register Transfer Level. It provides an abstraction of the digital circuit using:

       * i. Combinational logic
       * ii. Registers
       * iii. Modules (IP’s or Soft Macros)
    b. Behavioral Modeling – Allows the microarchitecture modeling to be performed with behavior-based modeling in HDL. This method bridges the gap between C and HDL allowing HDL design to be performed

3. RTL Verification - Behavioral verification of design

4. DFT Insertion - Design-for-Test Circuit Insertion

5. Logic Synthesis – Logic synthesis uses the RTL netlist to perform HDL technology mapping. The synthesis process is normally performed in two major steps:

    * GTECH Mapping – Consists of mapping the HDL netlist to generic gates what are used to perform logical optimization based on AIGERs and other topologies created from the generic mapped netlist.

    * Technology Mapping – Consists of mapping the post-optimized GTECH netlist to standard cells described in the PDK

6. Sandard Cells – Standard cells are fixed height and a multiple of unit size width. This width is an integer multiple of the SITE size or the PR boundary. Each standard cell comes with SPICE, HDL, liberty, layout (detailed and abstract) files used by different tools at different stages in the RTL2GDS flow.

7. Post-Synthesis STA Analysis: Performs setup analysis on different path groups.

8. Floorplanning – Goal is to plan the silicon area and create a robust power distribution network (PDN) to power each of the individual components of the synthesized netlist. In addition, macro placement and blockages must be defined before placement occurs to ensure a legalized GDS file. In power planning we create the ring which is connected to the pads which brings power around the edges of the chip. We also include power straps to bring power to the middle of the chip using higher metal layers which reduces IR drop and electro-migration problem.

9. Placement – Place the standard cells on the floorplane rows, aligned with sites defined in the technology lef file. Placement is done in two steps: Global and Detailed. In Global placement tries to find optimal position for all cells but they may be overlapping and not aligned to rows, detailed placement takes the global placement and legalizes all of the placements trying to adhere to what the global placement wants.

10. CTS – Clock tree synteshsis is used to create the clock distribution network that is used to deliver the clock to all sequential elements. The main goal is to create a network with minimal skew across the chip. H-trees are a common network topology that is used to achieve this goal.

11. Routing – Implements the interconnect system between standard cells using the remaining available metal layers after CTS and PDN generation. The routing is performed on routing grids to ensure minimal DRC errors.

**Opensource EDA tools**
OpenLANE utilises a variety of opensource tools in the execution of the ASIC flow:

![image](https://user-images.githubusercontent.com/110485513/187844211-8c82e3ce-4549-4d72-9bd1-02322351fb51.png)

OpenLANE design stages
1. Synthesis
* yosys - Performs RTL synthesis
* abc - Performs technology mapping
OpenSTA - Performs static timing analysis on the resulting netlist to generate timing reports
Floorplan and PDN
init_fp - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
ioplacer - Places the macro input and output ports
pdn - Generates the power distribution network
tapcell - Inserts welltap and decap cells in the floorplan
Placement
RePLace - Performs global placement
Resizer - Performs optional optimizations on the design
OpenDP - Perfroms detailed placement to legalize the globally placed components
CTS
TritonCTS - Synthesizes the clock distribution network (the clock tree)
Routing
FastRoute - Performs global routing to generate a guide file for the detailed router
CU-GR - Another option for performing global routing.
TritonRoute - Performs detailed routing
SPEF-Extractor - Performs SPEF extraction
GDSII Generation
Magic - Streams out the final GDSII layout file from the routed def
Klayout - Streams out the final GDSII layout file from the routed def as a back-up
Checks
Magic - Performs DRC Checks & Antenna Checks
Klayout - Performs DRC Checks
Netgen - Performs LVS Checks
CVC - Performs Circuit Validity Checks

# Contributors
* Aashish Tiwary
* Kunal Ghosh
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
