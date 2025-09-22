library ieee;
  use ieee.std_logic_1164.all;
  use std.env.finish;

entity top_tb
is
end top_tb;

architecture behaviour of top_tb
is
    constant COUNT_LIMIT : integer := 2;
    signal i_Clk : std_logic := '0';
    signal i_Switch_1 : std_logic := '0';
    signal i_Switch_2 : std_logic := '0';
    signal o_LED_1 : std_logic;
    signal o_LED_2 : std_logic;
    signal o_LED_3 : std_logic;
    signal o_LED_4 : std_logic;
begin
    i_Clk <= not i_Clk after 2 ns;

    uut: entity work.top
        generic map (
            COUNT_LIMIT => COUNT_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch_1 => i_Switch_1,
            i_Switch_2 => i_Switch_2,
            o_LED_1 => o_LED_1,
            o_LED_2 => o_LED_2,
            o_LED_3 => o_LED_3,
            o_LED_4 => o_LED_4);

    process
    begin
        wait for 10 ns;
        i_Switch_1 <= '0';
        i_Switch_2 <= '0';

        wait for 16 ns;

        i_Switch_1 <= '1';
        i_Switch_2 <= '1';

        wait for 16 ns;

        wait for 24 ns;

        finish;
    end process;
end behaviour;
