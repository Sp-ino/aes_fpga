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


library IEEE;
library xil_defaultlib;
use IEEE.STD_LOGIC_1164.ALL;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.aes_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

    component receiver_wrapper is
    port (
        i_ckin : in std_logic;
        i_rst : in std_logic;
        i_rx : in std_logic;
        o_ck : out std_logic;
        o_textin : out std_logic_vector ( 127 downto 0 );
        o_word_ready : out std_logic
    );
    end component;
    
    constant tck: time := 10 ns;
    constant tck_int: time := tck*16;

    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal clock: std_logic;
    signal clock_slow: std_logic;
    signal rst: std_logic;
    signal rx: std_logic;
    signal data_ready: std_logic;
    signal tin: std_logic_vector (127 downto 0);

begin

    top: receiver_wrapper
    port map (
        i_ckin => clock,
        i_rst => rst,
        i_rx => rx,
        o_ck => clock_slow,
        o_textin => tin,
        o_word_ready => data_ready
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

        rx <= '1';
        rst <= '1';
        wait for 3*tck_int/2;
        rst <= '0';

        -- send start bit
        wait for 2*tck_int; 
        rx <= '0';

        -- then send a "01010011" (83)
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "10011010" (154)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;

        -- send a new start bit
        wait for bit_duration*tck_int; 
        rx <= '0';

        -- then send a "00001010" (10)
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '1';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';
        wait for bit_duration*tck_int;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck_int;
        rx <= '1';
        
        wait for bit_duration*tck_int;


    end process test_sig_gen;

end Behavioral;
