library ieee;
use ieee.std_logic_1164.all;

package MyPackage is

    component sevenSegement is
        port (
            bininput : in  std_logic_vector(3 downto 0);
            cathodes : out std_logic_vector(6 downto 0)
        );
    end component;

    component fetch is
        port (
            PC_out             								: out STD_LOGIC_VECTOR (31 downto 0);
            instruction        								: out STD_LOGIC_VECTOR (31 downto 0);
            branch_addr,jump_addr          					: in STD_LOGIC_VECTOR (31 downto 0);
            branch_decision,jump_decision,reset,clock       : in std_logic
        );
    end component;

	component decode is
	port (
				 instruction : in std_logic_vector(31 downto 0);
				 clock       : in std_logic;
				 reset       : in std_logic;
				 RegDst      : in std_logic;
				 RegWrite    : in std_logic;
				 MemToReg    : in std_logic;
				 memory_data : in std_logic_vector(31 downto 0);
				 alu_result  : in std_logic_vector(31 downto 0);
				 
				 register_rs : out std_logic_vector(31 downto 0);
				 register_rt : out std_logic_vector(31 downto 0);
				 register_rd : out std_logic_vector(31 downto 0);
				 immediate   : out std_logic_vector(31 downto 0);
				 jump_addr   : out std_logic_vector(31 downto 0)
	);
	end component;
	
	component control
	port(
	pc: out std_logic_vector(31 downto 0);
	instruction : in std_logic_vector(31 downto 0);
	reset : in std_logic;
	jump: out std_logic;
	RegDst: out std_logic;
	RegWrite : out std_logic;
	MemToReg: out std_logic;
	ALUOp: out std_logic_vector(1 downto 0);
	ALUSrc: out std_logic;
	beq_control: out std_logic;
	MemRead: out std_logic;
	MemWrite: out std_logic
);
end component;

component memory 
	port (
    address    : in std_logic_vector(31 downto 0);
    write_data : in std_logic_vector(31 downto 0);
    MemWrite   : in std_logic;
    MemRead    : in std_logic;
    read_data  : out std_logic_vector(31 downto 0)
);
end component;

component execute
    PORT( 
			register_rs, register_rt: in std_logic_vector(31 downto 0);
          PC4, immediate: in std_logic_vector(31 downto 0);
          ALUOp: in std_logic_vector(1 downto 0);
          ALUSrc: in std_logic;
          beq_control, clock: in std_logic;
          alu_result, branch_addr: out std_logic_vector(31 downto 0);
          branch_decision: out std_logic
			 );
end component;

end package MyPackage;