library verilog;
use verilog.vl_types.all;
entity Dout_extender is
    port(
        Dout            : in     vl_logic_vector(31 downto 0);
        extop           : in     vl_logic_vector(3 downto 0);
        extout          : out    vl_logic_vector(31 downto 0)
    );
end Dout_extender;
