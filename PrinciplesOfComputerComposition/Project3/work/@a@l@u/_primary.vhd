library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        sa              : in     vl_logic_vector(4 downto 0);
        C               : out    vl_logic_vector(31 downto 0);
        ALUop           : in     vl_logic_vector(3 downto 0);
        zero            : out    vl_logic;
        big             : out    vl_logic;
        smal            : out    vl_logic
    );
end ALU;
