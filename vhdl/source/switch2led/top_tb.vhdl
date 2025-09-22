library ieee;
  use ieee.std_logic_1164.all;

entity top_tb
is
end top_tb;

architecture behaviour of top_tb
is
    component top
      port (
        i_Switch_1 : in std_logic;
        i_Switch_2 : in std_logic;
        i_Switch_3 : in std_logic;
        i_Switch_4 : in std_logic;
        o_LED_1 : out std_logic;
        o_LED_2 : out std_logic;
        o_LED_3 : out std_logic;
        o_LED_4 : out std_logic
      );
    end component;

    for uut: top use entity work.top;
    signal i_Switch_1 : std_logic;
    signal i_Switch_2 : std_logic;
    signal i_Switch_3 : std_logic;
    signal i_Switch_4 : std_logic;
    signal o_LED_1 : std_logic;
    signal o_LED_2 : std_logic;
    signal o_LED_3 : std_logic;
    signal o_LED_4 : std_logic;
begin
    uut: top port map (
        i_Switch_1 => i_Switch_1,
        i_Switch_2 => i_Switch_2,
        i_Switch_3 => i_Switch_3,
        i_Switch_4 => i_Switch_4,
        o_LED_1 => o_LED_1,
        o_LED_2 => o_LED_2,
        o_LED_3 => o_LED_3,
        o_LED_4 => o_LED_4
      );

    process
        type pattern_t is record
            s1, s2, s3, s4: std_logic;
            l1, l2, l3, l4: std_logic;
        end record;
        -- The patterns to apply.
        type pattern_array_t is array (natural range <>) of pattern_t;
        constant patterns: pattern_array_t := (
            ('0', '0', '0', '0', '0', '0', '0', '0'),
            ('1', '0', '0', '0', '1', '0', '0', '0'),
            ('0', '1', '0', '0', '0', '1', '0', '0'),
            ('0', '0', '1', '0', '0', '0', '1', '0'),
            ('0', '0', '0', '1', '0', '0', '0', '1'),
            ('0', '1', '0', '1', '0', '1', '0', '1'),
            ('1', '0', '1', '0', '1', '0', '1', '0'),
            ('1', '1', '1', '1', '1', '1', '1', '1')
        );
    begin
        -- check each pattern
        for i in patterns'range loop
            i_Switch_1 <= patterns(i).s1;
            i_Switch_2 <= patterns(i).s2;
            i_Switch_3 <= patterns(i).s3;
            i_Switch_4 <= patterns(i).s4;

            -- wait for the results
            wait for 1 ns;

            -- check the outputs
            if (o_LED_1 /= patterns(i).l1)
               or (o_LED_2 /= patterns(i).l2)
               or (o_LED_3 /= patterns(i).l3)
               or (o_LED_4 /= patterns(i).l4)
            then
                assert true report "FAIL:" severity error;
                report "    Input: (" & std_logic'image(i_Switch_1) & ", "
                    & std_logic'image(i_Switch_2) & ", "
                    & std_logic'image(i_Switch_3) & ", "
                    & std_logic'image(i_Switch_4) & ")" severity note;

                report "    Expected: (" & std_logic'image(patterns(i).l1) & ", "
                    & std_logic'image(patterns(i).l2) & ", "
                    & std_logic'image(patterns(i).l3) & ")" severity note;

                report "    Got: (" & std_logic'image(o_LED_1) & ", "
                    & std_logic'image(o_LED_2) & ", "
                    & std_logic'image(o_LED_3) & ")" severity note;
            end if;
        end loop;
        assert false report "end of test" severity note;

        -- wait forever; this will finish the simulation
        wait;
    end process;
end behaviour;
