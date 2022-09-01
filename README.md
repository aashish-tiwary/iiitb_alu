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
     * OpenSTA - Performs static timing analysis on the resulting netlist to generate timing reports
2. Floorplan and PDN
     * init_fp - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
     * ioplacer - Places the macro input and output ports
     * pdn - Generates the power distribution network
     * tapcell - Inserts welltap and decap cells in the floorplan
3. Placement
    * RePLace - Performs global placement
    * Resizer - Performs optional optimizations on the design
    * OpenDP - Perfroms detailed placement to legalize the globally placed components
4. CTS
    * TritonCTS - Synthesizes the clock distribution network (the clock tree)
5. Routing
    * FastRoute - Performs global routing to generate a guide file for the detailed router
    * CU-GR - Another option for performing global routing.
    * TritonRoute - Performs detailed routing
    * SPEF-Extractor - Performs SPEF extraction
6. GDSII Generation
    * Magic - Streams out the final GDSII layout file from the routed def
    * Klayout - Streams out the final GDSII layout file from the routed def as a back-up
7. Checks
    * Magic - Performs DRC Checks & Antenna Checks
    * Klayout - Performs DRC Checks
    * Netgen - Performs LVS Checks
    * CVC - Performs Circuit Validity Checks

**OpenLANE Files**
The openLANE file structure looks something like this:

