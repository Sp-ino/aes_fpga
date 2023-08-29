# W5 is the clock pin
set_property PACKAGE_PIN W5 [get_ports i_ckin]
set_property IOSTANDARD LVCMOS33 [get_ports i_ckin]

# for the reset I use one of pins that are connected to pushbuttons
set_property PACKAGE_PIN W19 [get_ports i_rst]
set_property IOSTANDARD LVCMOS33 [get_ports i_rst]

# In this constraint set we map the rx port to one of the pins
# in the PMOD ports because we want to use an external FTDI module.
# Specifically, we choose pin G2, corresponding to JA4 in the JA port.
# Similarly, the tx port is mapped to G3, which corresponds to JA10.
#set_property PACKAGE_PIN G2 [get_ports i_receive]
#set_property IOSTANDARD LVCMOS33 [get_ports i_receive]
#set_property PACKAGE_PIN G3 [get_ports o_transmit]
#set_property IOSTANDARD LVCMOS33 [get_ports o_transmit]

# In this constraint set we use the on-board FTDI to communicate with external devices
set_property PACKAGE_PIN B18 [get_ports i_rx]
set_property IOSTANDARD LVCMOS33 [get_ports i_rx]
set_property PACKAGE_PIN A18 [get_ports o_tx]
set_property IOSTANDARD LVCMOS33 [get_ports o_tx]

# T17 is connected to a pushbutton and is used to send a tx request to the circuit
set_property PACKAGE_PIN T17 [get_ports i_transmit]
set_property IOSTANDARD LVCMOS33 [get_ports i_transmit]

# set this option so the synthesizer doesn't complain
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

