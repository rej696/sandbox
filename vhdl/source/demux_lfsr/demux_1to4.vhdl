library ieee;
  use ieee.std_logic_1164.all;

entity Demux_1to4 is
    port (
        i_Data : in std_logic;
        i_Sel_0 : in std_logic;
        i_Sel_1 : in std_logic;
        o_Data_0 : out std_logic;
        o_Data_1 : out std_logic;
        o_Data_2 : out std_logic;
        o_Data_3 : out std_logic);
end entity Demux_1to4;

architecture rtl of Demux_1to4 is
begin
    o_Data_0 <= i_Data when i_Sel_1 = '0' and i_Sel_0 = '0' else '0';
    o_Data_1 <= i_Data when i_Sel_1 = '0' and i_Sel_0 = '1' else '0';
    o_Data_2 <= i_Data when i_Sel_1 = '1' and i_Sel_0 = '0' else '0';
    o_Data_3 <= i_Data when i_Sel_1 = '1' and i_Sel_0 = '1' else '0';
end architecture rtl;
