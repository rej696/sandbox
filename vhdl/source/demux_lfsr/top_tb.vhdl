library ieee;
  use ieee.std_logic_1164.all;
  use std.env.finish;

entity top_tb
is
end top_tb;

architecture behaviour of top_tb
is
    constant DEBOUNCE_LIMIT : integer := 2;
    signal i_Clk : std_logic := '0';
    signal i_Switch_1 : std_logic := '0';
    signal i_Switch_2 : std_logic := '0';
    signal i_Switch_3 : std_logic := '0';
    signal i_Switch_4 : std_logic := '0';
    signal o_LED_1 : std_logic;
    signal o_LED_2 : std_logic;
    signal o_LED_3 : std_logic;
    signal o_LED_4 : std_logic;
begin
    i_Clk <= not i_Clk after 2 ns;

    uut: entity work.top
        generic map (
            DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch_1 => i_Switch_1,
            i_Switch_2 => i_Switch_2,
            i_Switch_3 => i_Switch_3,
            i_Switch_4 => i_Switch_4,
            o_LED_1 => o_LED_1,
            o_LED_2 => o_LED_2,
            o_LED_3 => o_LED_3,
            o_LED_4 => o_LED_4);

    process
        type pattern_t is record
            s1, s2, s3, s4: std_logic;
        end record;
        -- The patterns to apply.
        type pattern_array_t is array (natural range <>) of pattern_t;
        constant patterns: pattern_array_t := (
            ('0', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '0', '1'),
            ('0', '0', '0', '0'),
            ('1', '1', '1', '1'),
            ('0', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('1', '0', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '1', '0', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '1', '0'),
            ('0', '0', '0', '1'),
            ('0', '0', '0', '1'),
            ('0', '0', '0', '1'),
            ('0', '0', '0', '1'),
            ('0', '0', '0', '1'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('0', '1', '0', '1'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '0', '1', '0'),
            ('0', '0', '0', '0'),
            ('1', '1', '1', '1'),
            ('1', '1', '1', '1'),
            ('1', '1', '1', '1'),
            ('1', '1', '1', '1'),
            ('1', '1', '1', '1'),
            ('1', '1', '1', '1')
        );
    begin
        wait for 10 ns;
        i_Switch_1 <= '1';
        i_Switch_2 <= '1';
        i_Switch_3 <= '1';
        i_Switch_4 <= '1';

        wait until rising_edge(i_Clk);
        i_Switch_1 <= '0';
        i_Switch_2 <= '0';
        i_Switch_3 <= '0';
        i_Switch_4 <= '0';

        wait until rising_edge(i_Clk);
        i_Switch_1 <= '1';
        i_Switch_2 <= '1';
        i_Switch_3 <= '1';
        i_Switch_4 <= '1';

        wait for 16 ns;

        -- clear everything
        i_Switch_1 <= '0';
        i_Switch_2 <= '0';
        i_Switch_3 <= '0';
        i_Switch_4 <= '0';

        wait for 24 ns;

        i_Switch_1 <= '1';
        i_Switch_2 <= '0';
        i_Switch_3 <= '1';
        i_Switch_4 <= '0';

        wait until rising_edge(i_Clk);
        i_Switch_1 <= '0';
        i_Switch_2 <= '1';
        i_Switch_3 <= '0';
        i_Switch_4 <= '1';

        wait until rising_edge(i_Clk);
        i_Switch_1 <= '1';
        i_Switch_2 <= '1';
        i_Switch_3 <= '1';
        i_Switch_4 <= '1';

        wait for 16 ns;

        -- clear everything
        i_Switch_1 <= '0';
        i_Switch_2 <= '0';
        i_Switch_3 <= '0';
        i_Switch_4 <= '0';

        wait for 24 ns;

        wait for 24 ns;

        finish;
    end process;
end behaviour;
