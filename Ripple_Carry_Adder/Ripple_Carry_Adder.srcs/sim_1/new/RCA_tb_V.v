`timescale 1ns / 1ps

module RCA_tb_V;
   parameter  N = 4;
  reg [N-1:0] a;
  reg [N-1:0] b;
  wire [N-1:0] sum;
  wire [N-1:0] carry;

  RCA_V #(.N(N)) tb_V(
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial begin
    a = 4'd0;
    b = 4'd0;

    #10;
    a = 4'd3;
    b = 4'd4;
    #1;
    $display("a = %d, b = %d, sum = %d, carry = %b", a, b, sum, carry);

    #10;
    a = 4'd5;
    b = 4'd6;
    #1;
    $display("a = %d, b = %d, sum = %d, carry = %b", a, b, sum, carry);

    #10;
    a = 4'd11;
    b = 4'd15;
    #1;
    $display("a = %d, b = %d, sum = %d, carry = %b", a, b, sum, carry);

    $finish;
  end
endmodule
