library verilog;
use verilog.vl_types.all;
entity Mux_2 is
    port(
        addr            : in     vl_logic;
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        Mout            : out    vl_logic_vector(31 downto 0)
    );
end Mux_2;
