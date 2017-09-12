library verilog;
use verilog.vl_types.all;
entity Mux_4_32 is
    port(
        muxSel          : in     vl_logic_vector(1 downto 0);
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        in3             : in     vl_logic_vector(31 downto 0);
        in4             : in     vl_logic_vector(31 downto 0);
        Mout            : out    vl_logic_vector(31 downto 0)
    );
end Mux_4_32;
