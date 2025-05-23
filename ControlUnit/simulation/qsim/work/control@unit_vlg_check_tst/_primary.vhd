library verilog;
use verilog.vl_types.all;
entity controlUnit_vlg_check_tst is
    port(
        hex0            : in     vl_logic_vector(6 downto 0);
        hex1            : in     vl_logic_vector(6 downto 0);
        hex2            : in     vl_logic_vector(6 downto 0);
        hex3            : in     vl_logic_vector(6 downto 0);
        hex4            : in     vl_logic_vector(6 downto 0);
        hex5            : in     vl_logic_vector(6 downto 0);
        hex6            : in     vl_logic_vector(6 downto 0);
        hex7            : in     vl_logic_vector(6 downto 0);
        leds            : in     vl_logic_vector(9 downto 0);
        sampler_rx      : in     vl_logic
    );
end controlUnit_vlg_check_tst;
