library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

entity debounce_filter_tb is
end entity debounce_filter_tb;


architecture test of debounce_filter_tb is
    signal r_Clk, r_Bouncy, w_Debounced : std_logic := '0';
begin
    r_Clk <= not r_Clk after 2 ns;

    uut : entity work.Debounce_Filter
        generic map (DEBOUNCE_LIMIT => 4)
        port map (
            i_Clk => r_Clk,
            i_Bouncy => r_Bouncy,
            o_Debounced => w_Debounced);

    process is
    begin
        wait for 10 ns;
        r_Bouncy <= '1';

        wait until rising_edge(r_Clk);
        r_Bouncy <= '0';

        wait until rising_edge(r_Clk);
        r_Bouncy <= '1';

        wait for 24 ns;
        finish;
    end process;
end test;
