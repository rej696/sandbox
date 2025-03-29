library ieee;
  use ieee.std_logic_1164.all;

entity falling_edge_detection is
    port (
        i_clock: in std_logic;
        i_switch: in std_logic;
        o_output: out std_logic
    );
end entity falling_edge_detection;

architecture rtl of falling_edge_detection is
    signal r_switch: std_logic := '0';
    signal r_output: std_logic := '0';
begin
    process (i_clock) is
    begin
        if rising_edge(i_clock) then
            r_switch <= i_switch;
            if i_switch = '0' and r_switch = '1' then
                r_output <= '1';
            else
                r_output <= '0';
            end if;
        end if;
    end process;

    o_output <= r_output;
end architecture rtl;

