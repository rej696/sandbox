library ieee;
    use ieee.std_logic_1164.all;

entity top is
    generic (COUNT_LIMIT : integer := 4194303);
    port (
        i_Clk : in std_logic;
        i_Switch_1 : in std_logic;
        i_Switch_2 : in std_logic;
        o_LED_1 : out std_logic;
        o_LED_2 : out std_logic;
        o_LED_3 : out std_logic;
        o_LED_4 : out std_logic
    );
end entity top;

architecture rtl of top is
    signal w_Counter_Toggle : std_logic;
begin
    count_and_toggle: entity work.Count_and_Toggle
        generic map (COUNT_LIMIT => COUNT_LIMIT)
        port map (
            i_Clk => i_Clk,
            i_Enable => '1',
            o_Toggle => w_Counter_Toggle);

    demux: entity work.Demux_1to4
        port map (
            i_Data => w_Counter_Toggle,
            i_Sel_0 => i_Switch_1,
            i_Sel_1 => i_Switch_2,
            o_Data_0 => o_LED_1,
            o_Data_1 => o_LED_2,
            o_Data_2 => o_LED_3,
            o_Data_3 => o_LED_4);

end architecture rtl;
