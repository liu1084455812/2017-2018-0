library verilog;
use verilog.vl_types.all;
entity Extender is
    port(
        EXTop           : in     vl_logic_vector(1 downto 0);
        imm             : in     vl_logic_vector(15 downto 0);
        extended        : out    vl_logic_vector(31 downto 0)
    );
end Extender;
