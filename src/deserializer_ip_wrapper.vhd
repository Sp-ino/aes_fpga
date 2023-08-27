library ieee;
library xil_defaultlib;
use ieee.std_logic_1164.all;
use xil_defaultlib.aes_pkg.all;


entity deserializer_ip_wrapper is
    port (
        i_byte_ready : in std_logic;
        i_byte : in std_logic_vector (byte_len - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_word : out std_logic_vector (127 downto 0);
        o_data_seen : out std_logic;
        o_word_ready : out std_logic
    );
end deserializer_ip_wrapper;


architecture Structure of deserializer_ip_wrapper is

    component deserializer_ip is
    port (
        i_byte_ready : in std_logic;
        i_byte : in std_logic_vector (byte_len - 1 downto 0);
        i_ck : in std_logic;
        i_rst : in std_logic;
        o_word : out std_logic_vector (127 downto 0);
        o_data_seen : out std_logic;
        o_word_ready : out std_logic
    );
    end component;

begin

    interf: deserializer_ip
    port map (
        i_byte_ready => i_byte_ready,
        i_byte => i_byte,
        i_ck => i_ck,
        i_rst => i_rst,
        o_word => o_word,
        o_data_seen => o_data_seen,
        o_word_ready => o_word_ready
    );

end Structure;
    