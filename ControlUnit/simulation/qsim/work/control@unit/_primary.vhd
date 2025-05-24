library verilog;
use verilog.vl_types.all;
entity controlUnit is
    port(
        hex0            : out    vl_logic_vector(6 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0);
        hex6            : out    vl_logic_vector(6 downto 0);
        hex7            : out    vl_logic_vector(6 downto 0);
        leds            : out    vl_logic_vector(9 downto 0);
        topclock        : in     vl_logic;
        topreset        : in     vl_logic;
        RegWRT          : in     vl_logic;
        sw              : in     vl_logic_vector(4 downto 0)
    );
end controlUnit;
