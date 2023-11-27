----------------------------------------------------------------------------------
-- Engineer: Valerio Spinogatti
-- 
-- Module Name: uart_rx_ip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Wrapper of synthesizable UART TX module
-- 
-- Dependencies: uart_pkg.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-- 
-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.common_pkg.all;



entity uart_tx_ip_wrapper is
    port (
        i_ck : in std_logic;
        i_rst: in std_logic;
        i_data_valid : in std_logic;
        i_data_in : in std_logic_vector (byte_width_bit-1 downto 0);
        o_busy : out std_logic;
        o_tx : out std_logic
    );
end uart_tx_ip_wrapper;


architecture Behavioral of uart_tx_ip_wrapper is

    component uart_tx_ip is
    port (
        i_ck : in std_logic;
        i_rst: in std_logic;
        i_data_valid : in std_logic;
        i_data_in : in std_logic_vector (byte_width_bit-1 downto 0);
        o_busy : out std_logic;
        o_tx : out std_logic
    );
    end component;

begin

    uart_tx: uart_tx_ip
    port map (
        i_ck => i_ck,
        i_rst => i_rst,
        i_data_valid => i_data_valid,
        i_data_in => i_data_in,
        o_busy => o_busy,
        o_tx => o_tx
    );

end Behavioral;