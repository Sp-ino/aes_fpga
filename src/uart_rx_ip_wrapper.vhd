----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.06.2022 15:51:38
-- Design Name: 
-- Module Name: uart_rx_ip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Wrapper synthesizable UART RX module
-- 
-- Dependencies: uart_pkg.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.common_pkg.all;



entity uart_rx_ip_wrapper is
    port ( 
        i_ck : in std_logic;
        i_rx : in std_logic;
        i_rst : in std_logic;
        i_data_seen : in std_logic;
        o_data_valid : out std_logic;
        o_data_out : out std_logic_vector (byte_width_bit - 1 downto 0)
    );
end uart_rx_ip_wrapper;


architecture Structure of uart_rx_ip_wrapper is

    component uart_rx_ip is
    port ( 
        i_ck : in std_logic;
        i_rx : in std_logic;
        i_rst : in std_logic;
        i_data_seen : in std_logic;
        o_data_valid : out std_logic;
        o_data_out : out std_logic_vector (byte_width_bit - 1 downto 0)
    );
    end component; 

begin

    uart_rx: uart_rx_ip
    port map (
        i_ck => i_ck,
        i_rx => i_rx,
        i_rst => i_rst,
        i_data_seen => i_data_seen,
        o_data_valid => o_data_valid,
        o_data_out => o_data_out
    );

end Structure;
