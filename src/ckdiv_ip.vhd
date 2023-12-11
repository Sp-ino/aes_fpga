----------------------------------------------------------------------------------
-- Engineer: Valerio Spinogatti
-- 
-- Create Date: 02.07.2022 18:03:02
-- Design Name: 
-- Module Name: ckdiv_ip - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: clock divider
-- 
-- Dependencies: 
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
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;


entity ckdiv_ip is
    Port ( 
        i_ck : in std_logic;
        o_ckout : out std_logic
    );
end ckdiv_ip;


architecture Behavioral of ckdiv_ip is

    constant n_bit: integer := positive(ceil(log2(real(clock_scaling_factor))));
    signal r_internal_count: std_logic_vector (n_bit - 1 downto 0) := (others => '0');

begin

    o_ckout <= r_internal_count(n_bit - 1);

    counter: process(i_ck)
    begin

        if rising_edge(i_ck) then
            r_internal_count <= std_logic_vector(unsigned(r_internal_count) + 1);
        end if;
    
    end process counter;

end Behavioral;
