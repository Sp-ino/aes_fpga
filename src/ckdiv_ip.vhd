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

entity ckdiv_ip is
    Port ( 
        i_ck : in std_logic;
        o_ckout : out std_logic
    );
end ckdiv_ip;


architecture Behavioral of ckdiv_ip is

    constant out_bit: integer := 3;
    signal r_internal_count: std_logic_vector (3 downto 0) := (others => '0');

begin

    o_ckout <= r_internal_count(out_bit);

    counter: process(i_ck)
    begin

        if rising_edge(i_ck) then
            r_internal_count <= std_logic_vector(unsigned(r_internal_count) + 1);
        end if;
    
    end process counter;

end Behavioral;
