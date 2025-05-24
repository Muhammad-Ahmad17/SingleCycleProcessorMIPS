library verilog;
use verilog.vl_types.all;
entity controlUnit_vlg_sample_tst is
    port(
        RegWRT          : in     vl_logic;
        sw              : in     vl_logic_vector(4 downto 0);
        topclock        : in     vl_logic;
        topreset        : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end controlUnit_vlg_sample_tst;
