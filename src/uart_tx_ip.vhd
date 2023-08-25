----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.07.2022 14:05
-- Design Name: 
-- Module Name: uart_rx_ip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Synthesizable UART TX module
-- 
-- Dependencies: uart_pkg.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
library xil_defaultlib;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use xil_defaultlib.uart_pkg.all;



entity uart_tx_ip is
    port (
        i_ck : in std_logic;
        i_rst: in std_logic;
        i_data_ready : in std_logic;
        i_data_in : in std_logic_vector (in_len-1 downto 0);
        o_busy : out std_logic;
        o_tx : out std_logic
    );
end uart_tx_ip;


architecture Behavioral of uart_tx_ip is

    signal w_next_state: uart_states_tx;
    signal r_present_state: uart_states_tx;
    signal r_count_bits: integer range frame_len downto 0;
    signal r_count_clock_cycles: integer range bit_duration downto 0;

begin

    compute_next_state: process(all)
    begin

        if i_rst = '1' then
            w_next_state <= idle;
        else
            case r_present_state is
            when idle =>
                if i_data_ready = '1' then
                    w_next_state <= send_start_bit;
                else
                    w_next_state <= idle;
                end if;
            when send_start_bit =>
                if r_count_clock_cycles < bit_duration then
                    w_next_state <= send_start_bit;
                else
                    w_next_state <= send_data_bits;
                end if;
            when send_data_bits =>
                if r_count_clock_cycles < bit_duration then
                    w_next_state <= send_data_bits;
                else
                    if r_count_bits < frame_len - 1 then
                        w_next_state <= send_data_bits;
                    else
                        w_next_state <= send_stop_bit;
                    end if;
                end if;
            when send_stop_bit =>
                if r_count_clock_cycles < bit_duration then
                    w_next_state <= send_stop_bit;
                else
                    w_next_state <= idle;
                end if;
            when others =>
                w_next_state <= idle;
            end case;
        end if;

    end process compute_next_state;


    state_reg: process(i_ck)
    begin

        if rising_edge(i_ck) then
            if i_rst = '1' then
                r_present_state <= idle;
            else
                r_present_state <= w_next_state;
            end if;
        end if;

    end process state_reg;


    perform_operations: process(i_ck)
    begin

        if rising_edge(i_ck) then
            if i_rst = '1' then
                r_count_bits <= 0;
                r_count_clock_cycles <= 0;
                o_tx <= '1';
                o_busy <= '0';
            else
                case r_present_state is
                when idle =>
                    r_count_bits <= 0;
                    r_count_clock_cycles <= 0;
                    o_tx <= '1';
                    o_busy <= '0';
                when send_start_bit =>
                    o_busy <= '1';
                    o_tx <= '0';
                    if r_count_clock_cycles < bit_duration then
                        r_count_clock_cycles <= r_count_clock_cycles + 1;
                    else
                        r_count_clock_cycles <= 1;
                    end if;
                when send_data_bits =>
                    --if r_count_bits < frame_len then
                    o_tx <= i_data_in(r_count_bits);
                    --end if;
                    if r_count_clock_cycles < bit_duration then
                        r_count_clock_cycles <= r_count_clock_cycles + 1;
                    else
                        r_count_bits <= r_count_bits + 1;
                        r_count_clock_cycles <= 1;
                    end if;
                when send_stop_bit =>
                    o_tx <= '1';
                    r_count_clock_cycles <= r_count_clock_cycles + 1;
                    if r_count_clock_cycles >= bit_duration then
                        o_busy <= '0';
                    end if;
                end case;
            end if;
        end if;

    end process perform_operations;

end Behavioral;