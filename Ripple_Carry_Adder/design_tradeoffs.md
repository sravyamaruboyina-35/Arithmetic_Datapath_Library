# Design Trade-offs: Parameterized Ripple-Carry Adder

## Design objective

The Ripple-Carry Adder (RCA) is used as a simple and transparent baseline for the arithmetic datapath library. It demonstrates how an `N`-bit binary adder can be built by connecting one full adder per bit.

The current RTL is a purely combinational design:

- There is no clock, register, reset, or state.
- The least-significant bit receives a constant carry-in of zero.
- Each bit passes its carry to the next bit.
- The design exposes both `sum[N-1:0]` and the intermediate `carry[N-1:0]` signals.

## Advantages

### Simple and readable structure

The generate loop directly represents the hardware structure. This makes the RTL easy to understand, review, simulate, and debug.

### Small hardware cost

An RCA uses one full-adder stage per bit. It does not require the additional generate/propagate logic, prefix networks, or large multiplexing structures used by faster adder architectures.

### Regular layout

Every bit has the same basic structure, which makes the design easy to parameterize and extend from 4 bits to a wider operand size.

### Easy verification

The self-checking testbench can exhaustively test all input combinations for small values of `N`. For the current 4-bit configuration, it checks 256 operand pairs in addition to directed corner cases.

### Good FPGA mapping

FPGA tools can map the carry dependency to dedicated carry-chain resources. This gives the implementation an efficient physical structure compared with building the carry path from general-purpose LUT routing alone.

## Limitations

### Carry propagation grows with width

Each higher-order sum depends on the carry from the preceding bit. The carry must therefore travel through a chain of stages before the most-significant result is settled. The combinational propagation delay grows approximately linearly with `N`.

This is a functional latency characteristic of the combinational circuit, not a clocked setup/hold requirement. The current project has no clock and therefore has no setup or hold timing constraints.

### Wider versions become less attractive

As `N` increases, the RCA can become slower than architectures that compute carries in parallel. It is best suited to small or moderate widths, simple control logic, educational designs, and applications where maximum arithmetic performance is not the primary requirement.

### Intermediate carry outputs increase the interface

This implementation intentionally exposes every carry bit for observation and verification. A production adder may expose only `sum` and the final carry-out, reducing the external interface to:

```text
sum[N-1:0] and carry_out
```

## Comparison with alternative adders

| Architecture | Carry calculation | Area | Combinational delay | Main use |
|---|---|---:|---:|---|
| Ripple-carry adder | Bit-by-bit propagation | Low | Increases approximately linearly with width | Simple baseline and small adders |
| Carry-lookahead adder | Parallel generate/propagate logic | Higher | Lower for wider operands | Higher-performance arithmetic |
| Carry-select adder | Computes alternative carry cases and selects | Higher | Lower, with extra duplication | Speed-focused datapaths |
| Carry-save adder | Delays carry propagation across multiple operands | Application-dependent | Efficient for multi-operand addition | Multipliers and accumulation trees |

The RCA is the simplest reference design. The CLA in the larger Arithmetic Datapath Library can be compared against it to show the area-versus-speed trade-off created by parallel carry generation.

## Verification trade-off

The testbench uses a reference carry-chain model and checks both the sum and every intermediate carry. This provides strong functional coverage for the 4-bit configuration. Exhaustive testing is practical for small widths, but larger parameter values should use constrained-random tests, directed corner cases, or a formal equivalence/property-checking flow instead of enumerating every operand pair.

## FPGA implementation notes

The Arty A7-100 implementation maps the operands to switches and push-buttons, the sum to onboard LEDs, and the carry vector to the first four pins of the JA Pmod header. The XDC file assigns package pins and `LVCMOS33` I/O standards for all top-level ports.

The implementation flow should therefore concentrate on:

- Correct top-level port names and widths.
- Complete package-pin and I/O-standard assignments.
- Functional simulation results.
- Synthesis and implementation DRC results.
- Correct board-level behavior of switches, buttons, LEDs, and Pmod outputs.

## Conclusion

The RCA is not intended to be the fastest adder. Its value is its clarity, low structural complexity, parameterization, and usefulness as a verified baseline. It provides a clear starting point for evaluating more advanced arithmetic architectures such as carry-lookahead, carry-select, and carry-save designs.
