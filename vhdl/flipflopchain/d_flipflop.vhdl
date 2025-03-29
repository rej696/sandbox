library ieee;
  use ieee.std_logic_1164.all;

entity d_flipflop is
    port (
        CLK: in std_logic;
        D: in std_logic;
        Q: out std_logic
    );
end entity d_flipflop;

architecture rtl of d_flipflop is
    signal r_Q: std_logic := '0';
begin
    process (CLK) is
    begin
        if rising_edge(CLK) then
            r_Q <= D;
        end if;
    end process;
    Q <= r_Q;
end architecture rtl;
