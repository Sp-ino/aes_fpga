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

entity serializer_ip is
    port (
        i_transmit : in std_logic;
        i_tx_busy: in std_logic;
        i_word : in std_logic_vector (word_width_bit - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_byte : out std_logic_vector (byte_width_bit - 1 downto 0);
        o_byte_valid : out std_logic
    );
end serializer_ip;



architecture Behavioral of serializer_ip is

    signal r_num: integer range 15 downto 0;
    signal r_present_state: serializer_states;
    signal w_next_state: serializer_states;

begin

    compute_next_state: process(all)
    begin

        if i_rst = '1' then
            w_next_state <= idle;
        else
            case r_present_state is
            when idle =>
                if i_transmit = '1' then
                    if i_tx_busy = '0' then
                        w_next_state <= assert_valid;
                    else
                        w_next_state <= idle;
                    end if;
                else
                    w_next_state <= idle;
                end if;
            when assert_valid =>
                w_next_state <= pause_1;
            when pause_1 =>
                w_next_state <= pause_2;
            when pause_2 =>
                w_next_state <= pause_3;
            when pause_3 =>
                if i_tx_busy = '1' then
                    w_next_state <= pause_3;
                else
                    w_next_state <= increment;
                end if;
            when increment =>
                if r_num = word_width_byte - 1 then
                    w_next_state <= idle;
                else
                    w_next_state <= assert_valid;
                end if;
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
                o_byte <= (others => '0');
                o_byte_valid <= '0';
            else
                case r_present_state is
                when idle =>
                    r_num <= 0;
                when assert_valid =>
                    o_byte <= i_word(8*r_num + 7 downto 8*r_num);
                    o_byte_valid <= '1';
                when pause_1 =>
                    o_byte_valid <= '0';
                when pause_2 =>
                    null;
                when pause_3 =>
                    null;
                when increment =>
                    r_num <= r_num + 1;
                end case;
            end if;
        end if;
    
    end process do_stuff;

end Behavioral;
