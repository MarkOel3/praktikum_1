library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity HALF_ADDER is
  port (a, b: in std_logic; sum, carry: out std_logic);
end HALF_ADDER;


architecture BEHAVIOR of HALF_ADDER is
  -- Declare the component
  component AND2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  component XOR2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  -- Internal signal to connect the AND2 component
  signal xor2_output: std_logic;
  signal and2_output: std_logic;
begin
  -- Instantiate the custom AND2 component
  I0: AND2 port map (x => a, y => b, z => and2_output);
  I1: XOR2 port map (x => a, y => b, z => xor2_output);

  -- Connect the output of the XOR2 component to the sum output
  sum <= xor2_output;

  -- Connect the output of the AND2 component to the carry output
  carry <= and2_output;
end BEHAVIOR;


architecture TIMED_DATAFLOW of HALF_ADDER is
  -- Declare the component
  component AND2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  component XOR2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  -- Internal signal to connect the AND2 component
  signal xor2_output: std_logic;
  signal and2_output: std_logic;
begin
  -- Instantiate the custom AND2 component
  I0: AND2 port map (x => a, y => b, z => and2_output);
  I1: XOR2 port map (x => a, y => b, z => xor2_output);

  -- Connect the output of the XOR2 component to the sum output
  sum <= xor2_output;

  -- Connect the output of the AND2 component to the carry output
  carry <= and2_output;
end TIMED_DATAFLOW;


architecture STRUCTURE of HALF_ADDER is

  component XOR2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  component AND2
    port (x, y: in std_logic; z: out std_logic);
  end component;

  for I0: XOR2 use entity WORK.XOR2(TIMED_DATAFLOW);
  for I1: AND2 use entity WORK.AND2(TIMED_DATAFLOW);

begin
  I0: XOR2 port map(x => a, y => b, z => sum);
  I1: AND2 port map(x => a, y => b, z => carry);
end STRUCTURE;