* skywater-pdk: contains PDK files provided by foundry
* open_pdks: contains scripts to setup pdks for opensource tools
* sky130A: contains sky130 pdk files
* Invoking OpenLANE and Design Preparation
* Openlane can be invoked using docker command followed by opening an interactive session. flow.tcl is a script that specifies details for openLANE flow.
# Tools used for physical Design
# Python Installation
```
$ sudo apt install -y build-essential python3 python3-venv python3-pip
```
# Docker Installation
```
$ sudo apt-get remove docker docker-engine docker.io containerd runc (removes older version of docker if installed)

$ sudo apt-get update

$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
$ sudo mkdir -p /etc/apt/keyrings

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
$ sudo apt-get update

$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

$ apt-cache madison docker-ce (copy the version string you want to install)

$ sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io docker-compose-plugin (paste the version string copies in place of <VERSION_STRING>)

$ sudo docker run hello-world (If the docker is successfully installed u will get a success message here)
```
# OpenLane Installation
```
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git

$ cd OpenLane/

$ make

$ make test
```
# Magic Installation
For Magic to be installed and work properly the following softwares have to be installed first:
## Installing csh
``` $ sudo apt-get install csh ```
## Installing x11/xorg
``` $ sudo apt-get install x11

$ sudo apt-get install xorg

$ sudo apt-get install xorg openbox
``` 
## Installing GCC
``` $ sudo apt-get install gcc ```
## Installing build-essential
``` $ sudo apt-get install build-essential ```
## Installing OpenGL
``` $ sudo apt-get install freeglut3-dev ```
## Installing tcl/tk
``` $ sudo apt-get install tcl-dev tk-dev ```
## Installing magic
After all the softwares are installed, run the following commands for installing magic:
``` $ git clone https://github.com/RTimothyEdwards/magic

$ cd magic

$ ./configure

$ make

$ make install
```
## Klayout Installation
``` $ sudo apt-get install klayout ```
## ngspice Installation
``` $ sudo apt-get install ngspice ```
# Creating a Custom Inverter Cell
Open Terminal in the folder you want to create the custom inverter cell.
```
$ git clone https://github.com/nickson-jose/vsdstdcelldesign.git

$ cd vsdstdcelldesign

$  cp ./libs/sky130A.tech sky130A.tech

$ magic -T sky130A.tech sky130_inv.mag &
```
![image](https://user-images.githubusercontent.com/110485513/187850071-8a66f09b-d726-483b-b746-8120f7215333.png)

The above layout will open. The design can be verified and various layers can be seen and examined by selecting the area of examination and type what in the tcl window.
To extract Spice netlist, Type the following commands in tcl window.
```
% extract all

% ext2spice cthresh 0 rthresh 0

% ext2spice
```
```cthresh 0 rthresh 0 ``` is used to extract parasitic capacitances from the cell.

![image](https://user-images.githubusercontent.com/110485513/187851357-8ca3d9e0-78a3-4030-9a91-ffa792b82411.png)

The spice netlist has to be edited to add the libraries we are using, The final spice netlist should look like the following:

```
* SPICE3 file created from sky130_inv.ext - technology: sky130A
342
​
343
.option scale=10000u
344
​
345
.subckt sky130_inv A Y VPWR VGND
346
M1000 Y A VPWR VPWR pshort w=37 l=23
347
+  ad=1443 pd=152 as=1517 ps=156
348
M1001 Y A VGND VGND nshort w=35 l=23
349
+  ad=1435 pd=152 as=1365 ps=148
350
C0 VPWR A 0.07fF
351
C1 VPWR Y 0.11fF
352
C2 Y A 0.05fF
353
C3 Y VGND 0.24fF
354
C4 VPWR VGND 0.59fF
355
.ends
```
Open the terminal in the directory where ngspice is stored and type the following command, ngspice console will open:
``` $ ngspice sky130_inv.spice  ```
Now you can plot the graphs for the designed inverter model.
``` -> plot y vs time a ```
Four timing parameters are used to characterize the inverter standard cell:

1. Rise time: Time taken for the output to rise from 20% of max value to 80% of max value
``` Rise time = (2.23843 - 2.17935) = 59.08ps ```
2. Fall time- Time taken for the output to fall from 80% of max value to 20% of max value
``` Fall time = (4.09291 - 4.05004) = 42.87ps ```
3. Cell rise delay = time(50% output rise) - time(50% input fall)
``` Cell rise delay = (2.20636 - 2.15) = 56.36ps ```
4. Cell fall delay = time(50% output fall) - time(50% input rise)
``` Cell fall delay = (4.07479 - 4.05) = 24.79ps ```

To get a grid and to ensure the ports are placed correctly we can use

``` % grid 0.46um 0.34um 0.23um 0.17um ```

![image](https://user-images.githubusercontent.com/110485513/187854951-7c487c9d-e0c7-4f76-ad4e-44f4b4ef55e5.png)

# Layout
## Preparation
The layout is generated using OpenLane. To run a custom design on openlane, Navigate to the openlane folder and run the following commands:
```
$ cd designs

$ mkdir iiitb_alu

$ cd iiitb_alu

$ mkdir src

$ touch config.json

$ cd src

$ touch iiitb_alu.v
```
The iiitb_alu.v file should contain the verilog RTL code you have used and got the post synthesis simulation for.
Copy ```sky130_fd_sc_hd__fast.lib, sky130_fd_sc_hd__slow.lib, sky130_fd_sc_hd__typical.lib and sky130_vsdinv.lef``` files to ```src``` folder in your design.
The final src folder should look like this:
???????????
The contents of the config.json are as follows. this can be modified specifically for your design as and when required.
```
{
    "DESIGN_NAME": "iiitb_alu",
    "VERILOG_FILES": "dir::src/iiitb_alu.v",
    "CLOCK_PORT": "clk",
    "CLOCK_NET": "clk",
    "GLB_RESIZER_TIMING_OPTIMIZATIONS": true,
    "CLOCK_PERIOD": 10,
    "PL_TARGET_DENSITY": 0.7,
    "FP_SIZING" : "relative",
    "pdk::sky130*": {
        "FP_CORE_UTIL": 30,
        "scl::sky130_fd_sc_hd": {
            "FP_CORE_UTIL": 20
        }
    },
    
    "LIB_SYNTH": "dir::src/sky130_fd_sc_hd__typical.lib",
    "LIB_FASTEST": "dir::src/sky130_fd_sc_hd__fast.lib",
    "LIB_SLOWEST": "dir::src/sky130_fd_sc_hd__slow.lib",
    "LIB_TYPICAL": "dir::src/sky130_fd_sc_hd__typical.lib",  
    "TEST_EXTERNAL_GLOB": "dir::../iiitb_alu/src/*"


}
```
Save all the changes made above and Navigate to the openlane folder in terminal and give the following command :
``` $ sudo make mount ```

![image](https://user-images.githubusercontent.com/110485513/187857942-2fc7d26b-e845-4d82-9f26-ef8643e9374d.png)

After entering the openlane container give the following command:

``` $ ./flow.tcl -interactive ```

![image](https://user-images.githubusercontent.com/110485513/187863681-48c5acf2-5510-4959-a041-af45ab4a3228.png)

This command will take you into the tcl console. In the tcl console type the following commands:

``` % package require openlane 0.9 ```

![image](https://user-images.githubusercontent.com/110485513/187863898-36ce2e74-af8c-4bee-aeaa-234cf92673c3.png)

``` prep -design iiitb_freqdiv ```
![image](https://user-images.githubusercontent.com/110485513/187864155-1a95210b-d604-4363-bf27-a29f30ba3902.png)

The following commands are to merge external the lef files to the merged.nom.lef. In our case sky130_vsdiat is getting merged to the lef file
``` set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
     add_lefs -src $lefs
``` 
# Synthesis
``` % run_synthesis ```

![image](https://user-images.githubusercontent.com/110485513/187870973-6b3bbb32-0a82-4a4b-bcf4-9a412333c6bb.png)

## Synthesis Reports
Details of the gates used

![image](https://user-images.githubusercontent.com/110485513/187872051-7e749fb7-06f8-4294-9a11-12614b3f886d.png)

```
Flop Ratio = Ratio of total number of flip flops / Total number of cells present in the design = 8/145 = 0.05517
```
The sky130_vsdinv should also reflect in your netlist after synthesis

![image](https://user-images.githubusercontent.com/110485513/187873984-2710f1f2-3509-40a6-a11a-28f72e1a07e9.png)

## Floorplan

``` % run_floorplan ```

![image](https://user-images.githubusercontent.com/110485513/187874314-294cf2b3-7fc0-49cb-b8bc-b5ed5160b989.png)

## Floorplan Reports
Die Area
![image](https://user-images.githubusercontent.com/110485513/187874857-a50c2a77-f454-4a7a-a3e7-ce83e244b498.png)

Core Area
![image](https://user-images.githubusercontent.com/110485513/187875305-1df8fa3c-1f90-4f63-b871-e5b02c5adfb9.png)

Navigate to results->floorplan and type the Magic command in terminal to open the floorplan
```
$ magic -T /home/aashish/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read ../../tmp/merged.nom.lef def read iiitb_alu.def &
```
![image](https://user-images.githubusercontent.com/110485513/187876570-9a287e08-3bc4-4d2a-9877-406e3f804c9d.png)

Floorplan view
![image](https://user-images.githubusercontent.com/110485513/187876983-dd4b8462-c2cb-4da1-9391-fbb5532b80d4.png)

All the cells are placed in the left corner of the floorplan

![image](https://user-images.githubusercontent.com/110485513/187877205-69e351ab-8b98-4f0d-9067-983429e00e62.png)

# Placement
```
run_placement
```

![image](https://user-images.githubusercontent.com/110485513/187877779-d06b7321-5a6b-42b0-a1e7-12c7a83c364b.png)

## Placement Reports
Navigate to results->placement and type the Magic command in terminal to open the placement view
```
$ magic -T /home/himanshu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read lef ../../tmp/merged.max.lef def read iiitb_alu.def &

```
![image](https://user-images.githubusercontent.com/110485513/187879039-408b9740-599b-431f-a0b7-953bc72c782b.png)

Placement View

![image](https://user-images.githubusercontent.com/110485513/187879240-2b878ca2-d1ab-420a-acac-2cf3734cda47.png)

![image](https://user-images.githubusercontent.com/110485513/187879553-8a7bb63c-02e7-4625-90d4-03ea1aa98f6e.png)

sky130_vsdinv in the placement view :
?????

The sky130_vsdinv should also reflect in your netlist after placement

![image](https://user-images.githubusercontent.com/110485513/187883307-2dac4dca-a863-4fbd-a34c-40da9ac74b55.png)

# Clock Tree Synthesis
```
% run_cts
```
![image](https://user-images.githubusercontent.com/110485513/187883897-d941e97d-b1c9-49bb-bb7c-ef38578f26ae.png)

# Routing
```
% run_routing
```
![image](https://user-images.githubusercontent.com/110485513/187884376-ba9dad45-ec51-45f0-9fe0-0a9ec2996574.png)


# Routing Reports
Navigate to results->routing and type the Magic command in terminal to open the routing view
```
 $ magic -T /home/himanshu/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech read lef ../../tmp/merged.max.lef def read iiitb_alu.def &
```
![image](https://user-images.githubusercontent.com/110485513/187884841-67c06171-71f4-4375-81ea-e66c3d173c19.png)

Routing View

![image](https://user-images.githubusercontent.com/110485513/187885000-8bc21b03-7bb4-4033-a8dc-5dfc7b277cb6.png)

The sky130_vsdinv should also reflect in your netlist after routing

![image](https://user-images.githubusercontent.com/110485513/187886087-ae16147b-fe09-4986-930d-ade00d910e4e.png)


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
