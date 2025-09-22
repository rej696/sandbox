library ieee;
  use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  use std.env.finish;

entity ram_2port_tb
is
end ram_2port_tb;

architecture behaviour of ram_2port_tb
is
    constant ADDRESS_WIDTH : integer := 8;
    constant DATA_WIDTH : integer := 16;
    constant DEPTH: integer := 2 ** ADDRESS_WIDTH;
    subtype t_Addr is std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
    subtype t_Reg is std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal r_Clk : std_logic := '0';

    signal r_Wr_Addr : t_Addr := (others => '0');
    signal r_Wr_DataValid : std_logic := '0';
    signal r_Wr_Data : t_Reg := (others => '0');

    signal r_Rd_Addr : t_Addr := (others => '0');
    signal r_Rd_En : std_logic := '0';
    signal w_Rd_DataValid : std_logic := '0';
    signal w_Rd_Data : t_Reg := (others => '0');

    function to_addr(value: integer) return t_Addr is
    begin
        return t_Addr(to_unsigned(value, t_Addr'length));
    end to_addr;
    function to_reg(value: integer) return t_Reg is
    begin
        return t_Reg(to_unsigned(value, t_Reg'length));
    end to_reg;
begin
    r_Clk <= not r_Clk after 2 ns;

    uut: entity work.RAM_2Port
    generic map (
        WIDTH => DATA_WIDTH,
        DEPTH => DEPTH)
    port map (
        i_Wr_Clk => r_Clk,
        i_Wr_Addr => r_Wr_Addr,
        i_Wr_DataValid => r_Wr_DataValid,
        i_Wr_Data => r_Wr_Data,

        i_Rd_Clk => r_Clk,
        i_Rd_Addr => r_Rd_Addr,
        i_Rd_En => r_Rd_En,
        o_Rd_DataValid => w_Rd_DataValid,
        o_Rd_Data => w_Rd_Data
    );


    process
    begin
        wait until r_Clk = '1';
        wait until r_Clk = '1';

        -- fill memory with incrementing pattern
        for i in 0 to DEPTH - 1 loop
            r_Wr_Data <= to_reg(i);
            r_Wr_Addr <= to_addr(i);
            r_Wr_DataValid <= '1';
            wait until r_Clk = '1';
        end loop;

        r_Wr_Addr <= to_addr(0);
        r_Wr_DataValid <= '0';


        -- read out pattern
        for i in 0 to DEPTH - 1 loop
            r_Rd_En <= '1';
            r_Rd_Addr <= to_addr(i);
            wait until r_Clk = '1';
            wait until rising_edge(r_Clk);
            assert w_Rd_DataValid = '1';
            assert w_Rd_Data = to_reg(i);
        end loop;

        r_Rd_En <= '0';
        wait until r_Clk = '1';
        wait until r_Clk = '1';
        wait until r_Clk = '1';

        -- r_Wr_DataValid <= '1';
        -- r_Wr_Addr <= to_addr(54);
        -- r_Wr_Data <= to_reg(42);
        --
        -- r_Wr_DataValid <= '0';
        --
        -- r_Rd_Addr <= to_addr(54);
        -- r_Rd_En <= '1';
        --
        -- wait until rising_edge(r_Clk);
        --
        -- r_Rd_En <= '0';
        -- wait until rising_edge(r_Clk);
        --
        -- assert w_Rd_DataValid = '1';
        -- assert w_Rd_Data = to_reg(42);
        --
        -- wait until rising_edge(r_Clk);
        -- assert w_Rd_DataValid = '0';


        wait for 24 ns;

        finish;
    end process;
end behaviour;
