----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2022 22:08:37
-- Design Name: 
-- Module Name: aes_ip - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- arithmetic functions with Signed or Unsigned values

library xil_defaultlib;
use xil_defaultlib.aes_pkg.all;
use xil_defaultlib.utils.all;
use xil_defaultlib.common_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- This is only a partial implementation; for the moment I am focusing on
-- familiarizing with the elementary steps that form the AES algorithm and
-- their hardware implementation. The idea is to start by implementing the
-- first round up to the mix column step
entity aes_ip is
    port (
        i_enable: in std_logic;
        i_textin : in std_logic_vector (word_width_bit - 1 downto 0);
        i_rst : in std_logic;
        i_ck : in std_logic;
        o_textout : out std_logic_vector (word_width_bit - 1 downto 0)
    );
end aes_ip;


architecture behavioral of aes_ip is

    constant key: aes_matrix := (others => (others => (others => '1')));--'11010101'));
    signal w_iword_width_byte: aes_matrix;
    signal r_addrkey_out: aes_matrix;
    signal r_sbox_out: aes_matrix;
    signal r_out_bytes: aes_matrix;

begin

    -- Simply a conversion from std_logic_vector to the matrix type I use to manage internal operations
    w_iword_width_byte <= in_conversion(i_textin);

    -- Perform an AddRoundKey steps
    add_round_key: process(i_ck)
    begin
        if rising_edge(i_ck) and i_enable = '1' then
            if i_rst = '1' then
                r_addrkey_out <= (others => (others => (others => '0')));
            else
                for idx_r in n_rows - 1 downto 0 loop
                    for idx_c in n_cols - 1 downto 0 loop
                        r_addrkey_out(idx_r)(idx_c) <= w_iword_width_byte(idx_r)(idx_c) xor key(idx_r)(idx_c);
                    end loop;
                end loop;
            end if;  
        end if;
    end process add_round_key;
   
    sub_bytes: process(i_ck)
    variable sbox_idx: integer;
    begin
        if rising_edge(i_ck) then
            if i_rst = '1' then
                r_sbox_out <= (others => (others => (others => '0')));
            else
                for idx_r in n_rows - 1 downto 0 loop
                    for idx_c in n_cols - 1 downto 0 loop
                        sbox_idx := to_integer(unsigned(r_addrkey_out(idx_r)(idx_c)));
                        r_sbox_out(idx_r)(idx_c) <= s_box(sbox_idx);
                    end loop;
                end loop;
            end if;
        end if;
    end process sub_bytes;
    


--    test_rotation: process (i_ck, i_rst)
--    begin
--        if i_rst = '1' then
--            r_out_bytes <= (others => (others => (others => '0')));
--        elsif rising_edge(i_ck) then
--            for idx_r in n_rows - 1 downto 0 loop
--                for idx_c in n_cols - 1 downto 0 loop
--                    r_out_bytes(idx_r)(idx_c) <= rotr(r_addrkey_out(idx_r)(idx_c), 3);
--                end loop;
--            end loop; 
--        end if;
--    end process;


    -- Simply a conversion from the matrix type I use to manage internal operations to std_logic_vector
    o_textout <= out_conversion(r_sbox_out);

end behavioral;
