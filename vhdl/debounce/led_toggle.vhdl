library ieee;
  use ieee.std_logic_1164.all;

entity LED_Toggle is
    port (
        i_Clk: in std_logic;
        i_Switch : in std_logic;
        o_LED : out std_logic
    );
end entity LED_Toggle;

architecture rtl of LED_Toggle is
    signal r_LED : std_logic := '0';
    signal r_Switch : std_logic := '0';
begin
    process (i_Clk) is
    begin
        if rising_edge(i_Clk) then
            r_Switch <= i_Switch;
            if i_Switch = '0' and r_Switch = '1' then
                r_LED <= not r_LED;
            end if;
        end if;
    end process;

    o_LED <= r_LED;

end architecture rtl;
