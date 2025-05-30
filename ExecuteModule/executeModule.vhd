-- IS O UPDATE KAR DO COPY KAR LIA HOA HA
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.MyPackage.all;

entity executeModule is
    port(
        hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7 : out std_logic_vector(6 downto 0);
        leds  : out std_logic_vector(9 downto 0);
        topclock, topreset : in std_logic;
        RegWRT : in std_logic;
        sw : in std_logic_vector(4 downto 0)
    );
end executeModule;

architecture bhv of executeModule is
	signal top_instruction,top_pcout                          : std_logic_vector(31 downto 0);
	signal reg_rs, reg_rt, reg_rd, immediate,
				j_addr, hexout   											 : std_logic_vector(31 downto 0);
	signal jump, RegDst, RegWrite, MemToReg,
				ALUSrc, beq_control, MemRead, MemWrite 		    : std_logic;
	signal ALUOp 															 : std_logic_vector(1 downto 0);
	signal read_data                                          : std_logic_vector(31 downto 0);
	signal address                                            : std_logic_vector(31 downto 0);	
	signal opcode                                             : std_logic_vector(5 downto 0);
	 
	 --SIGNALS FOR HANDLING THE EXECUTE MODULE
	signal alu_result, branch_addr 									 : std_logic_vector(31 downto 0);
	signal branch_decision 												 : std_logic;
	 
begin
	F1: fetch port map (
        --PC_out             => top_pcout,
        instruction        => top_instruction,
        branch_addr        => X"00000000",
        jump_addr          => X"00000000",
        branch_decision    => '0', 	-- branch_des
        jump_decision      => '0',  -- jump_des
        reset              => topreset,
        clock              => topclock
    );	

    D2: decode port map (
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
	 M3: memory
		port map(
		address => reg_rs,
		 write_data => reg_rt,
		 MemWrite => MemWrite,
		 MemRead => MemRead,
		 read_data => read_data
		);
	 opcode <= top_instruction(31 downto 26);
	 
	 
	 C4: control
		port map (
			--pc => top_pcout,
			instruction => top_instruction,
			reset => topreset,
			jump => jump,
			RegDst => RegDst,
			RegWrite => RegWrite,
			MemToReg => MemToReg,
			ALUOp => ALUOp,
			ALUSrc => ALUSrc,
			beq_control => beq_control,
			MemRead => MemRead,
			MemWrite => MemWrite
		);
		
		
	E5: execute
    port map (
        register_rs      => reg_rs,
        register_rt      => reg_rt,
        PC4              => top_pcout,
        immediate        => immediate,
        ALUOp            => ALUOp,
        ALUSrc           => ALUSrc,
        beq_control      => beq_control,
        clock            => topclock,
        alu_result       => alu_result,
        branch_addr      => branch_addr,
        branch_decision  => branch_decision
    );


		    -- Show instruction by default; only show others when switches are changed
		hexout <= top_instruction when sw = "00000" else  -- default view

              top_pcout     when sw = "00001" else  -- PC_out
              reg_rs        when sw = "00010" else  -- register_rs
              reg_rt        when sw = "00011" else  -- register_rt
              immediate     when sw = "00100" else  -- Immediate
              alu_result    when sw = "00101" else  -- alu_result
              branch_addr   when sw = "00111" else  -- branch_address
              j_addr        when sw = "10000";  -- jump address


				  
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
	 
	 with opcode select leds <=
    "1001000010" when "000000", -- R-type
    "0111100000" when "100011",  -- lw
    "0100010000" when "101011",  -- sw
    "0000001001" when "000100",  -- beq
	 "0000000100" when "000010",  -- j
    "0000000000" when others;

end bhv;
