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
-- Description: Wrapper of synthesizable UART TX module
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



entity uart_tx_ip_wrapper is
    port (
        i_ck : in std_logic;
        i_rst: in std_logic;
        i_data_ready : in std_logic;
        i_data_in : in std_logic_vector (in_len-1 downto 0);
        o_busy : out std_logic;
        o_tx : out std_logic
    );
end uart_tx_ip_wrapper;


architecture Behavioral of uart_tx_ip_wrapper is

    component uart_tx_ip is
    port (
        i_ck : in std_logic;
        i_rst: in std_logic;
        i_data_ready : in std_logic;
        i_data_in : in std_logic_vector (in_len-1 downto 0);
        o_busy : out std_logic;
        o_tx : out std_logic
    );
    end component;

begin

    uart_tx: uart_tx_ip
    port map (
        i_ck => i_ck,
        i_rst => i_rst,
        i_data_ready => i_data_ready,
        i_data_in => i_data_in,
        o_busy => o_busy,
        o_tx => o_tx
    );

end Behavioral;