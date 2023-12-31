-- Constants and definitions for UART modules
-- 
-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license


library ieee;
use ieee.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;


package uart_pkg is

    constant frame_len: integer := 8; -- number of data bits in a frame
    constant clock_frequ: integer := 100e6;
    constant baud_rate: integer := 38400; -- baud rate of the UART module
    constant bit_duration: integer := clock_frequ/(baud_rate*clock_scaling_factor); -- duration of a data bit in scaled clock cycles
    type uart_states_rx is (idle, wait_initial_time, count_cycles, wait_data_seen);
    type uart_states_tx is (idle, send_start_bit, send_data_bits, send_stop_bit);
    type deserializer_states is (idle, save, pause, reset_count);
    type serializer_states is (idle, assert_valid, pause_1, pause_2, pause_3, increment);

end uart_pkg;