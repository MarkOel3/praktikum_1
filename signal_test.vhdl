library IEEE;
use IEEE.std_logic_1164.all;


entity TEST is
  port (clk: in std_logic);
end TEST;


architecture BEHAVIOR of TEST is
  signal a, b, c: std_logic := '0';
  signal v_a_sig, v_b_sig, v_c_sig: std_logic := '0';
begin

  process
  begin
    wait until rising_edge (clk);
    a <= '1';
    b <= not (a or c);
    c <= not b;
  end process;

  process
    variable v_a, v_b, v_c: std_logic := '0';
  begin
    wait until rising_edge (clk);
    v_a := '1';
    v_b := not (v_a or v_c);
    v_c := not v_b;

    -- Mirror variables to signals
    v_a_sig <= v_a;
    v_b_sig <= v_b;
    v_c_sig <= v_c;
  end process;

end BEHAVIOR;