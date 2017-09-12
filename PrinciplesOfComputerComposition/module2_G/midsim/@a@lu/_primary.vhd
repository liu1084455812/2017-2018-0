library verilog;
use verilog.vl_types.all;
entity ALu is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        Ctrl            : in     vl_logic_vector(4 downto 0);
        C               : out    vl_logic_vector(31 downto 0);
        Zero            : out    vl_logic;
        beqout          : out    vl_logic;
        bgezout         : out    vl_logic
    );
end ALu;
