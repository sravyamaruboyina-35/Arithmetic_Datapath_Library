## Constraints for the RCA top-level module on the Digilent Arty A7-100.
##
## Mapping used:
##   a[3:0]     = SW[0:3]
##   b[3:0]     = BTN[0:3]
##   sum[3:0]   = LED[0:3]
##   carry[3:0] = Pmod JA[1:4]
##
## The pin names below are from Digilent's official Arty-A7-100 master XDC.
## All external signals use 3.3-V LVCMOS signaling.

## Operand A: board switches
set_property -dict { PACKAGE_PIN A8  IOSTANDARD LVCMOS33 } [get_ports { a[0] }]
set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCMOS33 } [get_ports { a[1] }]
set_property -dict { PACKAGE_PIN C10 IOSTANDARD LVCMOS33 } [get_ports { a[2] }]
set_property -dict { PACKAGE_PIN A10 IOSTANDARD LVCMOS33 } [get_ports { a[3] }]

## Operand B: board push-buttons
set_property -dict { PACKAGE_PIN D9 IOSTANDARD LVCMOS33 } [get_ports { b[0] }]
set_property -dict { PACKAGE_PIN C9 IOSTANDARD LVCMOS33 } [get_ports { b[1] }]
set_property -dict { PACKAGE_PIN B9 IOSTANDARD LVCMOS33 } [get_ports { b[2] }]
set_property -dict { PACKAGE_PIN B8 IOSTANDARD LVCMOS33 } [get_ports { b[3] }]

## Sum: board LEDs
set_property -dict { PACKAGE_PIN H5  IOSTANDARD LVCMOS33 } [get_ports { sum[0] }]
set_property -dict { PACKAGE_PIN J5  IOSTANDARD LVCMOS33 } [get_ports { sum[1] }]
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports { sum[2] }]
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports { sum[3] }]

## Carry: Pmod header JA pins 1-4
set_property -dict { PACKAGE_PIN G13 IOSTANDARD LVCMOS33 } [get_ports { carry[0] }]
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports { carry[1] }]
set_property -dict { PACKAGE_PIN A11 IOSTANDARD LVCMOS33 } [get_ports { carry[2] }]
set_property -dict { PACKAGE_PIN D12 IOSTANDARD LVCMOS33 } [get_ports { carry[3] }]
