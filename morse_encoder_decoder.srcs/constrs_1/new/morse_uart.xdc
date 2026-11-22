## Clock 125 MHz
set_property PACKAGE_PIN H16 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 8.000 [get_ports clk]

## UART RX
set_property PACKAGE_PIN Y18 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]

## UART TX
set_property PACKAGE_PIN Y19 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]

## Switch-uri
set_property PACKAGE_PIN M20 [get_ports sw0]
set_property IOSTANDARD LVCMOS33 [get_ports sw0]

set_property PACKAGE_PIN M19 [get_ports sw1]
set_property IOSTANDARD LVCMOS33 [get_ports sw1]

## LED-uri
set_property PACKAGE_PIN R14 [get_ports led0]
set_property IOSTANDARD LVCMOS33 [get_ports led0]

set_property PACKAGE_PIN P14 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]