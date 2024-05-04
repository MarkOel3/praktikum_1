library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port (
		clk: in std_logic;
		reset, inc, load: in std_logic; -- Steuersignale
		pc_in: in std_logic_vector (15 downto 0); -- Dateneingang
		pc_out: out std_logic_vector (15 downto 0) ); -- Ausgabe Zaehlerstand
end PC;
	
	
architecture RTL of PC is
	signal pc_reg: std_logic_vector (15 downto 0) := (others => '0');
begin
    process (clk, reset, inc, load, pc_in) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        if rising_edge (clk) then
			if reset = '1' then
				pc_reg <= (others => '0');
			elsif inc = '1' then
				pc_reg <= std_logic_vector(unsigned(pc_reg) + 1);
			elsif load = '1' then
				pc_reg <= pc_in;
			end if;
		end if;
    end process;
    pc_out <= pc_reg;
end RTL;
