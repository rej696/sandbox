library ieee;
    use ieee.std_logic_1164.all;

entity top is
    generic (DEBOUNCE_LIMIT : integer := 250000);
    port (
        i_Clk: in std_logic;
        i_Switch_1 : in std_logic;
        i_Switch_2 : in std_logic;
        o_LED_1 : out std_logic;
        o_LED_2 : out std_logic;
        o_LED_3 : out std_logic;
        o_LED_4 : out std_logic
    );
end entity top;

architecture rtl of top is
    signal r_LFSR_Toggle : std_logic := '0';
    signal w_LFSR_Done : std_logic;
begin
    lfsr_22: entity work.LFSR_22
        port map (
            i_Clk => i_Clk,
            o_LFSR_Data => open, -- unconnected
            o_LFSR_Done => w_LFSR_Done);

    process (i_Clk) is
    begin
        if rising_edge(i_Clk) then
            if w_LFSR_Done = '1' then
                r_LFSR_Toggle <= not r_LFSR_Toggle;
            end if;
        end if;
    end process;

    demux: entity work.Demux_1to4
        port map (
            i_Data => r_LFSR_Toggle,
            i_Sel_0 => i_Switch_1,
            i_Sel_1 => i_Switch_2,
            o_Data_0 => o_LED_1,
            o_Data_1 => o_LED_2,
            o_Data_2 => o_LED_3,
            o_Data_3 => o_LED_4);

end architecture rtl;
