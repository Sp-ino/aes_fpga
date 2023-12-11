-- Copyright (c) 2023 Valerio Spinogatti
-- Licensed under Apache license

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity receiver is
  port (
    i_ckin : in std_logic;
    i_rst : in std_logic;
    i_rx : in std_logic;
    i_acquire_textin : in std_logic;
    o_word : out std_logic_vector ( 127 downto 0 );
    o_buffer_full : out std_logic;
    o_rx_count_status : out std_logic_vector(4 downto 0)
  );
end receiver;

architecture structure of receiver is

    component uart_rx_ip is
    port (
        i_ck : in std_logic;
        i_rx : in std_logic;
        i_rst : in std_logic;
        i_data_seen : in std_logic;
        i_flush_data : in std_logic;
        o_data_valid : out std_logic;
        o_data_out : out std_logic_vector ( 7 downto 0 )
    );
    end component uart_rx_ip;

    component deserializer_ip is
    port (
        i_byte_valid : in std_logic;
        i_byte : in std_logic_vector ( 7 downto 0 );
        i_ck : in std_logic;
        i_acquire_textin : in std_logic;
        i_rst : in std_logic;
        o_word : out std_logic_vector ( 127 downto 0 );
        o_data_seen : out std_logic;
        o_buffer_full : out std_logic;
        o_flush_uart : out std_logic;
        o_count_status : out std_logic_vector(4 downto 0)
    );
    end component deserializer_ip;

    signal net : std_logic;
    signal flush : std_logic;
    signal ckdiv_ip_0_o_ckout : std_logic;
    signal deserializer_ip_data_seen : std_logic;
    signal deserializer_ip_word : std_logic_vector ( 127 downto 0 );
    signal deserializer_ip_buffer_full : std_logic;
    signal i_rx_1 : std_logic;
    signal uart_rx_ip_0_o_data_out : std_logic_vector ( 7 downto 0 );
    signal uart_rx_ip_0_o_data_valid : std_logic;

begin
  
    net <= i_rst;
    ckdiv_ip_0_o_ckout <= i_ckin;
    i_rx_1 <= i_rx;
    o_word(127 downto 0) <= deserializer_ip_word(127 downto 0);
    o_buffer_full <= deserializer_ip_buffer_full;

    deserializer_ip_wrap_0: component deserializer_ip
    port map (
        i_byte(7 downto 0) => uart_rx_ip_0_o_data_out(7 downto 0),
        i_byte_valid => uart_rx_ip_0_o_data_valid,
        i_ck => ckdiv_ip_0_o_ckout,
        i_acquire_textin => i_acquire_textin,
        i_rst => net,
        o_data_seen => deserializer_ip_data_seen,
        o_word(127 downto 0) => deserializer_ip_word(127 downto 0),
        o_buffer_full => deserializer_ip_buffer_full,
        o_flush_uart => flush,
        o_count_status => o_rx_count_status
    );

    uart_rx_ip_0: component uart_rx_ip
    port map (
        i_ck => ckdiv_ip_0_o_ckout,
        i_data_seen => deserializer_ip_data_seen,
        i_rst => net,
        i_rx => i_rx_1,
        i_flush_data => flush,
        o_data_out(7 downto 0) => uart_rx_ip_0_o_data_out(7 downto 0),
        o_data_valid => uart_rx_ip_0_o_data_valid
    );

end structure;
