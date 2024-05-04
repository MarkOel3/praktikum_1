library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity FULL_ADDER is
  port (a, b, c: in std_logic; sum, carry: out std_logic);
end FULL_ADDER;



architecture BEHAVIOR of FULL_ADDER is
begin
    
    process (a, b, c)
        variable a2, b2, c2, result: unsigned (1 downto 0);
    begin
        a2 := '0' & a;      -- extend 'a' to 2 bit
        b2 := '0' & b;      -- extend 'b' to 2 bit
        c2 := '0' & c;      -- extend 'c' to 2 bit
        result := a2 + b2 + c2;  -- add them
        sum <= result(0);   -- output 'sum' = lower bit
        carry <= result(1); -- output 'carry' = upper bit
    end process;
    
end BEHAVIOR;



architecture STRUCTURE of FULL_ADDER is
  -- Component Declarations
  component XOR2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  component AND2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  component OR2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  -- Binding the components to specific implementations
  for I0: XOR2 use entity WORK.XOR2(TIMED_DATAFLOW);
  for I1: AND2 use entity WORK.AND2(TIMED_DATAFLOW);
  for I2: OR2 use entity WORK.OR2(TIMED_DATAFLOW);

  -- Internal Signals
  signal a_xor_b, a_xor_b_xor_c: std_logic;
  signal a_and_b, a_and_c, b_and_c: std_logic;
  signal ab_or_ac, ab_or_ac_or_bc: std_logic;
begin
  -- XOR gates for sum calculation
  I0: XOR2 port map (x => a, y => b, z => a_xor_b);
  I3: XOR2 port map (x => a_xor_b, y => c, z => sum);  -- Second XOR gate for final sum output

  -- AND gates for carry calculation
  I1: AND2 port map (x => a, y => b, z => a_and_b);
  I4: AND2 port map (x => a, y => c, z => a_and_c);
  I5: AND2 port map (x => b, y => c, z => b_and_c);

  -- OR gates to combine the AND outputs to form the carry
  I2: OR2 port map (x => a_and_b, y => a_and_c, z => ab_or_ac);
  I6: OR2 port map (x => ab_or_ac, y => b_and_c, z => carry);  -- Final OR gate for carry output
end STRUCTURE;
