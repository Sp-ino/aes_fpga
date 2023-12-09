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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

    component top is
    port (
        i_ckin: in std_logic;
        i_rst: in std_logic;
        i_rx: in std_logic;
        i_send_textout: in std_logic;
        i_start_encryption: in std_logic;
        i_acquire_textin: in std_logic;
        o_tx: out std_logic;
        o_rx_buffer_full: out std_logic;
        o_rx_count_status: out std_logic_vector(4 downto 0)
    );
    end component;
    
    constant tck_fast: time := 10 ns;
    constant tck: time := tck_fast*clock_scaling_factor;

    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal send_tout: std_logic := '0';
    signal read_tin: std_logic := '0';
    signal clock: std_logic;
    signal rst: std_logic := '0';
    signal rx: std_logic := '1';
    signal tx: std_logic;
    signal start_encryption: std_logic := '0';
    signal rx_full: std_logic;
    signal count_status: std_logic_vector(4 downto 0);

begin

    top_block: top
    port map (
        i_ckin => clock,
        i_rst => rst,
        i_rx => rx,
        i_send_textout => send_tout,
        i_acquire_textin => read_tin,
        i_start_encryption => start_encryption,
        o_rx_buffer_full => rx_full,
        o_tx => tx,
        o_rx_count_status => count_status
    );
        
    
    clock_gen: process
    begin

        clock <= '1';
        wait for tck_fast/2;
        clock <= '0';
        wait for tck_fast/2;
    
    end process clock_gen;


    test_sig_gen: process
    begin

        send_tout <= '0';
        rx <= '1';
        rst <= '1';
        wait for 2*tck;
        rst <= '0';

        wait for tck;
        read_tin <= '1';
        wait for tck;
        read_tin <= '0';

        ----------------- send a partial textin and then perform encryption --------------------

        -- send start bit
        wait for 2*tck; 
        rx <= '0';

        -- send a "11111111" (0xFF)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';        

        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;

        -- encrypt
        wait for 40*bit_duration*tck;
        start_encryption <= '1';
        wait for tck;
        start_encryption <= '0';
        wait for 40*bit_duration*tck;

        ----------------- reset transmission and then send full word --------------------
        wait for tck;
        read_tin <= '1';
        wait for tck;
        read_tin <= '0';

        wait for 5*bit_duration*tck; 

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';
        
        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';        

        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';
        
        -- then send a "10011010" (0xa9)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001011" (0x0b)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00011010" (0x1a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001010" (0x0a)
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "00001011" (0x0b)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '0';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        -- send a new start bit
        wait for bit_duration*tck; 
        rx <= '0';

        -- then send a "11101111" (0x0a)
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '0';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';
        wait for bit_duration*tck;
        rx <= '1';

        -- send stop bit
        wait for bit_duration*tck;
        rx <= '1';
        
        wait for 50*bit_duration*tck;
        start_encryption <= '1';
        wait for tck;
        start_encryption <= '0';

        wait for 10*tck;
        send_tout <= '1';
        wait for tck;
        send_tout <= '0';
        
        wait for tck*bit_duration*200;

        for idx in 7 downto 0 loop
            -- send a new start bit
            wait for bit_duration*tck; 
            rx <= '0';
    
            -- then send a "00001010" (0x0a)
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '0';
    
            -- send stop bit
            wait for bit_duration*tck;
            rx <= '1';

            -- send a new start bit
            wait for bit_duration*tck; 
            rx <= '0';
    
            -- then send a "00001010" (0xaa)
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
            wait for bit_duration*tck;
            rx <= '0';
            wait for bit_duration*tck;
            rx <= '1';
    
            -- send stop bit
            wait for bit_duration*tck;
            rx <= '1';
        end loop;

        wait for 50*bit_duration*tck;
        start_encryption <= '1';
        wait for tck;
        start_encryption <= '0';
    
        assert false report "Reached end of testbench" severity failure;
        -------------------------------- end of testbench ---------------------------

    end process test_sig_gen;

end Behavioral;
