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
use IEEE.STD_LOGIC_1164.ALL;

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

    component aes_ip is
        port (
            i_textin : in std_logic_vector (127 downto 0);
            i_rst : in std_logic;
            i_ck : in std_logic;
            o_textout : out std_logic_vector (127 downto 0)
        );
    end component;
    
    constant tck: time := 10 ns;
    constant in1: integer := 1;
    constant in2: integer := 1234556;

    signal clock: std_logic;
    signal reset: std_logic;
    signal tin: std_logic_vector (127 downto 0);
    signal tout: std_logic_vector (127 downto 0);

begin

    aes: aes_ip
    port map (
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
        reset <= '1';
        wait for 1*tck;
        tin <= std_logic_vector(to_unsigned(in2, 128));
        wait for 1*tck;
        reset <= '0';
        
        wait for tck/2;
        tin <= std_logic_vector(to_unsigned(in1, 128));
        wait for tck/2;

        wait for 2*tck;

        assert true report "End of testbench reached!" severity failure;
    end process test_sig_gen;

end Behavioral;
