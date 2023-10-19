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
			  Clk : in  STD_LOGIC;
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
           MEM_WrEn : out  STD_LOGIC;
			  Mem_REn : out STD_LOGIC;
 			  Get_instr_En : out STD_LOGIC
);
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
			if (op_code_sig = "100000" and func_sig = "110000") then -- add
					PC_sel_sig := '0';								-- pc = pc + 4
					PC_Ld_En_sig := '1'; 							-- we want to increment the PC counter by 4 
					RF_Wr_En_sig := '1'; 							-- write on registers
					RF_B_sel_sig := '0'; 							-- get 15->11
					RF_WrData_sel_sig := '0'; 						-- alu
					ALU_Bin_sel_sig := '0'; 						-- RF B
					ALU_func_sig := "0000";							-- add
					MEM_WrEn_sig	:= '0'; 							-- we dont mess with memory
					Memory_operation_sig := '0';
		
			elsif (op_code_sig = "111000") then 				-- li
				PC_sel_sig := '0'; 									-- pc = pc + 4							
				PC_Ld_En_sig := '1';									-- 
				RF_Wr_En_sig := '1';									-- write on registers
				RF_B_sel_sig := '0'; 								-- 15 - 11 
				RF_WrData_sel_sig := '0'; 							-- alu
				ALU_Bin_sel_sig := '1'; 							-- immed
				ALU_func_sig := "0000"; 							-- add 
				MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
				Memory_operation_sig := '0';
			
			elsif (op_code_sig = "001111") then 				-- lw
				PC_sel_sig := '0'; 									-- pc = pc + 4							
				PC_Ld_En_sig := '1';									-- 
				RF_Wr_En_sig := '1';									-- write on registers
				RF_B_sel_sig := '0'; 								-- 15 - 11 
				RF_WrData_sel_sig := '1'; 							-- mem
				ALU_Bin_sel_sig := '1'; 							-- immed
				ALU_func_sig := "0000"; 							-- add 
				MEM_WrEn_sig	:= '0'; 								-- dont mess with memory
				Memory_operation_sig := '0';
							
			elsif (op_code_sig = "011111") then 				-- sw
				PC_sel_sig := '0'; 									-- pc = pc + 4							
				PC_Ld_En_sig := '1';									-- 
				RF_Wr_En_sig := '0';									-- dont write on registers
				RF_B_sel_sig := '1'; 								-- 15 - 11 ( dont care ) 
				RF_WrData_sel_sig := '1'; 							-- mem
				ALU_Bin_sel_sig := '1'; 							-- immed
				ALU_func_sig := "0000"; 							-- add 
				MEM_WrEn_sig	:= '1'; 								-- mess with memory
				Memory_operation_sig := '0';
				
			else 															-- invalid op-code go to next instruction
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

