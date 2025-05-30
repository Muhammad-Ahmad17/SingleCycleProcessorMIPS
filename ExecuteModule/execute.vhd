LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all; 
USE work.MyPackage.all;

ENTITY execute IS
    PORT( 
        register_rs, register_rt: IN std_logic_vector(31 downto 0);
        PC4, immediate: IN std_logic_vector(31 downto 0);
        ALUOp: IN std_logic_vector(1 downto 0);
        ALUSrc: IN std_logic;
        beq_control, clock: IN std_logic;
        alu_result, branch_addr: OUT std_logic_vector(31 downto 0);
        branch_decision: OUT std_logic
    );
END execute;

ARCHITECTURE Behavioral OF execute IS
BEGIN
    process(clock)
        variable alu_output: std_logic_vector(31 downto 0);
        variable zero: std_logic;
        variable branch_offset, temp_branch_addr: std_logic_vector(31 downto 0);
    begin
        --if rising_edge(clock) then
            case ALUOp is
                when "00" =>
                    alu_output := register_rs + immediate; -- CALCULATING THE ADDRESS FOR LW/SW
                    zero := '0';
                when "01" =>
                    alu_output := register_rs - register_rt;
                    if (alu_output = X"00000000") then 
                        zero := '1';
                    else
                        zero := '0';
                    end if;
                when "10" =>
                    case immediate(5 downto 0) is
                        when "100000" => -- add
                            alu_output := register_rs + register_rt;
                            zero := '0';
                        when "100010" => -- subtract
                            alu_output := register_rs - register_rt;
                            zero := '0';
                        when "100100" => -- AND 
                            alu_output := register_rs and register_rt;
                            zero := '0';
                        when "100101" => -- OR
                            alu_output := register_rs or register_rt;
                            zero := '0';
                        when others =>
                            alu_output := (others => '0');
                            zero := '0';
                    end case;
                when others =>
                    alu_output := (others => '0');
                    zero := '0';
            end case;

            branch_offset := immediate;
            temp_branch_addr := PC4 + branch_offset;
            branch_decision <= (beq_control and zero);
            branch_addr <= temp_branch_addr;
            alu_result <= alu_output;
        --end if;
    end process;
END Behavioral;
