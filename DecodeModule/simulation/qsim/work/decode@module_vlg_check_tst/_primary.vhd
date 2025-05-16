library verilog;
use verilog.vl_types.all;
entity decodeModule_vlg_check_tst is
    port(
        immediate       : in     vl_logic_vector(31 downto 0);
        jump_addr       : in     vl_logic_vector(31 downto 0);
        register_rd     : in     vl_logic_vector(31 downto 0);
        register_rs     : in     vl_logic_vector(31 downto 0);
        register_rt     : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end decodeModule_vlg_check_tst;
