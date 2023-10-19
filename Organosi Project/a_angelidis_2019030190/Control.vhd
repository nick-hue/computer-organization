----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:59:45 04/04/2023 
-- Design Name: 
-- Module Name:    Control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Control is
    Port ( 
			  Reset : IN STD_LOGIC;
			  Instr : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : in STD_LOGIC;
			  
           PC_sel : out  STD_LOGIC;
			  Memory_operation : out STD_LOGIC;
           PC_Ld_En : out  STD_LOGIC;
           RF_Wr_En : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : out  STD_LOGIC);
end Control;

architecture Behavioral of Control is

signal op_code_sig, func_sig : STD_LOGIC_VECTOR(5 downto 0);
signal instr_sig : STD_LOGIC_VECTOR(31 downto 0);
begin

	process(Instr, ALU_zero, Reset, op_code_sig, func_sig)
   variable PC_sel_sig, PC_Ld_En_sig, RF_Wr_En_sig, RF_B_sel_sig, RF_WrData_sel_sig, ALU_Bin_sel_sig, MEM_WrEn_sig, Memory_operation_sig: STD_LOGIC;
	variable ALU_func_sig : STD_LOGIC_VECTOR(3 downto 0);
	begin
		op_code_sig <= Instr(31 downto 26);
		func_sig <= Instr(5 downto 0);
		instr_sig <= Instr;
		if (Reset = '1') then 
			PC_sel_sig := '0'; 
			PC_Ld_En_sig := '0';
			RF_Wr_En_sig := '0';
			RF_B_sel_sig := '0';
			RF_WrData_sel_sig := '0';
			ALU_Bin_sel_sig := '0'; 
			ALU_func_sig := "0000"; 
			MEM_WrEn_sig	:= '0';
			Memory_operation_sig := '0';
		else 
			if (instr_sig = x"0000_0000") then
				PC_sel_sig := '0'; 
				PC_Ld_En_sig := '1';
				RF_Wr_En_sig := '-';
				RF_B_sel_sig := '-';
				RF_WrData_sel_sig := '-';
				ALU_Bin_sel_sig := '-'; 
				ALU_func_sig := "XXXX"; -- invalid func option 
				MEM_WrEn_sig	:= 'X';
				Memory_operation_sig := 'X';

			else				
				-- go to ALU functions
				-- for all alu functions signals are the same except from alu_func
				if (op_code_sig = "100000") then
					PC_sel_sig := '0';									-- pc = pc + 4
					PC_Ld_En_sig := '1'; 								-- we want to increment the PC counter by 4 
					RF_Wr_En_sig := '1'; 								-- write on registers
					RF_B_sel_sig := '0'; 								-- get 15->11
					RF_WrData_sel_sig := '0'; 							-- alu
					ALU_Bin_sel_sig := '0'; 							-- RF B
					MEM_WrEn_sig	:= '0'; 								-- we dont mess with memory
					Memory_operation_sig := '0';
					
					if (func_sig = "110000") then 			-- add
						ALU_func_sig := "0000";
						
					elsif (func_sig = "110001") then		-- sub
						ALU_func_sig := "0001";
					
					elsif (func_sig = "110010") then 		-- and
						ALU_func_sig := "0010";
											
					elsif (func_sig = "110011") then 		-- or
						ALU_func_sig := "0011";
						
					elsif (func_sig = "110100") then 		-- not
						ALU_func_sig := "0100";
						
					elsif (func_sig = "111000") then 		-- srl
						ALU_func_sig := "1001";
											
					elsif (func_sig = "111001") then 		-- sll
						ALU_func_sig := "1010";
						
					elsif (func_sig = "111010") then 		-- sla
						ALU_func_sig := "1000";
						
					elsif (func_sig = "111100") then 		-- rol
						ALU_func_sig := "1100";
					
					elsif (func_sig = "111101") then 		-- ror
						ALU_func_sig := "1101";
										
					else												-- invalid input just go to the next instructon ( Pc + 4 ) 
						PC_sel_sig := '0';  
						PC_Ld_En_sig := '1';
						RF_Wr_En_sig := 'X';
						RF_B_sel_sig := 'X';
						RF_WrData_sel_sig := 'X';
						ALU_Bin_sel_sig := 'X';  
						ALU_func_sig := "XXXX"; 
						MEM_WrEn_sig	:= '0';
					end if;
				
				elsif (op_code_sig = "111000") then 		-- li
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
					
				elsif (op_code_sig = "111001") then 		-- lui
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
					
				elsif (op_code_sig = "110000") then 		-- addi
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
					
				elsif (op_code_sig = "110010") then 		-- andi
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0010"; 							-- and 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
					
				elsif (op_code_sig = "110011") then 		-- ori
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0011"; 							-- or 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
									
				elsif (op_code_sig = "111111") then 		-- b
					PC_sel_sig := '1'; 								-- pc = pc + 4	+ immediate					
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '0';								-- dont write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "1111"; 							-- dont care 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
									
				elsif (op_code_sig = "010000") then 		-- beq
					if (ALU_zero = '1') then					-- if the subtraction of the two registers equals to zero it means they are equal so do the jump if not don't
						PC_sel_sig := '1'; 							-- pc = pc + 4 + immed
					else
						PC_sel_sig := '0'; 							-- pc = pc + 4
					end if;
					PC_Ld_En_sig := '1'; 								-- 
					RF_Wr_En_sig := '0'; 								-- dont write on registers
					RF_B_sel_sig := '1'; 								-- 20 - 16 
					RF_WrData_sel_sig := '0'; 						-- alu ( dont care ) 
					ALU_Bin_sel_sig := '0'; 							-- RF B
					ALU_func_sig := "0001"; 							-- sub
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
									
				elsif (op_code_sig = "010001") then 		-- bne
					if (ALU_zero = '0') then					-- if the subtraction of the two registers does not equal to zero it means they are not equal so do the jump if not don't
						PC_sel_sig := '1'; 							-- pc = pc + 4 + immed
					else
						PC_sel_sig := '0'; 							-- pc = pc + 4
					end if;
					PC_Ld_En_sig := '1'; 								-- 
					RF_Wr_En_sig := '0'; 								-- dont write on registers
					RF_B_sel_sig := '1'; 								-- 20 - 16 
					RF_WrData_sel_sig := '0'; 						-- alu ( dont care ) 
					ALU_Bin_sel_sig := '0'; 							-- RF B
					ALU_func_sig := "0001"; 							-- sub
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
					
				elsif (op_code_sig = "000011") then 		-- lb
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '1'; 						-- mem
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '1';
					
				elsif (op_code_sig = "000111") then 			-- sb
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '0';								-- dont write on registers
					RF_B_sel_sig := '1'; 								-- 15 - 11 ( dont care ) 
					RF_WrData_sel_sig := '1'; 						-- mem
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '1'; 								-- mess with memory
					Memory_operation_sig := '1';
					
				elsif (op_code_sig = "001111") then 			-- lw
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '1';								-- write on registers
					RF_B_sel_sig := '0'; 								-- 15 - 11 
					RF_WrData_sel_sig := '1'; 						-- mem
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
					Memory_operation_sig := '0';
								
				elsif (op_code_sig = "011111") then 			-- sw
					PC_sel_sig := '0'; 								-- pc = pc + 4							
					PC_Ld_En_sig := '1';								-- 
					RF_Wr_En_sig := '0';								-- dont write on registers
					RF_B_sel_sig := '1'; 								-- 15 - 11 ( dont care ) 
					RF_WrData_sel_sig := '1'; 						-- mem
					ALU_Bin_sel_sig := '1'; 							-- immed
					ALU_func_sig := "0000"; 							-- add 
					MEM_WrEn_sig	:= '1'; 								-- mess with memory
					Memory_operation_sig := '0';
					
				else -- invalid op-code go to next instruction
					PC_sel_sig := '0';  
					PC_Ld_En_sig := '1';
					RF_Wr_En_sig := 'X';
					RF_B_sel_sig := 'X';
					RF_WrData_sel_sig := 'X';
					ALU_Bin_sel_sig := 'X';  
					ALU_func_sig := "----"; 
					MEM_WrEn_sig	:= '0';
					Memory_operation_sig := '0';
										
				end if;
			end if;
		end if;
		
		PC_sel <= PC_sel_sig;
		PC_Ld_En <= PC_Ld_En_sig;
		RF_Wr_En <= RF_Wr_En_sig;
		RF_B_sel <= RF_B_sel_sig;
		RF_WrData_sel <= RF_WrData_sel_sig;
		ALU_Bin_sel <= ALU_Bin_sel_sig;
		ALU_func <= ALU_func_sig;
		MEM_WrEn <= MEM_WrEn_sig;
		Memory_operation <= Memory_operation_sig;
	end process;
	
  
	
	
	
end Behavioral;

