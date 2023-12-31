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


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

    component aes_ip is
        port (
            i_start_encryption: in std_logic;
            i_textin : in std_logic_vector (word_width_bit - 1 downto 0);
            i_rst : in std_logic;
            i_ck : in std_logic;
            o_textout : out std_logic_vector (word_width_bit - 1 downto 0)
        );
    end component;
    
    constant tck: time := 10 ns;
    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal clock: std_logic;
    signal reset: std_logic;
    signal start: std_logic;
    signal tin: std_logic_vector (word_width_bit - 1 downto 0);
    signal tout: std_logic_vector (word_width_bit - 1 downto 0);

begin

    aes: aes_ip
    port map (
        i_start_encryption => start,
        i_textin => tin,
        i_rst => reset,
        i_ck => clock,
        o_textout => tout
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
        reset <= '1';
        wait for 2*tck;
        reset <= '0';
        start <= '1';
        tin <= std_logic_vector(to_unsigned(in2, 128));
        wait for tck;
        start <= '0';
        wait for 4*tck;
        
        tin <= std_logic_vector(to_unsigned(in1, 128));
        start <= '1';
        wait for tck;
        start <= '0';
        wait for 4*tck;

        assert true report "End of testbench reached!" severity failure;
    end process test_sig_gen;

end Behavioral;
