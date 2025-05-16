library verilog;
use verilog.vl_types.all;
entity decodeModule_vlg_sample_tst is
    port(
        alu_result      : in     vl_logic_vector(31 downto 0);
        clock           : in     vl_logic;
        instruction     : in     vl_logic_vector(31 downto 0);
        memory_data     : in     vl_logic_vector(31 downto 0);
        MemToReg        : in     vl_logic;
        RegDst          : in     vl_logic;
        RegWrite        : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end decodeModule_vlg_sample_tst;
