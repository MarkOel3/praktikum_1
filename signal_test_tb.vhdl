library IEEE;
use IEEE.std_logic_1164.all;


entity SIGNAL_TEST_TB is
end SIGNAL_TEST_TB;

architecture TESTBENCH of SIGNAL_TEST_TB is

    -- Component declaration
    component TEST is
        port (clk: in std_logic);
    end component;
  
    -- Configuration...
    for IMPL: TEST use entity WORK.TEST(BEHAVIOR);
  
    -- Internal signals...
    signal clk: std_logic := '0';
  
  begin
  
    -- Instantiate half adder
    IMPL: TEST port map (clk => clk);
  
    -- Main process...
    process
      variable delay: time := 10 ns;
    begin
        clk <= '0';
        wait for delay;
        clk <= '1';
        wait for delay;
  
      -- Print a note & finish simulation now
      assert false report "Simulation finished" severity note;
      wait;               -- end simulation
  
    end process;
  
  end architecture;