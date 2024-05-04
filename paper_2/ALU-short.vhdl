library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
    a : in std_logic_vector (15 downto 0); -- Eingang A
    b : in std_logic_vector (15 downto 0); -- Eingang B
    sel : in std_logic_vector (2 downto 0); -- Operation
    y : out std_logic_vector (15 downto 0); -- Ausgang
    zero: out std_logic -- gesetzt, falls Eingang B = 0
    );
end ALU;

architecture RTL of ALU32 is
begin
    process (a, b, sel) -- alle Eingänge in Sensitivitätsliste
    begin
        case sel is
            when "00" => y <= a + b; -- Addition
            when "01" => y <= a AND b; -- Bitweises UND
            when "10" => y <= a OR b; -- Bitweises ODER
            when "11" => y <= XOR b; -- Bitweises XOR
        end case;
    end process;
end RTL;
y <= temp;
zero <= '1' when temp = (others => '0') else '0';