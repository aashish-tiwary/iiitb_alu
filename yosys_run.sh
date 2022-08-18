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
