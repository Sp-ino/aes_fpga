-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity transmitter is
  port (
    i_ck : in std_logic;
    i_rst : in std_logic;
    i_send_textout : in std_logic;
    i_word : in std_logic_vector ( 127 downto 0 );
    o_tx : out std_logic
  );
end transmitter;

architecture structure of transmitter is
    component uart_tx_ip is
    port (
    i_ck : in std_logic;
    i_rst : in std_logic;
    i_data_valid : in std_logic;
    i_data_in : in std_logic_vector ( 7 downto 0 );
    o_busy : out std_logic;
    o_tx : out std_logic
    );
    end component uart_tx_ip;

    component serializer_ip is
    port (
    i_send_textout : in std_logic;
    i_tx_busy : in std_logic;
    i_word : in std_logic_vector ( 127 downto 0 );
    i_ck : in std_logic;
    i_rst : in std_logic;
    o_byte : out std_logic_vector ( 7 downto 0 );
    o_byte_valid : out std_logic
    );
    end component serializer_ip;

    signal i_ck_1 : std_logic;
    signal i_rst_1 : std_logic;
    signal i_send_textout_1 : std_logic;
    signal i_word_1 : std_logic_vector ( 127 downto 0 );
    signal serializer_ip_byte : std_logic_vector ( 7 downto 0 );
    signal serializer_ip_byte_valid : std_logic;
    signal uart_tx_ip_busy : std_logic;
    signal uart_tx_ip_tx : std_logic;
begin

    i_ck_1 <= i_ck;
    i_rst_1 <= i_rst;
    i_send_textout_1 <= i_send_textout;
    i_word_1(127 downto 0) <= i_word(127 downto 0);
    o_tx <= uart_tx_ip_tx;

    serializer_ip_0: component serializer_ip
        port map (
        i_ck => i_ck_1,
        i_rst => i_rst_1,
        i_send_textout => i_send_textout_1,
        i_tx_busy => uart_tx_ip_busy,
        i_word(127 downto 0) => i_word_1(127 downto 0),
        o_byte(7 downto 0) => serializer_ip_byte(7 downto 0),
        o_byte_valid => serializer_ip_byte_valid
    );

    uart_tx_ip_0: component uart_tx_ip
        port map (
        i_ck => i_ck_1,
        i_data_in(7 downto 0) => serializer_ip_byte(7 downto 0),
        i_data_valid => serializer_ip_byte_valid,
        i_rst => i_rst_1,
        o_busy => uart_tx_ip_busy,
        o_tx => uart_tx_ip_tx
    );

end structure;
