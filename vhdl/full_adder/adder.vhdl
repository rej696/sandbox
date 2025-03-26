library ieee;
  use ieee.std_logic_1164.all;

entity adder is
  -- `i0`, `i1`, and the carry-in `ci` are inputs of the adder.
  -- `s` is the sum output, `co` is the carry-out.
  port (
    i0 : in    std_logic;
    i1 : in    std_logic;
    ci : in    std_logic;
    s  : out   std_logic;
    co : out   std_logic
  );
end entity adder;

architecture rtl of adder is

begin

  -- This full-adder architecture contains two concurrent assignments.
  -- Compute the sum.
  s  <= i0 xor i1 xor ci;
  co <= (i0 and i1) or (i0 and ci) or (i1 and ci);

end architecture rtl;
