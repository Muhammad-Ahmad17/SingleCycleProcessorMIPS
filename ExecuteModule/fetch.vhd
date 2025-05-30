library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
use ieee.std_logic_unsigned.all; 
use work.MyPackage.all;


entity fetch is
    port (
        PC_out         												: out STD_LOGIC_VECTOR (31 downto 0);
        instruction    												: out STD_LOGIC_VECTOR (31 downto 0);
        branch_addr,jump_addr      								: in STD_LOGIC_VECTOR (31 downto 0);
        branch_decision,jump_decision,reset,clock        : in std_logic
    );
end fetch;

architecture bhv of fetch is
    -- Define instruction memory array type
    type mem_array is array(0 to 15) of std_logic_vector(31 downto 0);

begin
    -- Process for handling the fetch operation
    process(clock, reset)
        -- Define variables inside the process
        variable pc     : std_logic_vector(31 downto 0) ;
        variable index  : integer range 0 to 15 := 0;

        -- Initialize the instruction memory with machine code
			variable mem : mem_array := (
				X"8C220000", -- lw $2, 0($1)
				X"8C230005", -- lw $3, 5($1)
				X"00622020", -- add $4, $3, $2
				X"AC240000", -- sw $4, 0($1)
				X"8C220000", -- lw $2, 0($1)
				X"012A4020", -- add $8, $9, $10
				X"018D5822", -- sub $11, $12, $13
				X"01F07024", -- and $14, $15, $16
				X"02399025", -- or $17, $18, $19
				X"1043FFFC", -- beq $2, $3, -4 (branch back if $2 == $3)
				others => X"00000000" -- Initialize remaining locations
);


    begin

		-- fetch Process
		

        -- Check if reset signal is active
			if reset = '1' then
            pc := (others => '0');
            instruction <= (others => '0');
            PC_out <= (others => '0');
			elsif rising_edge(clock) then
            -- Handle branch/jump
            if branch_decision = '1' then
                pc := branch_addr;
            elsif jump_decision = '1' then
                pc := jump_addr;
				end if;
			end if;
				
            -- Calculate memory index from PC (using word alignment)
            index := to_integer(unsigned(pc(3 downto 0)));
            -- Increment PC by 1(4-bit) (after fetching)
            pc := pc + "1";
				
			
            -- Fetch instruction from memory
            instruction <= mem(index);
				-- Featch program counter wrt 
            PC_out <= pc;
				
    end process;

end bhv;