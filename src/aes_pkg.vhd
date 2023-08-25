library IEEE;
use IEEE.std_logic_1164.all;



package aes_pkg is

    constant n_bytes: integer := 16;
    constant n_rows: integer := 4;
    constant n_cols: integer := 4;
    constant byte_len: integer := 8;
    constant msg_len: integer := 128;
    constant byte_cardinality: integer := 256;

    type aes_rows is array (n_cols - 1 downto 0) of std_logic_vector (byte_len - 1 downto 0);
    type aes_matrix is array (n_rows - 1 downto 0) of aes_rows;
    
    type sub_table is array (0 to byte_cardinality - 1) of std_logic_vector (byte_len - 1 downto 0);
        
    constant s_box: sub_table := (
        x"63",	x"7c",	x"77",	x"7b",	x"f2",	x"6b",	x"6f",	x"c5",	x"30",	x"01",	x"67",	x"2b",	x"fe",	x"d7",	x"ab",	x"76",
        x"ca",	x"82",	x"c9",	x"7d",	x"fa",	x"59",	x"47",	x"f0",	x"ad",	x"d4",	x"a2",	x"af",	x"9c",	x"a4",	x"72",	x"c0",
        x"b7",	x"fd",	x"93",	x"26",	x"36",	x"3f",	x"f7",	x"cc",	x"34",	x"a5",	x"e5",	x"f1",	x"71",	x"d8",	x"31",	x"15",
        x"04",	x"c7",	x"23",	x"c3",	x"18",	x"96",	x"05",	x"9a",	x"07",	x"12",	x"80",	x"e2",	x"eb",	x"27",	x"b2",	x"75",
        x"09",	x"83",	x"2c",	x"1a",	x"1b",	x"6e",	x"5a",	x"a0",	x"52",	x"3b",	x"d6",	x"b3",	x"29",	x"e3",	x"2f",	x"84",
        x"53",	x"d1",	x"00",	x"ed",	x"20",	x"fc",	x"b1",	x"5b",	x"6a",	x"cb",	x"be",	x"39",	x"4a",	x"4c",	x"58",	x"cf",
        x"d0",	x"ef",	x"aa",	x"fb",	x"43",	x"4d",	x"33",	x"85",	x"45",	x"f9",	x"02",	x"7f",	x"50",	x"3c",	x"9f",	x"a8",
        x"51",	x"a3",	x"40",	x"8f",	x"92",	x"9d",	x"38",	x"f5",	x"bc",	x"b6",	x"da",	x"21",	x"10",	x"ff",	x"f3",	x"d2",
        x"cd",	x"0c",	x"13",	x"ec",	x"5f",	x"97",	x"44",	x"17",	x"c4",	x"a7",	x"7e",	x"3d",	x"64",	x"5d",	x"19",	x"73",
        x"60",	x"81",	x"4f",	x"dc",	x"22",	x"2a",	x"90",	x"88",	x"46",	x"ee",	x"b8",	x"14",	x"de",	x"5e",	x"0b",	x"db",
        x"e0",	x"32",	x"3a",	x"0a",	x"49",	x"06",	x"24",	x"5c",	x"c2",	x"d3",	x"ac",	x"62",	x"91",	x"95",	x"e4",	x"79",
        x"e7",	x"c8",	x"37",	x"6d",	x"8d",	x"d5",	x"4e",	x"a9",	x"6c",	x"56",	x"f4",	x"ea",	x"65",	x"7a",	x"ae",	x"08",
        x"ba",	x"78",	x"25",	x"2e",	x"1c",	x"a6",	x"b4",	x"c6",	x"e8",	x"dd",	x"74",	x"1f",	x"4b",	x"bd",	x"8b",	x"8a",
        x"70",	x"3e",	x"b5",	x"66",	x"48",	x"03",	x"f6",	x"0e",	x"61",	x"35",	x"57",	x"b9",	x"86",	x"c1",	x"1d",	x"9e",
        x"e1",	x"f8",	x"98",	x"11",	x"69",	x"d9",	x"8e",	x"94",	x"9b",	x"1e",	x"87",	x"e9",	x"ce",	x"55",	x"28",	x"df",
        x"8c",	x"a1",	x"89",	x"0d",	x"bf",	x"e6",	x"42",	x"68",	x"41",	x"99",	x"2d",	x"0f",	x"b0",	x"54",	x"bb",	x"16"
    );
    
    type interface_states is (idle, save, reset_count);

    function in_conversion(tin: std_logic_vector (msg_len - 1 downto 0)) return aes_matrix;    
    function out_conversion(out_bytes: aes_matrix) return std_logic_vector;

end aes_pkg;


package body aes_pkg is

    function in_conversion(tin: std_logic_vector (msg_len - 1 downto 0)) return aes_matrix is
    -- Converts a std_logic_vector of length 128 to a 4-by-4 matrix of 8-bit std_logic_vector
        variable in_bytes: aes_matrix;

    begin

        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                in_bytes(idx_r)(idx_c) := tin(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols));
            end loop;
        end loop;
        return in_bytes;

    end in_conversion;


    function out_conversion(out_bytes: aes_matrix) return std_logic_vector is
    -- Converts a 4-by-4 matrix of 8-bit std_logic_vector to a std_logic_vector of length 128
        variable tout: std_logic_vector (msg_len - 1 downto 0);

    begin

        for idx_r in n_rows - 1 downto 0 loop
            for idx_c in n_cols - 1 downto 0 loop
                tout(byte_len*(idx_c + idx_r * n_cols + 1) - 1 downto byte_len*(idx_c + idx_r * n_cols)) := out_bytes(idx_r)(idx_c);
            end loop;
        end loop;
        return tout;

    end out_conversion;

end aes_pkg;