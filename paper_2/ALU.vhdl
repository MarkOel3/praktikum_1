library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        a : in std_logic_vector (15 downto 0); 
        b : in std_logic_vector (15 downto 0); 
        sel : in std_logic_vector (2 downto 0); -- Operation
        y: out std_logic_vector(15 downto 0); 
        zero: out std_logic); -- gesetzt, falls Eingang B = 0
end ALU;

architecture RTL of ALU is
begin
    process (a, b, sel) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        case sel is
            when "000" =>  y <= std_logic_vector(signed(a) + signed(b)); -- Addition
            when "001" =>  y <= std_logic_vector(signed(a) - signed(b)); -- Subtraction
            when "010" =>  y <= std_logic_vector(shift_left(signed(a), 1)); -- Shift left
            when "011" =>  y <= std_logic_vector(shift_right(signed(a), 1)); -- Shift right
            when "100" =>  y <= a and b; -- Bitwise AND
            when "101" =>  y <= a or b;  -- Bitwise OR
            when "110" =>  y <= a xor b; -- Bitwise XOR
            when "111" =>  y <= not a;   -- Bitwise NOT
            when others =>  y <= (others => '0'); -- Default: Output all zeros
        end case;
        
        -- Check if Input B is zero
        if b = "0000000000000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
end RTL;
