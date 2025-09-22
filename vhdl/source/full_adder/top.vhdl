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
    component adder
        port (i0, i1: in std_logic; ci: in std_logic; s: out std_logic; co: out std_logic);
    end component;

    -- Specifies which entity is bound with the component.
    for adder_0: adder use entity work.adder;
    for adder_1: adder use entity work.adder;

    signal carry1, carry2: std_logic;
    signal sum1, sum2: std_logic;
begin
    adder_0: adder port map (
        i0 => i_Switch_2,
        i1 => i_Switch_4,
        ci => '0',
        s => sum1,
        co => carry1
    );

    adder_1: adder port map (
        i0 => i_Switch_1,
        i1 => i_Switch_3,
        ci => carry1,
        s => sum2,
        co => carry2
    );

    o_LED_1 <= '0';
    o_LED_2 <= carry2;
    o_LED_3 <= sum2;
    o_LED_4 <= sum1;

end architecture rtl;
