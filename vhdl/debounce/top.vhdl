library ieee;
    use ieee.std_logic_1164.all;

entity top is
    generic (DEBOUNCE_LIMIT : integer := 250000);
    port (
        i_Clk: in std_logic;
        i_Switch_1 : in std_logic;
        i_Switch_2 : in std_logic;
        i_Switch_3 : in std_logic;
        i_Switch_4 : in std_logic;
        o_LED_1 : out std_logic;
        o_LED_2 : out std_logic;
        o_LED_3 : out std_logic;
        o_LED_4 : out std_logic
    );
end entity top;

architecture rtl of top is
begin
    led_1: entity work.Debounced_LED_Toggle
        generic map (DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch => i_Switch_1,
            o_LED => o_LED_1);

    led_2: entity work.Debounced_LED_Toggle
        generic map (DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch => i_Switch_2,
            o_LED => o_LED_2);

    led_3: entity work.Debounced_LED_Toggle
        generic map (DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch => i_Switch_3,
            o_LED => o_LED_3);

    led_4: entity work.Debounced_LED_Toggle
        generic map (DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Switch => i_Switch_4,
            o_LED => o_LED_4);

end architecture rtl;
