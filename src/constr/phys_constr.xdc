# W5 is the clock pin
set_property PACKAGE_PIN W5 [get_ports i_ckin]
set_property IOSTANDARD LVCMOS33 [get_ports i_ckin]

# for the reset I use one of pins that are connected to pushbuttons
set_property PACKAGE_PIN W19 [get_ports i_rst]
set_property IOSTANDARD LVCMOS33 [get_ports i_rst]

# In this constraint set we map the rx port to one of the pins
# in the PMOD ports because we want to use an external FTDI module.
# Specifically, for rx we choose pin G2, corresponding to JA4 in the JA port.
# Similarly, the tx port is mapped to G3, which corresponds to JA10.
set_property PACKAGE_PIN G2 [get_ports i_rx]
set_property IOSTANDARD LVCMOS33 [get_ports i_rx]
set_property PACKAGE_PIN G3 [get_ports o_tx]
set_property IOSTANDARD LVCMOS33 [get_ports o_tx]

# In this constraint set we use the on-board FTDI to communicate with external devices
#set_property PACKAGE_PIN B18 [get_ports i_rx]
#set_property IOSTANDARD LVCMOS33 [get_ports i_rx]
#set_property PACKAGE_PIN A18 [get_ports o_tx]
#set_property IOSTANDARD LVCMOS33 [get_ports o_tx]

# T17 is connected to a pushbutton and is used to send a tx request to the circuit
set_property PACKAGE_PIN T17 [get_ports i_send_textout]
set_property IOSTANDARD LVCMOS33 [get_ports i_send_textout]

# T18 is connected to a pushbutton and is used to send the encrypt signal
set_property PACKAGE_PIN T18 [get_ports i_start_encryption]
set_property IOSTANDARD LVCMOS33 [get_ports i_start_encryption]

# V17 is connected to a pushbutton and is used to acquire a new textin
set_property PACKAGE_PIN U17 [get_ports i_acquire_textin]
set_property IOSTANDARD LVCMOS33 [get_ports i_acquire_textin]

# buffer_full is connected to a LED
set_property PACKAGE_PIN L1 [get_ports o_rx_buffer_full]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_buffer_full]

# set output leds that visualize the status of the counter inside the deserializer block
set_property PACKAGE_PIN U16 [get_ports o_rx_count_status[0]]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_count_status[0]]
set_property PACKAGE_PIN E19 [get_ports o_rx_count_status[1]]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_count_status[1]]
set_property PACKAGE_PIN U19 [get_ports o_rx_count_status[2]]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_count_status[2]]
set_property PACKAGE_PIN V16 [get_ports o_rx_count_status[3]]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_count_status[3]]
set_property PACKAGE_PIN W18 [get_ports o_rx_count_status[4]]
set_property IOSTANDARD LVCMOS33 [get_ports o_rx_count_status[4]]

# set this option so the synthesizer doesn't complain
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]