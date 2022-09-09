module iiitb_alu_tb;

// Inputs
reg [7:0] A;
reg [7:0] B;
reg [2:0] op;
reg clk;

// Outputs
wire [7:0] R;

// Instantiate the Unit Under Test (UUT)
iiitb_alu uut ( 
.clk(clk),
.A(A), 
.B(B), 
.op(op), 
.R(R)
);
    
initial begin

$dumpfile ("iiitb_alu_out.vcd"); 
$dumpvars(0,iiitb_alu_tb);

// Initialize Inputs

clk = 0;

end
always 
#100 clk=~clk;
    
initial begin
// Apply inputs.
A = 8'b01101010;
B = 8'b00111011;
op = 0; #100;
op = 1; #100;
op = 2; #100;
op = 3; #100;
op = 4; #100;
op = 5; #100;
op = 6; #100;
op = 7; #100;
end

endmodule
