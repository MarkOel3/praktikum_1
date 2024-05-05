library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REGFILE_tb is
end REGFILE_tb;

architecture TESTBENCH2 of REGFILE_tb is
    -- Component declaration
  component REGFILE is
    port (
        clk: in std_logic;
        out0_data: out std_logic_vector (15 downto 0); -- Datenausgang 0
        out0_sel: in std_logic_vector (2 downto 0); -- Register-Nr. 0
        out1_data: out std_logic_vector (15 downto 0); -- Datenausgang 1
        out1_sel: in std_logic_vector (2 downto 0); -- Register-Nr. 1
        in_data: in std_logic_vector (15 downto 0); -- Dateneingang
        in_sel: in std_logic_vector (2 downto 0); -- Register-Wahl
        load_lo, load_hi: in std_logic); -- Register laden
  end component;
  
	-- Configuration
	for IMPL: REGFILE use entity WORK.REGFILE(RTL);

    -- Internal signals
    signal clk: std_logic := '0';
    signal out0_data: std_logic_vector (15 downto 0) := (others => '0'); -- Datenausgang 0
    signal out0_sel: std_logic_vector (2 downto 0) := (others => '0'); -- Register-Nr. 0
    signal out1_data: std_logic_vector (15 downto 0) := (others => '0'); -- Datenausgang 1
    signal out1_sel: std_logic_vector (2 downto 0) := (others => '0'); -- Register-Nr. 1
    signal in_data: std_logic_vector (15 downto 0) := (others => '0'); -- Dateneingang
    signal in_sel: std_logic_vector (2 downto 0) := (others => '0'); -- Register-Wahl
    signal load_lo, load_hi: std_logic := '0'; -- Register laden

begin

  -- Instantiate full adder...
  IMPL: REGFILE port map (clk => clk, out0_data => out0_data, out0_sel => out0_sel, out1_data => out1_data, out1_sel => out1_sel, in_data => in_data, in_sel => in_sel, load_lo => load_lo, load_hi => load_hi);

  -- Main process...
    process
	constant period: time := 25 ns;
    procedure run_cycle is
        begin
          clk <= '0';
          wait for period / 2;
          clk <= '1';
          wait for period / 2;
        end procedure;
    
    begin
		
    for n in 0 to 7 loop
        in_data <= "0000000000000000"; 
        in_sel <= std_logic_vector(to_unsigned(n, 3)); 
        load_lo <= '1'; 
        load_hi <= '1'; 
        out0_sel <= std_logic_vector(to_unsigned(n, 3)); 
        out1_sel <= std_logic_vector(to_unsigned(n, 3));
        run_cycle;
        assert out0_data = "0000000000000000" report "out0_data: Init does not work";
        assert out1_data = "0000000000000000" report "out1_data: Init does not work";
    end loop;

    for n in 0 to 7 loop
      in_data <= "1110000000000111"; 
      in_sel <= std_logic_vector(to_unsigned(n, 3)); 
      load_lo <= '0'; 
      load_hi <= '1'; 
      out0_sel <= std_logic_vector(to_unsigned(n, 3)); 
      run_cycle;
      assert out0_data = "1110000000000000" report "out0_data: load high does not work";
    end loop;
    for n in 0 to 7 loop
      in_data <= "1111110000000111"; 
      in_sel <= std_logic_vector(to_unsigned(n, 3));
      load_lo <= '1'; 
      load_hi <= '0'; 
      out1_sel <= std_logic_vector(to_unsigned(n, 3));
      run_cycle;
      assert out1_data = "1110000000000111" report "out1_data: load low does not work";
    end loop;  

        -- Print a note & finish simulation now
		assert false report "Simulation finished" severity note;
		wait;               -- end simulation
    end process;

end TESTBENCH2;
