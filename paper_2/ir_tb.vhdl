library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR_tb is
end IR_tb;

architecture TESTBENCH2 of IR_tb is
    -- Component declaration
  component IR is
    port (
        clk: in std_logic;
        load: in std_logic; -- Steuersignal
        ir_in: in std_logic_vector (15 downto 0); -- Dateneingang
        ir_out: out std_logic_vector (15 downto 0) -- Datenausgang
    );
  end component;
  
	-- Configuration
	for IMPL: IR use entity WORK.IR(RTL);

    -- Internal signals
    signal clk, load: std_logic := '0';
    signal ir_in, ir_out: std_logic_vector (15 downto 0) := (others => '0'); -- Datenausgang 0
    
begin

  -- Instantiate full adder...
  IMPL: IR port map (clk => clk, load => load, ir_in => ir_in, ir_out => ir_out);

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
		
        ir_in <= "0000000000000000"; 
        load <= '1'; 
        run_cycle;
        assert ir_out = "0000000000000000" report "ir_out: Init does not work";
        
        ir_in <= "1110000000000111"; 
        load <= '0'; 
        run_cycle;
        assert ir_out = "0000000000000000" report "ir_out: Keep state does not work";

        ir_in <= "1110000000000111"; 
        load <= '1';  
        run_cycle;
        assert ir_out = "1110000000000111" report "ir_out: Update state does not work";

        -- Print a note & finish simulation now
		assert false report "Simulation finished" severity note;
		wait;               -- end simulation
    end process;

end TESTBENCH2;
