----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2022 22:13:42
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

library xil_defaultlib;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.common_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

    component transmitter_wrapper is
    port (
        i_send_textout : in std_logic;
        i_word : in std_logic_vector (word_width_bit - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_tx : out std_logic
    );
    end component;
    
    constant tck: time := 10 ns;

    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal clock: std_logic;
    signal rst: std_logic;
    signal tx: std_logic;
    signal transmit: std_logic;
    signal tout: std_logic_vector (word_width_bit - 1 downto 0) := x"ef0b0a0a0a0a0a0a0a0a0a0a1a0ba953";

begin

    top: transmitter_wrapper
    port map (
        i_send_textout => transmit,
        i_word => tout,
        i_ck => clock,
        i_rst => rst,
        o_tx => tx
    );
        
    
    clock_gen: process
    begin

        clock <= '1';
        wait for tck/2;
        clock <= '0';
        wait for tck/2;
    
    end process clock_gen;


    test_sig_gen: process
    begin

        wait for tck/2;
        
        rst <= '1';
        wait for 2*tck;
        rst <= '0';
        wait for 2*tck;

        transmit <= '1';
        wait for 2*tck;
        transmit <= '0';
        wait for tck*bit_duration*200;

    end process test_sig_gen;

end Behavioral;