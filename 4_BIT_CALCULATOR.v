`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2026 11:23:03
// Design Name: 
// Module Name: 4_BIT_CALCULATOR
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

//adder circuit
module full_adder(
 input a,
 input b,
 input cin,
 output sum,
 output carry
 );
 assign sum = a^b^cin;
 assign carry=(a&b)|(b&cin)|(a&cin);
endmodule

module ripple_carry_adder(
input [3:0] A,
input [3:0] B,
input cin,
output [3:0] sum,
output out);
wire c1,c2,c3;
full_adder f0(A[0],B[0],cin,sum[0],c1);
full_adder f1(A[1],B[1],c1,sum[1],c2);
full_adder f2(A[2],B[2],c2,sum[2],c3);
full_adder f3(A[3],B[3],c3,sum[3],out);
endmodule
//  subtractor circuit
module full_subtractor(
input a,
input b,
input borrow_in,
output sub,
output borrow_out);

assign sub = a^b^borrow_in;

assign borrow_out=(((~a)&b)|((~a)&borrow_in)|(b&borrow_in));
endmodule
module binary_subtractor(
input [3:0] A,
input [3:0] B,
input borrow_in,
output [3:0]sub,
output borrow
);
wire b1,b2,b3;
full_subtractor s0(A[0],B[0],borrow_in,sub[0],b1);
full_subtractor s1(A[1],B[1],b1,sub[1],b2);
full_subtractor s2(A[2],B[2],b2,sub[2],b3);
full_subtractor s3(A[3],B[3],b3,sub[3],borrow);

endmodule
//4X4 bit multiplier
module half_adder(
input a,
input b,
output sum,
output carry
);

assign sum=a^b;
assign carry=a&b;

endmodule

module four_x_four_multiplier(
input [3:0]A,
input [3:0]B,
output [7:0]P

    );
wire w0,w1,w2,w3,w4;
wire w5,w6,w7,w8;
wire w9,w10,w11,w12;
wire w13,w14,w15;
assign w0 = A[0]&B[0];
assign w1 = A[1]&B[0];
assign w2 = A[2]&B[0];
assign w3 = A[3]&B[0];
assign w4 = A[0]&B[1];
assign w5 = A[1]&B[1];
assign w6 = A[2]&B[1];
assign w7 = A[3]&B[1];
assign w8 = A[0]&B[2];
assign w9 = A[1]&B[2];
assign w10 = A[2]&B[2];
assign w11 = A[3]&B[2];
assign w12 = A[0]&B[3];
assign w13 = A[1]&B[3];
assign w14 = A[2]&B[3];
assign w15 = A[3]&B[3];
wire s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11;
wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11;


// column 1
assign P[0]=w0;
// column 2
half_adder h0(w1,w4,P[1],c1);
 // coulmn 3
full_adder f0(w2,w5,w8,s1,c2);
half_adder h1(s1,c1,P[2],c3);
 // column 4
full_adder f1(w3,w6,w9,s2,c4);
 full_adder f2(s2,w12,c2,s3,c5);
 half_adder h2(s3,c3,P[3],c6);
 // column 5
 full_adder f3(w7,w10,w13,s4,c7);
 full_adder f4(s4,c4,c5,s5,c8);
 half_adder h3(s5,c6,P[4],c9);
 //column 6
 full_adder f5(w11,w14,c7,s6,c10);
 full_adder f6(s6,c8,c9,P[5],c11);
 // column 7
 full_adder f7(w15,c10,c11,P[6],P[7]);
 
 

endmodule
// division circuit

// d flip flop
module dff(
input d,
input reset,
input clk,
output reg q);
always @(posedge clk or posedge reset)
begin
if (reset)
  q<=1'b0;
else

  q<=d;
end


endmodule
// 4 bit compartor
module four_bit_compartor(
input [3:0]A,
input [3:0]B,
output E,
output L,
output G
);
wire [11:0] w;
assign w[0]=~(A[0]^B[0]);
assign w[1]=~(A[1]^B[1]);
assign w[2]=~(A[2]^B[2]);
assign w[3]=~(A[3]^B[3]);
assign w[4]=~(A[0]);
assign w[5]=~(A[1]);
assign w[6]=~(A[2]);
assign w[7]=~(A[3]);
assign w[8]=~(B[0]);
assign w[9]=~(B[1]);
assign w[10]=~(B[2]);
assign w[11]=~(B[3]);

assign E = (w[0]&w[1]&w[2]&w[3]);
assign L =(w[7]&B[3])|(w[3]&w[6]&B[2])|(w[3]&w[2]&w[5]&B[1])|(w[3]&w[2]&w[1]&w[4]&B[0]);

assign G =(w[11]&A[3])|(w[3]&w[10]&A[2])|(w[3]&w[2]&w[9]&A[1])|(w[3]&w[2]&w[1]&w[8]&A[0]);

endmodule
// 2 bit synchronus counter
module two_bit_synchronous_counter(
input reset,
input clk,
input enable,
output A,
output B,
output done);
wire d0,d1,w1,w2;
assign d0 = enable^A;
assign w1 =(enable)&(A^B) ;
assign w2=(~enable)&B;

assign d1=(w1|w2);
dff c0(.d(d0),.reset(reset),.clk(clk),.q(A));
dff c1(.d(d1),.reset(reset),.clk(clk),.q(B));
assign done = A &B;
endmodule


// parallel shift register
module parallal_shift_register(
input clk,
input reset,
input load,
input [3:0] d,
input serial_in,
output [3:0]q ); 
wire d0,d1,d2,d3;
assign d3=load?d[3]:q[2];
assign d2=load?d[2]:q[1];
assign d1=load?d[1]:q[0];
assign d0=load?d[0]:serial_in;
dff q3(.d(d3),.reset(reset),.clk(clk),.q(q[3]));
dff q2(.d(d2),.reset(reset),.clk(clk),.q(q[2]));
dff q1(.d(d1),.reset(reset),.clk(clk),.q(q[1]));
dff q0(.d(d0),.reset(reset),.clk(clk),.q(q[0]));
endmodule





// finite state logic
module fsm(
input clk,
input reset ,
input G,
input E,
input start ,
input done,
output reg enable,
output reg load,
output reg subtract,
output reg finished);
parameter IDLE =2'b00;
parameter RUNNING=2'b01;
parameter DONE=2'b10;

 reg[ 1:0] state;
always @(posedge clk or posedge reset)
begin
if (reset)
 state<=IDLE;
 else
 begin
 case(state)
 IDLE: if(start) state<=RUNNING;
 RUNNING :if (done) state <=DONE;
 DONE: state<=IDLE;
 default : state<=IDLE;
 endcase
 end
 end
// output logic
always @(*)
begin
load=0;
enable=0;
subtract =0;
finished =0;
 case(state)
 IDLE: 
 begin
 load=1;
 end
 RUNNING : 
 begin
  enable =1;
 subtract = G|E;
 end
 DONE: finished=1;
 endcase 
 end
 endmodule
 
// top module for division circuit
module division(
input clk,
input reset,
input [7:0] dividend,
output [3:0] quotient,
output [3:0] remainder,
input [3:0] divisor,
input start,

output finished);
// internal wire 
wire G,E;
wire A,B;
wire load ,enable,subtract,done;

wire [3:0] rem_q;
wire [3:0] quo_q;




wire [3:0] sub_result;
wire sub_borrow_out;
wire can_sub;
binary_subtractor sub_inst(.A(rem_q),.B(divisor),.borrow_in(1'b0),
.sub(sub_result),.borrow(sub_borrow_out));

assign can_sub=~(sub_borrow_out);
// quotient
 parallal_shift_register quotient_register(
 .clk(clk),.reset(reset),.load(1'b0),.d(4'b0000),.serial_in(can_sub),.q(quo_q));
 
 //remainder 
 wire [3:0] rem_next;
 assign rem_next=load?dividend[7:4]:((subtract&can_sub)?sub_result:rem_q);
 parallal_shift_register remainder_register(
 .clk(clk),.reset(reset),.load(1'b1),.d(rem_next),.serial_in(1'b0),.q(rem_q));
 
 assign E=(rem_q==divisor);
 assign G=can_sub&(~E) ;
 





two_bit_synchronous_counter count(.reset(reset),.clk(clk),.enable(enable),.A(A),.B(B),.done(done));
// fsm instantation
fsm F(.clk(clk),.reset(reset),.G(G),.E(E),.start(start),.done(done),.enable(enable),.load(load),.subtract(subtract),.finished(finished));
assign quotient=quo_q;
assign remainder = rem_q;
endmodule

module four_bit_calculator(
input [3:0] A,
input [3:0] B,
input [7:0] dividend,
input [3:0] divisor ,
input clk,
input reset,
input start,
input [1:0] op,
output reg [7:0] result,
output [3:0] remainder,
output finished);
//for addition
wire [3:0] sum;
wire carry_out;
ripple_carry_adder add(.A(A),.B(B),.sum(sum),.cin(1'b0),.out(carry_out));
// for subtraction
wire [3:0] sub;
wire borrow;
binary_subtractor subtract(.A(A),.B(B),.borrow_in(1'b0),.sub(sub),.borrow(borrow));
// for multiplication
wire [7:0] Product;
four_x_four_multiplier four_bit_multiplier(.A(A),.B(B),.P(Product));
// for division
wire [3:0]quotient;

division division_inst(.clk(clk),.reset(reset),.dividend(dividend),.quotient(quotient),.divisor(divisor),
.remainder(remainder),.start(start),.finished(finished));
always @(*)
begin
case(op)
2'b00:result ={3'b000,carry_out,sum};
2'b01:result ={3'b000,borrow,sub};
2'b10:result= Product;
2'b11:result = {4'b0000,quotient};
default:result =  8'b0;
endcase
end
endmodule
`timescale 1ns / 1ps

