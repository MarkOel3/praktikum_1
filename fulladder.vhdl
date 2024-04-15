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

architecture DATAFLOW of FULL_ADDER is
begin
    sum <= a xor b xor c;
    carry <= (a and b) or (a and c) or (b and c);
end DATAFLOW;

architecture STRUCTURE of FULL_ADDER is

    component XOR2
      port (x, y: in std_logic; z: out std_logic);
    end component;
  
    component AND2
      port (x, y: in std_logic; z: out std_logic);
    end component;

    component OR2
      port (x, y: in std_logic; z: out std_logic);
    end component;
  
    for I0: XOR2 use entity WORK.XOR2(TIMED_DATAFLOW);
    for I1: AND2 use entity WORK.AND2(TIMED_DATAFLOW);
    for I2: OR2 use entity WORK.AND2(TIMED_DATAFLOW);
  
begin
    I0: XOR2 port map(x => a, y => b, z => sum);
    I1: AND2 port map(x => a, y => b, z => carry);
    I2: OR2 port map(x => a, y => b, z => carry);
end STRUCTURE;