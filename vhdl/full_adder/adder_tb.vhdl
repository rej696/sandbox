library ieee;
  use ieee.std_logic_1164.all;

entity adder_tb
is
end adder_tb;

architecture behaviour of adder_tb 
is
    -- Declaration of the component that will be instatiated.
    component adder
        port (i0, i1: in std_logic; ci: in std_logic; s: out std_logic; co: out std_logic);
    end component;

    -- Specifies which entity is bound with the component.
    for adder_0: adder use entity work.adder;
    signal i0, i1, ci, s, co: std_logic;
begin
    -- Component instantiation.
    adder_0: adder port map (
        i0 => i0,
        i1 => i1,
        ci => ci,
        s => s,
        co => co
    );

    -- This process does the real job
    process
        type pattern_t is record
            i0, i1, ci: std_logic;
            s, co: std_logic;
        end record;
        -- The patterns to apply.
        type pattern_array_t is array (natural range <>) of pattern_t;
        constant patterns: pattern_array_t := (
            ('0', '0', '0', '0', '0'),
            ('0', '0', '1', '1', '0'),
            ('0', '1', '0', '1', '0'),
            ('0', '1', '1', '0', '1'),
            ('1', '0', '0', '1', '0'),
            ('1', '0', '1', '0', '1'),
            ('1', '1', '0', '0', '1'),
            ('1', '1', '1', '1', '1')
        );
    begin
        -- check each pattern
        for i in patterns'range loop
            i0 <= patterns(i).i0;
            i1 <= patterns(i).i1;
            ci <= patterns(i).ci;

            -- wait for the results
            wait for 1 ns;
            
            -- check the outputs
            assert s = patterns(i).s
                report "bad sum value" severity error;
            assert co = patterns(i).co
                report "bad carry out value" severity error;
        end loop;
        assert false report "end of test" severity note;

        -- wait forever; this will finish the simulation
        wait;
    end process;
end behaviour;
