library verilog;
use verilog.vl_types.all;
entity nPC is
    port(
        imm_16          : in     vl_logic_vector(15 downto 0);
        imm_26          : in     vl_logic_vector(25 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        nPCop           : in     vl_logic_vector(1 downto 0);
        nPC             : out    vl_logic_vector(31 downto 0);
        PC_add_4        : out    vl_logic_vector(31 downto 0)
    );
end nPC;
