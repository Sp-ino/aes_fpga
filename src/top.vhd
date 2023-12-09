library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port (
        i_ckin : in std_logic;
        i_rst : in std_logic;
        i_rx : in std_logic;
        i_send_textout : in std_logic;
        i_start_encryption : in std_logic;
        i_acquire_textin : in std_logic;
        o_tx : out std_logic;
        o_rx_buffer_full : out std_logic;
        o_rx_count_status : out std_logic_vector(4 downto 0)
    );
end top;

architecture structure of top is

    component aes_ip is
    port (
        i_start_encryption : in std_logic;
        i_textin : in std_logic_vector ( 127 downto 0 );
        i_rst : in std_logic;
        i_ck : in std_logic;
        o_textout : out std_logic_vector ( 127 downto 0 )
    );
    end component aes_ip;

    component ckdiv_ip is
    port (
        i_ck : in std_logic;
        o_ckout : out std_logic
    );
    end component ckdiv_ip;

    component receiver is
    port (
        i_ckin : in std_logic;
        i_rst : in std_logic;
        i_rx : in std_logic;
        i_acquire_textin : in std_logic;
        o_word : out std_logic_vector ( 127 downto 0 );
        o_buffer_full : out std_logic;
        o_rx_count_status : out std_logic_vector(4 downto 0)
    );
    end component receiver;

    component transmitter is
    port (
        i_ck : in std_logic;
        i_rst : in std_logic;
        i_send_textout : in std_logic;
        i_word : in std_logic_vector ( 127 downto 0 );
        o_tx : out std_logic
    );
    end component transmitter;

    signal ckdiv_ip_ckout : std_logic;
    signal i_ckin_1 : std_logic;
    signal i_rst_1 : std_logic;
    signal i_rx_1 : std_logic;
    signal i_send_textout_1 : std_logic;
    signal i_word_1 : std_logic_vector ( 127 downto 0 );
    signal receiver_word : std_logic_vector ( 127 downto 0 );
    signal receiver_word_valid : std_logic;
    signal transmitter_tx : std_logic;

begin

    i_ckin_1 <= i_ckin;
    i_rst_1 <= i_rst;
    i_rx_1 <= i_rx;
    i_send_textout_1 <= i_send_textout;
    o_tx <= transmitter_tx;

    aes_ip_0: component aes_ip
    port map (
        i_ck => ckdiv_ip_ckout,
        i_start_encryption => i_start_encryption,
        i_rst => i_rst_1,
        i_textin(127 downto 0) => receiver_word(127 downto 0),
        o_textout(127 downto 0) => i_word_1(127 downto 0)
    );

    ckdiv_ip_0: component ckdiv_ip
    port map (
        i_ck => i_ckin_1,
        o_ckout => ckdiv_ip_ckout
    );
    
    receiver_0: component receiver
    port map (
        i_ckin => ckdiv_ip_ckout,
        i_rst => i_rst_1,
        i_rx => i_rx_1,
        i_acquire_textin => i_acquire_textin,
        o_word(127 downto 0) => receiver_word(127 downto 0),
        o_buffer_full => o_rx_buffer_full,
        o_rx_count_status => o_rx_count_status
    );
    
    transmitter_0: component transmitter
    port map (
        i_ck => ckdiv_ip_ckout,
        i_rst => i_rst_1,
        i_send_textout => i_send_textout,
        i_word(127 downto 0) => i_word_1(127 downto 0),
        o_tx => transmitter_tx
    );
end structure;
