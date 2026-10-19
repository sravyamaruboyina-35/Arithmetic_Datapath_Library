module RCA_tb;

  parameter int N = 4;

  logic [N-1:0] a, b;
  logic [N-1:0] sum, carry;

  int errors = 0;
  int tests  = 0;

  // DUT instantiation
  RCA #(.N(N)) dut (
    .a     (a),
    .b     (b),
    .sum   (sum),
    .carry (carry)
  );

  // Reference model + checker task
  task automatic check(input logic [N-1:0] a_val, input logic [N-1:0] b_val);
    logic [N-1:0] exp_sum;
    logic [N-1:0] exp_carry;
    logic [N:0] carry_chain;

    a = a_val;
    b = b_val;
    #5; // allow combinational settle

    carry_chain = '0;
    for (int i = 0; i < N; i++) begin
      exp_sum[i] = a_val[i] ^ b_val[i] ^ carry_chain[i];
      exp_carry[i] = (a_val[i] & b_val[i]) |
                     (carry_chain[i] & (a_val[i] ^ b_val[i]));
      carry_chain[i+1] = exp_carry[i];
    end

    tests++;

    if (sum !== exp_sum || carry !== exp_carry) begin
      errors++;
      $display("FAIL: a=%0d b=%0d | sum=%0d (exp %0d) | carry=%0b (exp %0b)",
                a_val, b_val, sum, exp_sum, carry, exp_carry);
    end
  endtask

  initial begin
    $display("Starting RCA testbench, N=%0d", N);

    // Directed tests
    check(0, 0);
    check(1, 1);
    check({N{1'b1}}, 1);          // max value + 1 -> overflow case
    check({N{1'b1}}, {N{1'b1}});  // max + max -> overflow case
    // Width-safe alternating-pattern test. N'(value) casts the values to N bits.
    if (N >= 4)
      check(N'(10), N'(5));

    // Exhaustive test for small N (N=4 -> 256 combinations)
    for (int i = 0; i < (1 << N); i++) begin
      for (int j = 0; j < (1 << N); j++) begin
        check(i[N-1:0], j[N-1:0]);
      end
    end

    if (errors != 0)
      $fatal(1, "%0d of %0d tests failed", errors, tests);
    else
      $display("ALL %0d TESTS PASSED", tests);

    $finish;
  end

endmodule
