create_clock -add -name clk -period 40.00 -waveform {0 5} [get_ports { clk }];

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN N11 [get_ports clk]
set_property PACKAGE_PIN E6 [get_ports rst]

set_property PACKAGE_PIN T10  [get_ports {lcd[0]}]
set_property PACKAGE_PIN K13  [get_ports {lcd[1]}]
set_property PACKAGE_PIN P11  [get_ports {lcd[2]}]
set_property PACKAGE_PIN R11  [get_ports {lcd[3]}]
set_property PACKAGE_PIN R10  [get_ports {lcd[4]}]
set_property PACKAGE_PIN N9   [get_ports {lcd[5]}]
set_property PACKAGE_PIN R6   [get_ports led]

set_property IOSTANDARD LVCMOS33 [get_ports {lcd[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports led]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