module four_bit_calculator_tb;

// inputs
reg [3:0] A, B;
reg [7:0] dividend;
reg [3:0] divisor;
reg clk, reset, start;
reg [1:0] op;

// outputs
wire [7:0] result;
wire [3:0] remainder;
wire finished;

// instantiate
four_bit_calculator uut(
    .A(A), .B(B),
    .dividend(dividend),
    .divisor(divisor),
    .clk(clk), .reset(reset),
    .start(start), .op(op),
    .result(result),
    .remainder(remainder),
    .finished(finished));

// clock: 10ns period
always #5 clk = ~clk;

// task for division test
task do_division;
    input [7:0] dvd;
    input [3:0] dvs;
    begin
        dividend = dvd;
        divisor  = dvs;
        op       = 2'b11;
        @(posedge clk); #1;
        start = 1;
        @(posedge clk); #1;
        start = 0;
        // wait for finished
        wait(finished == 1);
        @(posedge clk); #1;
        $display("DIV: %0d / %0d = quotient=%0d remainder=%0d",
                  dvd, dvs, result[3:0], remainder);
    end
endtask

initial begin
    // init
    clk = 0; reset = 1; start = 0;
    A = 0; B = 0; op = 0;
    dividend = 0; divisor = 0;
    #20;
    reset = 0;
    #10;

    
    // TEST 1: ADDITION
  
    op = 2'b00;
    A = 4'd5; B = 4'd3;
    #10;
    $display("ADD: %0d + %0d = %0d (expected 8)", A, B, result);

    A = 4'd9; B = 4'd7;
    #10;
    $display("ADD: %0d + %0d = %0d (expected 16, carry=1)", A, B, result);

    A = 4'd15; B = 4'd15;
    #10;
    $display("ADD: %0d + %0d = %0d (expected 30, carry=1)", A, B, result);

    
    // TEST 2: SUBTRACTION
  
    op = 2'b01;
    A = 4'd9; B = 4'd4;
    #10;
    $display("SUB: %0d - %0d = %0d (expected 5)", A, B, result);

    A = 4'd3; B = 4'd7;
    #10;
    $display("SUB: %0d - %0d = %0d borrow=%0d (expected borrow=1)", A, B, result[3:0], result[4]);

    A = 4'd15; B = 4'd0;
    #10;
    $display("SUB: %0d - %0d = %0d (expected 15)", A, B, result);

    
    // TEST 3: MULTIPLICATION
    
    op = 2'b10;
    A = 4'd3; B = 4'd4;
    #10;
    $display("MUL: %0d * %0d = %0d (expected 12)", A, B, result);

    A = 4'd7; B = 4'd7;
    #10;
    $display("MUL: %0d * %0d = %0d (expected 49)", A, B, result);

    A = 4'd15; B = 4'd15;
    #10;
    $display("MUL: %0d * %0d = %0d (expected 225)", A, B, result);

    A = 4'd0; B = 4'd8;
    #10;
    $display("MUL: %0d * %0d = %0d (expected 0)", A, B, result);

    // ==================
    // TEST 4: DIVISION
    // ==================

    // reset before division
    reset = 1; #10; reset = 0; #10;

    do_division(8'd12, 4'd3);   // 12/3 = q:4  r:0
    reset = 1; #10; reset = 0; #10;

    do_division(8'd15, 4'd4);   // 15/4 = q:3  r:3
    reset = 1; #10; reset = 0; #10;

    do_division(8'd7,  4'd2);   // 7/2  = q:3  r:1
    reset = 1; #10; reset = 0; #10;

    do_division(8'd9,  4'd9);   // 9/9  = q:1  r:0
    reset = 1; #10; reset = 0; #10;

    do_division(8'd1,  4'd5);   // 1/5  = q:0  r:1
    reset = 1; #10; reset = 0; #10;

    // ==================
    // DONE
    // ==================
    $display("All tests done.");
    #20;
    $finish;
end

// timeout watchdog - agar finished nahi aaya 1000ns mein
initial begin
    #2000;
    $display("TIMEOUT - simulation stuck");
    $finish;
end

endmodule




 
 



