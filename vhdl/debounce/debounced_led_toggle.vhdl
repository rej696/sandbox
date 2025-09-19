library ieee;
  use ieee.std_logic_1164.all;

entity Debounced_LED_Toggle is
    generic (DEBOUNCE_LIMIT : integer := 20);
    port (
        i_Clk: in std_logic;
        i_Switch : in std_logic;
        o_LED : out std_logic
    );
end entity Debounced_LED_Toggle;

architecture rtl of Debounced_LED_Toggle is
    signal w_Debounced_Switch: std_logic;
begin

    Debounce_Inst: entity work.Debounce_Filter
        generic map(
            DEBOUNCE_LIMIT => DEBOUNCE_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Bouncy => i_Switch,
            o_Debounced => w_Debounced_Switch);

    LED_Toggle_Inst: entity work.LED_Toggle
        port map (
            i_Clk => i_Clk,
            i_Switch => w_Debounced_Switch,
            o_LED => o_LED);

end architecture rtl;
