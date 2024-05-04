library IEEE;
use IEEE.std_logic_1164.all;


entity FULL_ADDER_TB is
end FULL_ADDER_TB;


architecture TESTBENCH2 of FULL_ADDER_TB is

  -- Component declaration...
  component FULL_ADDER is
    port (a, b, c: in std_logic; sum, carry: out std_logic);
  end component;

  -- Configuration...
  for SPEC: FULL_ADDER use entity WORK.FULL_ADDER(BEHAVIOR);
  for IMPL: FULL_ADDER use entity WORK.FULL_ADDER(STRUCTURE);

  -- Internal signals...
  signal a, b, c, sum_spec, carry_spec, sum_impl, carry_impl: std_logic;

begin

  -- Instantiate full adder...
  SPEC: FULL_ADDER port map (a => a, b => b, c => c, sum => sum_spec, carry => carry_spec);
  IMPL: FULL_ADDER port map (a => a, b => b, c => c, sum => sum_impl, carry => carry_impl);

  -- Main process...
  process
    variable pre_delay: time := 100 ns;
    variable delay: time := 9 ns;
  begin
    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '0'; b <= '0'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=0, b=0, c=0)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '0'; b <= '1'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=0, b=1, c=0)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '1'; b <= '0'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=1, b=0, c=0)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '1'; b <= '1'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=1, b=1, c=0)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '0'; b <= '0'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=0, b=0, c=1)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '0'; b <= '1'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=0, b=1, c=1)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '1'; b <= '0'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=1, b=0, c=1)";

    a <= 'X'; b <= 'X'; c <= 'X';
    wait for pre_delay;
    a <= '1'; b <= '1'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum_spec = sum_impl and carry_spec = carry_impl
        report "Specification and implementation differ! (a=1, b=1, c=1)";

    -- Print a note & finish simulation now
    assert false report "Simulation finished" severity note;
    wait;               -- end simulation

  end process;

end architecture;


architecture TESTBENCH1 of FULL_ADDER_TB is

  -- Component declaration
  component FULL_ADDER is
    port (a, b, c: in std_logic; sum, carry: out std_logic);
  end component;

  -- Configuration...
  for IMPL: FULL_ADDER use entity WORK.FULL_ADDER(STRUCTURE);

  -- Internal signals...
  signal a, b, c, sum, carry: std_logic;

begin

  -- Instantiate half adder
  IMPL: FULL_ADDER port map (a => a, b => b, c => c, sum => sum, carry => carry);

  -- Main process...
  process
    variable delay: time := 9 ns;
  begin
    a <= '0'; b <= '0'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum = '0' and carry = '0' report "0 + 0 + 0 is not 0/0!";

    a <= '0'; b <= '1'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum = '1' and carry = '0' report "0 + 1 + 0 is not 1/0!";

    a <= '1'; b <= '0'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum = '1' and carry = '0' report "1 + 0 + 0 is not 1/0!";

    a <= '1'; b <= '1'; c <= '0';
    wait for delay;      -- wait a bit
    assert sum = '0' and carry = '1' report "1 + 1 + 0 is not 0/1!";

    a <= '0'; b <= '0'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum = '1' and carry = '0' report "0 + 0 + 1 is not 1/0!";

    a <= '0'; b <= '1'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum = '0' and carry = '1' report "0 + 1 + 1 is not 0/1!";

    a <= '1'; b <= '0'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum = '0' and carry = '1' report "1 + 0 + 1 is not 0/1!";

    a <= '1'; b <= '1'; c <= '1';
    wait for delay;      -- wait a bit
    assert sum = '1' and carry = '1' report "1 + 1 + 1 is not 1/1!";

    -- Print a note & finish simulation now
    assert false report "Simulation finished" severity note;
    wait;               -- end simulation

  end process;

end architecture;