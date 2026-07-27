`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2026 21:27:09
// Design Name: 
// Module Name: RCA
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


module FA (
    input  a_in,
    b_in,
    c_in,
    output s,
    output c_out
);

  assign {c_out, s} = a_in + b_in + c_in;

endmodule

module RCA #(
    parameter N = 4
) (
    input  [N-1:0] a,
    input  [N-1:0] b,
    output [N-1:0] sum,
    output [N-1:0] carry
);

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : gen_full_adders
      if (i == 0) begin : gen_lsb
        FA full_adder (
            .a_in(a[i]),
            .b_in(b[i]),
            .c_in(1'b0),
            .s(sum[i]),
            .c_out(carry[i])
        );
      end else begin : gen_remaining_bits
        FA full_adder (
            .a_in(a[i]),
            .b_in(b[i]),
            .c_in(carry[i-1]),
            .s(sum[i]),
            .c_out(carry[i])
        );
      end
    end
  endgenerate


endmodule
