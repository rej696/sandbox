library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_2Port is
    generic (
        WIDTH : integer := 16;
        DEPTH : integer := 256);
    port (
        i_Wr_Clk : in std_logic;
        i_Wr_Addr : in std_logic_vector;
        i_Wr_DataValid : in std_logic;
        i_Wr_Data : in std_logic_vector(WIDTH - 1 downto 0);

        i_Rd_Clk : in std_logic;
        i_Rd_Addr : in std_logic_vector;
        i_Rd_En : in std_logic;
        o_Rd_DataValid : out std_logic;
        o_Rd_Data : out std_logic_vector(WIDTH - 1 downto 0));

end entity RAM_2Port;

architecture rtl of RAM_2Port is
    subtype t_Reg is std_logic_vector(WIDTH - 1 downto 0);
    type t_Mem is array (0 to DEPTH - 1) of t_Reg;
    signal r_Mem : t_Mem;
    signal w_Rd_Data : t_Reg := (others => '0');
    signal w_Rd_DataValid : std_logic := '0';
begin

    process (i_Wr_Clk)
    begin
        if rising_edge(i_Wr_Clk) then
            if i_Wr_DataValid = '1' then
                r_Mem(to_integer(unsigned(i_Wr_Addr))) <= i_Wr_Data;
            end if;
        end if;
    end process;

    process (i_Rd_Clk)
    begin
        if rising_edge(i_Wr_Clk) then
            w_Rd_Data <= r_Mem(to_integer(unsigned(i_Rd_Addr)));
            w_Rd_DataValid <= i_Rd_En;
        end if;
    end process;

    o_Rd_DataValid <= w_Rd_DataValid;
    o_Rd_Data <= w_Rd_Data;

end architecture rtl;
