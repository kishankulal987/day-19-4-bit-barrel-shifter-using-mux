`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2025 20:43:26
// Design Name: 
// Module Name: barrel_shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mux4X1(input [3:0]I,input [1:0]sel,output out);
assign out=I[sel];
endmodule

module mux2X1(input [1:0]I,input sel,output out);
assign out=I[sel];
endmodule

module shift_right(input[3:0]w,input [1:0]shift,output [3:0]y);
mux4X1 m1({w[2],w[1],w[0],w[3]},shift,y[3]);
mux4X1 m2({w[1],w[0],w[3],w[2]},shift,y[2]);
mux4X1 m3({w[0],w[3],w[2],w[1]},shift,y[1]);
mux4X1 m4({w[3],w[2],w[1],w[0]},shift,y[0]);
endmodule 

module shift_left (input [3:0] w,input [1:0] shift,output [3:0] y);

mux4X1 m1({w[3], w[2], w[1], w[0]}, shift, y[3]);
mux4X1 m2({w[2], w[1], w[0], w[3]}, shift, y[2]); 
mux4X1 m3({w[1], w[0], w[3], w[2]}, shift, y[1]); 
mux4X1 m4({w[0], w[3], w[2], w[1]}, shift, y[0]); 

endmodule

module barrel_shifter(input [3:0]in,input direction,input [2:0]shift_bit,output [3:0]out);
wire [3:0]t1,t2;

shift_right m1(in,shift_bit,t1);
shift_left m2(in,shift_bit,t2);

mux2X1 U1({t1[0],t2[0]},direction,out[0]);
mux2X1 U2({t1[1],t2[1]},direction,out[1]);
mux2X1 U3({t1[2],t2[2]},direction,out[2]);
mux2X1 U4({t1[3],t2[3]},direction,out[3]);

endmodule


module testbench();
reg [3:0]in;
reg direction;
reg [1:0]shift_bit;
wire [3:0]y;
barrel_shifter m1(in,direction,shift_bit,y);
initial begin
in=4'b0110;
direction=1;
shift_bit=2'b01;
#10;
$display(" input is %b shift=%d direction =%b output is %b",in,shift_bit,direction,y);

in=4'b0110;
direction=0;
shift_bit=2'b01;
#10;
$display(" input is %b shift=%d direction =%b output is %b",in,shift_bit,direction,y);
$finish;
end
endmodule

