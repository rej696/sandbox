library ieee;
  use ieee.std_logic_1164.all;

entity top is
  -- `i0`, `i1`, and the carry-in `ci` are inputs of the adder.
  -- `s` is the sum output, `co` is the carry-out.
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
end entity top;

architecture rtl of top is
    signal CLK: std_logic := '0';
    signal D: std_logic := '0';
    signal En: std_logic := '0';
    signal Q: std_logic := '0';
begin
    -- inputs
    CLK <= i_Switch_1;
    D <= i_Switch_2;
    En <= i_Switch_3;

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if En = '1' then
                Q <= D;
            end if;
        end if;
    end process;

    -- outputs
    o_LED_1 <= CLK;
    o_LED_2 <= D;
    o_LED_3 <= En;
    o_LED_4 <= Q;
end architecture rtl;
