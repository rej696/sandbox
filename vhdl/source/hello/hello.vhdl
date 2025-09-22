use std.textio.all;

entity Hello_World
is
end Hello_World;

architecture Behaviour of Hello_World
is
begin
    process
        variable l: line;
    begin
        write (l, String'("Hello world!"));
        writeline (output, l);
        wait;
    end process;
end Behaviour;
