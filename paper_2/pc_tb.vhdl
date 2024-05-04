library ieee;
use ieee.std_logic_1164.all;

entity PC_tb is
end PC_tb;

architecture TESTBENCH2 of PC_tb is
    -- Component declaration
  component PC is
    port (
		clk: in std_logic;
		reset, inc, load: in std_logic; -- Steuersignale
		pc_in: in std_logic_vector (15 downto 0); -- Dateneingang
		pc_out: out std_logic_vector (15 downto 0) ); -- Ausgabe Zaehlerstand
  end component;
  
	-- Configuration
	for IMPL: PC use entity WORK.PC(RTL);

    -- Internal signals
    signal clk: std_logic;
	signal reset, inc, load: std_logic; -- Steuersignale
	signal pc_in: std_logic_vector (15 downto 0); -- Dateneingang
	signal pc_out: std_logic_vector (15 downto 0);  -- Ausgabe Zaehlerstand

begin

  -- Instantiate full adder...
  IMPL: PC port map (clk => clk, reset => reset, inc => inc, load => load, pc_in => pc_in, pc_out => pc_out);

  -- Main process...
 process
	constant period: time := 25 ns;
  begin
        inc <= '1' ;
		clk <= '0' ;
		reset <= '0';
		load <= '0';
		wait for period;
		
		-- Test case 1: inc
        inc <= '1';
        clk <= '1';
        wait for period;
        assert pc_out = "0000000000000001" 
			report "Implementation is wrong! ( clk=1, inc=1, pc_out=0000000000000001)";
			
		inc <= '1' ;
		clk <= '0' ;
		reset <= '0';
		load <= '0';
		wait for period;
		
		-- Test case 2: inc
        inc <= '1';
        clk <= '1';
        wait for period;
        assert pc_out = "0000000000000010" 
			report "Implementation is wrong! ( clk=1, inc=1, pc_out=0000000000000010)";
			
			
		inc <= '1' ;
		clk <= '0' ;
		reset <= '1';
		load <= '1';
		wait for period;
		
		-- Test case 3: reset
        inc <= '1';
        clk <= '1';
        wait for period;
        assert pc_out = "0000000000000000"
			report "Implementation is wrong! ( clk=1, reset=1, pc_out=0000000000000000)";
			
			
		inc <= '0' ;
		clk <= '0' ;
		reset <= '0';
		load <= '1';
		pc_in <= "1000000000000001";
		wait for period;
		
		-- Test case 4: load
        load <= '1';
        clk <= '1';
        wait for period;
        assert pc_out = pc_in 
			report "Implementation is wrong! ( clk=1, load=1, pc_in=1000000000000001)";
        
        -- Print a note & finish simulation now
		assert false report "Simulation finished" severity note;
		wait;               -- end simulation
    end process;

end TESTBENCH2;
