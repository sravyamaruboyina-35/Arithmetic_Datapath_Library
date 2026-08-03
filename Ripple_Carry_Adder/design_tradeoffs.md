# Design Trade-offs: Ripple Carry Adder

The Ripple Carry Adder (RCA) was the natural starting point for this arithmetic datapath work because its behavior is the simplest and most direct expression of binary addition. Each bit-slice computes a sum and forwards the carry to the next stage, so the structure is easy to read, implement, and verify as a clean baseline design.

The main trade-off is that the carry is inherently sequential. A carry must propagate from the least significant bit to the most significant bit, which means the critical path grows with the bit width. In other words, RCA has an O(n) carry delay, where n is the number of bits. That delay characteristic is exactly what motivates the Carry Lookahead Adder (CLA): by generating and propagating carries in parallel across groups of bits, CLA reduces the carry dependency on a long ripple chain and improves speed.
