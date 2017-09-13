library verilog;
use verilog.vl_types.all;
entity ctrl is
    generic(
        S0              : integer := 0;
        S1              : integer := 1;
        S2              : integer := 2;
        S3              : integer := 3;
        S4              : integer := 4;
        S5              : integer := 5;
        S6              : integer := 6;
        S7              : integer := 7
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zero            : in     vl_logic;
        big             : in     vl_logic;
        smal            : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        rt              : in     vl_logic_vector(4 downto 0);
        ALUout          : in     vl_logic_vector(1 downto 0);
        PCwrite         : out    vl_logic;
        IRwrite         : out    vl_logic;
        WDsel           : out    vl_logic_vector(1 downto 0);
        RegDst          : out    vl_logic_vector(1 downto 0);
        EXTop           : out    vl_logic_vector(1 downto 0);
        GPRwrite        : out    vl_logic;
        ALUsrc          : out    vl_logic_vector(1 downto 0);
        ALUop           : out    vl_logic_vector(3 downto 0);
        nPCop           : out    vl_logic_vector(1 downto 0);
        DMwrite         : out    vl_logic;
        din             : out    vl_logic_vector(3 downto 0);
        dout            : out    vl_logic_vector(3 downto 0)
    );
end ctrl;
