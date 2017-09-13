library verilog;
use verilog.vl_types.all;
entity enable_single_register is
    port(
        clk             : in     vl_logic;
        din             : in     vl_logic_vector(31 downto 0);
        dout            : out    vl_logic_vector(31 downto 0);
        enable          : in     vl_logic
    );
end enable_single_register;
