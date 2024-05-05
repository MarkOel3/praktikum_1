library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
    port (
    clk: in std_logic;
    load: in std_logic; -- Steuersignal
    ir_in: in std_logic_vector (15 downto 0); -- Dateneingang
    ir_out: out std_logic_vector (15 downto 0) -- Datenausgang
    );
    end IR;
    

architecture RTL of IR is
    signal instruction: std_logic_vector (15 downto 0); -- Speicher für Instruktion
begin
    -- Process 1: Lädt die Instruktion in den Speicher
    process (clk, ir_in, load) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        if rising_edge (clk) then
            if load = '1' then
				instruction <= ir_in;
			end if;
		end if;
    end process;

    -- Process 2: Gibt die Instruktion aus
    process (instruction) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        ir_out <= instruction;
    end process;
end RTL;



