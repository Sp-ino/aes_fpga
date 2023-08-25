library IEEE;
use IEEE.std_logic_1164.all;



package utils is

    constant vector_len: integer := 8;

    function rotl(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector;
    function rotr(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector;

end utils;


package body utils is

    function rotl(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned left rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (vector_len - 1 downto 0);
        variable temp: std_logic;

    begin

        for idx in vector_len - 1 downto 0 loop
            rotated(idx) := vector((idx - amount) mod vector_len);
        end loop;
        return rotated;

    end rotl;


    function rotr(vector: std_logic_vector (vector_len - 1 downto 0); amount: integer) return std_logic_vector is
    -- Performs an unsigned right rotation on an 8-bit std_logic_vector
        variable rotated: std_logic_vector (vector_len - 1 downto 0);
        variable temp: std_logic;

    begin

        for idx in vector_len - 1 downto 0 loop
            rotated(idx) := vector((idx + amount) mod vector_len);
        end loop;
        
        return rotated;

    end rotr;    

end utils;