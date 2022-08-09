//Verilog module for an ALU
module ALU(
    A,
    B,
    Op,
    R   );
    
    //inputs,outputs and internal variables declared here
    input [7:0] A,B;
    input [2:0] Op;
    output [7:0] R;
    wire [7:0] Reg1,Reg2;
    reg [7:0] Reg3;
    
    //Assign A and B to internal variables for doing operations
    assign Reg1 = A;
    assign Reg2 = B;
    //Assign the output 
    assign R = Reg3;

    //Always block with inputs in the sensitivity list.
    always @(Op or Reg1 or Reg2)
    begin
        case (Op)
            0 : Reg3 = Reg1 + Reg2;  //addition
         1 : Reg3 = Reg1 - Reg2; //subtraction
         2 : Reg3 = ~Reg1;  //NOT gate
         3 : Reg3 = ~(Reg1 & Reg2); //NAND gate 
         4 : Reg3 = ~(Reg1 | Reg2); //NOR gate               
         5 : Reg3 = Reg1 & Reg2;  //AND gate
         6 : Reg3 = Reg1 | Reg2;  //OR gate    
         7 : Reg3 = Reg1 ^ Reg2; //XOR gate  
        endcase 
    end
    
endmodule
