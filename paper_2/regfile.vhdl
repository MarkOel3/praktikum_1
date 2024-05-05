library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGFILE is
    port (
    clk: in std_logic;
    out0_data: out std_logic_vector (15 downto 0); -- Datenausgang 0
    out0_sel: in std_logic_vector (2 downto 0); -- Register-Nr. 0
    out1_data: out std_logic_vector (15 downto 0); -- Datenausgang 1
    out1_sel: in std_logic_vector (2 downto 0); -- Register-Nr. 1
    in_data: in std_logic_vector (15 downto 0); -- Dateneingang
    in_sel: in std_logic_vector (2 downto 0); -- Register-Wahl
    load_lo, load_hi: in std_logic); -- Register laden
end REGFILE;

architecture RTL of REGFILE is
    type t_regfile is array (0 to 7) of std_logic_vector (15 downto 0);
    signal reg: t_regfile;

begin
    -- Process 1: übernimmt das Laden von Registern
    process (clk, in_data, in_sel, load_lo, load_hi) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        if rising_edge (clk) then
            if load_lo = '1' then
				reg(to_integer(unsigned(in_sel)))(7 downto 0) <= in_data(7 downto 0);
			end if;
            if load_hi = '1' then
				reg(to_integer(unsigned(in_sel)))(15 downto 8) <= in_data(15 downto 8);
			end if; 
		end if;
    end process;

    -- Process 2: Beschreibt Ausgabe, wird von Reginhalt und Ausgangswahlleitung getriggert
    process (reg, out0_sel, out1_sel) -- wichtig: alle Eingänge in Sensitivitätsliste
    begin
        out0_data <= reg(to_integer(unsigned(out0_sel)));
        out1_data <= reg(to_integer(unsigned(out1_sel)));
    end process;
end RTL;



