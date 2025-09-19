library ieee;
  use ieee.std_logic_1164.all;
  use std.env.finish;

entity top_tb
is
end top_tb;

architecture behaviour of top_tb is
    signal r_In1, r_In2, w_Out : std_logic;
begin
    uut: entity work.top
    port map (
        i_Switch_1 => r_In1,
        i_Switch_2 => r_In2,
        o_LED_1 => w_Out);

    process is
    begin
        r_In1 <= '0';
        r_In2 <= '0';
        wait for 10 ns;
        assert (w_Out = '0') severity failure;

        r_In1 <= '0';
        r_In2 <= '1';
        wait for 10 ns;
        assert (w_Out = '0') severity failure;

        r_In1 <= '1';
        r_In2 <= '0';
        wait for 10 ns;
        assert (w_Out = '0') severity failure;

        r_In1 <= '1';
        r_In2 <= '1';
        wait for 10 ns;
        assert (w_Out = '1') severity failure;

        wait for 10 ns;
        finish;
    end process;
end architecture behaviour;
