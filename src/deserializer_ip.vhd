----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.08.2023 15:07:14
-- Design Name: 
-- Module Name: deserializer_ip - Behavioral
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

library xil_defaultlib;
use xil_defaultlib.uart_pkg.all;
use xil_defaultlib.common_pkg.all;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deserializer_ip is
    port (
        i_byte_valid : in std_logic;
        i_byte : in std_logic_vector (byte_width_bit - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_word : out std_logic_vector (word_width_bit - 1 downto 0);
        o_data_seen : out std_logic;
        o_word_valid : out std_logic
    );
end deserializer_ip;



architecture Behavioral of deserializer_ip is

    signal r_num: integer range word_width_byte downto 0 := 0;
    signal r_present_state: deserializer_states;
    signal w_next_state: deserializer_states;

begin

    compute_next_state: process(all)
    begin

        if i_rst = '1' then
            w_next_state <= idle;
        else
            case r_present_state is
            when idle =>
                if i_byte_valid = '0' then
                    w_next_state <= idle;
                else                        
                    w_next_state <= save;
                end if;
            when save =>
                w_next_state <= pause;
            when pause =>
                if r_num = word_width_byte then
                    w_next_state <= reset_count;
                else
                    w_next_state <= idle;
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
            if i_rst = '1' then
                r_num <= 0;
                o_word <= (others => '0');
                o_data_seen <= '0';
                o_word_valid <= '0';
            else
                case r_present_state is
                when idle =>
                    if i_byte_valid = '1' and r_num = 0 then
                        o_word <= (others => '0');
                    end if;
                    o_data_seen <= '0';
                when save =>
                    o_word(r_num*8 + 7 downto r_num*8) <= i_byte;
                    r_num <= r_num + 1;
                    o_data_seen <= '1';
                when pause =>
                    o_data_seen <= '0';
                when reset_count  =>
                    r_num <= 0;
                    o_word_valid <= '1';
                end case;
            end if;
        end if;
    
    end process do_stuff;

end Behavioral;
