library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end ALU_tb;

architecture TESTBENCH2 of ALU_tb is
    -- Component declaration
  component ALU is
    port (
        a : in std_logic_vector (15 downto 0); 
        b : in std_logic_vector (15 downto 0); 
        sel : in std_logic_vector (2 downto 0); -- Operation
        y: out std_logic_vector(15 downto 0); 
        zero: out std_logic); -- gesetzt, falls Eingang B = 0
  end component;
  
	-- Configuration
	for IMPL: ALU use entity WORK.ALU(RTL);

    -- Internal signals
    signal a, b : std_logic_vector (15 downto 0);
    signal sel : std_logic_vector (2 downto 0);
    signal y : std_logic_vector (15 downto 0);
    signal zero : std_logic;

begin

  -- Instantiate full adder...
  IMPL: ALU port map (a => a, b => b, sel => sel, y => y, zero => zero);

  -- Main process...
 process
	constant period: time := 25 ns;
  begin
		
		
		-- Test case 1: Add
        a <= "0000000000000010";
        b <= "0000000000000011";
        sel <= "000";
        wait for period;
        assert y = "0000000000000101" and zero = '0'
			report "Implementation is wrong! (a=0000000000000010, b=0000000000000011, c=000)";
        
        -- Test case 2: Sub
        a <= "0000000000000100";
        b <= "0000000000000010";
        sel <= "001";
        wait for period;
        assert y = "0000000000000010" and zero = '0'
			report "Implementation is wrong! (a=0000000000000100, b=0000000000000010, c=001)";
        
        -- Test case 3: SAL
        a <= "0000000000000110";
        sel <= "010";
        wait for period;
        assert y = "0000000000001100"
			report "Implementation is wrong! (a=0000000000000110, c=010)";
        
        -- Test case 4: SAR
        a <= "0000000000001000";
        sel <= "011";
        wait for period;
        assert y = "0000000000000100"
			report "Implementation is wrong! (a=0000000000001000, c=011)";
        
        -- Test case 5: AND
        a <= "0000000000001010";
        b <= "0000000000000001";
        sel <= "100";
        wait for period;
        assert y = "0000000000000000" and zero = '0'
			report "Implementation is wrong! (a=0000000000001010, b=0000000000000001, c=100)";
        
        -- Test case 6: OR
        a <= "0000000000001100";
        b <= "0000000000000000";
        sel <= "101";
        wait for period;
        assert y = "0000000000001100" and zero = '1'
			report "Implementation is wrong! (a=0000000000001100, b=0000000000000000, c=101)";
        
        -- Test case 7: XOR
        a <= "0000000000001110";
        b <= "0000000000001110";
        sel <= "110";
        wait for period;
        assert y = "0000000000000000" and zero = '0'
			report "Implementation is wrong! (a=0000000000001110, b=0000000000001110, c=110)";
        
        -- Test case 8: NOT
        a <= "0000000000010000";
        sel <= "111";
        wait for period;
        assert y = "1111111111101111"
			report "Implementation is wrong! (a=0000000000010000, c=111)";
        
        -- Print a note & finish simulation now
		assert false report "Simulation finished" severity note;
		wait;               -- end simulation
    end process;

end TESTBENCH2;
