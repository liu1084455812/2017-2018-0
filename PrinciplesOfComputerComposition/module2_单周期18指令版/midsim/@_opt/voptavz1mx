library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        beqout          : in     vl_logic;
        bgezout         : in     vl_logic;
        ALUctr          : out    vl_logic_vector(4 downto 0);
        DMWrite         : out    vl_logic;
        npc_sel         : out    vl_logic_vector(2 downto 0);
        RegWrt          : out    vl_logic;
        ExtOp           : out    vl_logic_vector(1 downto 0);
        mux4_5sel       : out    vl_logic_vector(1 downto 0);
        mux4_32sel      : out    vl_logic_vector(2 downto 0);
        mux2sel         : out    vl_logic
    );
end ctrl;
