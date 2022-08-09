odule tb_alu;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] Op;

    // Outputs
    wire [7:0] R;

    // Instantiate the Unit Under Test (UUT)
    ALU uut ( 
        .A(A), 
        .B(B), 
        .Op(Op), 
        .R(R)
    );
    
    initial begin
        // Apply inputs.
        A = 8'b01101010;
        B = 8'b00111011;
        Op = 0; #100;
        Op = 1; #100;
        Op = 2; #100;
        Op = 3; #100;
        Op = 4; #100;
        Op = 5; #100;
        Op = 6; #100;
        Op = 7; #100;
    end
      
endmodule
