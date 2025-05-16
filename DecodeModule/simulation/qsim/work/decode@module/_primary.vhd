library verilog;
use verilog.vl_types.all;
entity decodeModule is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        alu_result      : in     vl_logic_vector(31 downto 0);
        memory_data     : in     vl_logic_vector(31 downto 0);
        register_rs     : out    vl_logic_vector(31 downto 0);
        register_rt     : out    vl_logic_vector(31 downto 0);
        register_rd     : out    vl_logic_vector(31 downto 0);
        immediate       : out    vl_logic_vector(31 downto 0);
        jump_addr       : out    vl_logic_vector(31 downto 0);
        RegDst          : in     vl_logic;
        RegWrite        : in     vl_logic;
        MemToReg        : in     vl_logic;
        reset           : in     vl_logic;
        clock           : in     vl_logic
    );
end decodeModule;
