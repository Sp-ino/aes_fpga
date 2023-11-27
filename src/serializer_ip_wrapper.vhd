-- Wrapper for serializer block
-- 
-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license


library ieee;
use ieee.std_logic_1164.all;

library xil_defaultlib;
use xil_defaultlib.common_pkg.all;


entity serializer_ip_wrapper is
    port (
        i_transmit : in std_logic;
        i_tx_busy: in std_logic;
        i_word : in std_logic_vector (word_width_bit - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_byte : out std_logic_vector (byte_width_bit - 1 downto 0);
        o_byte_valid : out std_logic
    );
end serializer_ip_wrapper;


architecture Structure of serializer_ip_wrapper is

    component serializer_ip is
    port (
        i_transmit : in std_logic;
        i_tx_busy: in std_logic;
        i_word : in std_logic_vector (word_width_bit - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_byte : out std_logic_vector (byte_width_bit - 1 downto 0);
        o_byte_valid : out std_logic
    );
    end component;

begin

    interf: serializer_ip
    port map (
        i_transmit => i_transmit,
        i_tx_busy => i_tx_busy,
        i_word => i_word,
        i_ck => i_ck,
        i_rst => i_rst,
        o_byte => o_byte,
        o_byte_valid => o_byte_valid
    );

end Structure;
    