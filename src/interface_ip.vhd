----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.08.2023 15:07:14
-- Design Name: 
-- Module Name: interface_ip - Behavioral
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
library xil_defaultlib;
use ieee.std_logic_1164.all;
use xil_defaultlib.aes_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interface_ip is
    Port ( i_byte_ready : in std_logic;
           i_byte : in std_logic_vector (byte_len - 1 downto 0);
           i_ck : in std_logic;
           i_rst : in std_logic;
           o_word : out std_logic_vector (127 downto 0);
           o_data_seen : out std_logic;
           o_word_ready : out std_logic);
end interface_ip;



architecture Behavioral of interface_ip is

    signal r_num: integer;
    signal r_present_state: interface_states;
    signal w_next_state: interface_states;

begin

    compute_next_state: process(all)
    begin

        if i_rst = '1' then
            w_next_state <= idle;
        else
            case r_present_state is
            when idle =>
                if i_byte_ready = '0' then
                    w_next_state <= idle;
                else                        
                    w_next_state <= save;
                end if;
            when save =>
                if r_num = n_bytes then
                    w_next_state <= idle;
                else
                    w_next_state <= reset_count;
                end if;
            when reset_count =>
                w_next_state <= idle;
            end case;
        end if;        

    end process compute_next_state;


    state_reg: process(i_ck)
    begin

        if rising_edge(i_ck) then
            if i_rst = '1' then
                r_present_state <= idle;
            else
                r_present_state <= w_next_state;
            end if;
        end if;

    end process state_reg;


    do_stuff: process(i_ck)
    begin

        if rising_edge(i_ck) then
            if i_rst <= '1' then
                o_word <= (others => '0');
            else
                case r_present_state is
                when idle =>
                    if i_byte_ready = '1' and r_num = 0 then
                        o_word <= (others => '0');
                    end if;
                when save =>
                    o_word(r_num + 7 downto r_num) <= i_byte;
                    r_num <= r_num + 1;
                    o_data_seen <= '1';
                when reset_count  =>
                    r_num <= 0;
                    o_word_ready <= '1';
                end case;
            end if;
        end if;
    
    end process do_stuff;

end Behavioral;