library ieee;
  use ieee.std_logic_1164.all;

entity top is
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

    component falling_edge_detection
        port (i_clock, i_switch: in std_logic; o_output: out std_logic);
    end component;
    
    for fed_0: falling_edge_detection use entity work.falling_edge_detection;
    for fed_1: falling_edge_detection use entity work.falling_edge_detection;

    component d_flipflop
        port (CLK, D: in std_logic; Q: out std_logic);
    end component;
    
    for flipflop_0: d_flipflop use entity work.d_flipflop;
    for flipflop_1: d_flipflop use entity work.d_flipflop;
    for flipflop_2: d_flipflop use entity work.d_flipflop;
    for flipflop_3: d_flipflop use entity work.d_flipflop;
    
    signal CLK: std_logic := '0';
    signal D: std_logic := '0';
    signal Q1: std_logic := '0';
    signal Q2: std_logic := '0';
    signal Q3: std_logic := '0';
    signal Q4: std_logic := '0';
begin
    fed_0: falling_edge_detection port map (
        i_clock => i_Clk,
        i_switch => i_Switch_1,
        o_output => CLK
    );
    
    fed_1: falling_edge_detection port map (
        i_clock => i_Clk,
        i_switch => i_Switch_2,
        o_output => D
    );

    flipflop_0: d_flipflop port map (
        CLK => CLK,
        D => i_Switch_2,
        Q => Q1
    );
    
    flipflop_1: d_flipflop port map (
        CLK => CLK,
        D => Q1,
        Q => Q2
    );

    flipflop_2: d_flipflop port map (
        CLK => CLK,
        D => Q2,
        Q => Q3
    );
        
    flipflop_3: d_flipflop port map (
        CLK => CLK,
        D => Q3,
        Q => Q4
    );

    o_LED_1 <= Q1;
    o_LED_2 <= Q2;
    o_LED_3 <= Q3;
    o_LED_4 <= Q4;

end architecture rtl;
