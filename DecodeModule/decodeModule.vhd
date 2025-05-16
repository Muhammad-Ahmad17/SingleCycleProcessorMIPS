-- IS O UPDATE KAR DO COPY KAR LIA HOA HA
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MyPackage.all;

entity decodeModule is
    port(
        hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 : out std_logic_vector(6 downto 0);
        leds  : out std_logic_vector(3 downto 0);
        topclock, topreset : in std_logic;
        RegWRT : in std_logic;
        sw : in std_logic_vector(4 downto 0)
    );
end decodeModule;

architecture bhv of decodeModule is
	signal top_instruction,top_pcout : std_LOGIC_VECTOR(31 downto 0);
	signal reg_rs, reg_rt, reg_rd, immediate, j_addr, hexout : std_logic_vector(31 downto 0);

begin
    -- Progaram Counter
	f1: fetch port map (
        PC_out             => top_pcout,
        instruction        => top_instruction,
        branch_addr        => X"00000000",
        jump_addr          => X"00000000",
        branch_decision    => '0', 	-- branch_des
        jump_decision      => '0',  -- jump_des
        reset              => topreset,
        clock              => topclock
    );	
	 leds <= top_pcout(3 downto 0);

    F2: decode port map (
        instruction     => top_instruction,
        clock           => topclock,
        reset           => topreset,
        register_rs     => reg_rs,
        register_rt     => reg_rt,
        register_rd     => reg_rd,
        jump_addr       => j_addr,
        immediate       => immediate,
        RegDst          => '1',
        RegWrite        => RegWRT,
        MemToReg        => '0',
        memory_data     => x"00000005",
        alu_result      => x"00000000"
    );

		hexout <= 	top_instruction when (sw ="00000")else
				reg_rs 			when (sw ="00001")else
				reg_rt			when (sw ="00010") else
				reg_rd			when (sw ="00100") else
				immediate		when (sw ="01000") else
				j_addr			when (sw ="10000") 
				;
				  
-- Instruction 
	u7: sevenSegement port map (
        bininput => hexout(31 downto 28),
        cathodes => hex7
    );
    u6: sevenSegement port map (
        bininput => hexout(27 downto 24),
        cathodes => hex6
    );
    u5: sevenSegement port map (
        bininput => hexout(23 downto 20),
        cathodes => hex5
    );
    u4: sevenSegement port map (
        bininput => hexout(19 downto 16),
        cathodes => hex4
    );
    u3: sevenSegement port map (
        bininput => hexout(15 downto 12),
        cathodes => hex3
    );
    u2: sevenSegement port map (
        bininput => hexout(11 downto 8),
        cathodes => hex2
    );
    u1: sevenSegement port map (
        bininput => hexout(7 downto 4),
        cathodes => hex1
    );
    u0: sevenSegement port map (
        bininput => hexout(3 downto 0),
        cathodes => hex0
    );

end bhv;
