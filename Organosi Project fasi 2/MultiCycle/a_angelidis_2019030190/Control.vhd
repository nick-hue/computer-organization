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

type state is (RESET_state, IF_state, DEC_state, EXEC_state, EXEC_immed_state, R_TYPE_end_state, MEM_state, MEM_LOAD_state, MEM_STORE_state, MEM_end_state, BRANCH_CHECK_state, BRANCH_EXEC_state);
signal current_state, next_state : state;

signal op_code_sig, func_sig : STD_LOGIC_VECTOR(5 downto 0);
signal instr_sig : STD_LOGIC_VECTOR(31 downto 0);

begin
	-- ebala sto sensitivity list ta states mporei na min thelei to next
	process(Instr, ALU_zero, Reset, op_code_sig, func_sig, current_state, next_state)
   variable PC_sel_sig, PC_Ld_En_sig, RF_Wr_En_sig, RF_B_sel_sig, RF_WrData_sel_sig, ALU_Bin_sel_sig, MEM_WrEn_sig, Memory_operation_sig, Get_instr_En_sig, Mem_REn_sig: STD_LOGIC;
	variable ALU_func_sig : STD_LOGIC_VECTOR(3 downto 0);
	begin
		op_code_sig <= Instr(31 downto 26);
		func_sig <= Instr(5 downto 0);
		instr_sig <= Instr;
	
		case current_state is 
			when RESET_state => 
				PC_sel_sig := '0'; 
				PC_Ld_En_sig := '0';
				RF_Wr_En_sig := '0';
				RF_B_sel_sig := '0';
				RF_WrData_sel_sig := '0';
				ALU_Bin_sel_sig := '0'; 
				ALU_func_sig := "0000"; 
				MEM_WrEn_sig	:= '0';
				Memory_operation_sig := '0';
				Get_instr_En_sig := '0';	
				mem_ren_sig := '0';
				
				next_state		<= IF_state;
			
			when IF_state => 
				PC_sel_sig := '0'; 
				PC_Ld_En_sig := '1';
				RF_Wr_En_sig := '0';
				RF_B_sel_sig := '0';
				RF_WrData_sel_sig := '0';
				ALU_Bin_sel_sig := '0'; 
				ALU_func_sig := "0000"; 
				MEM_WrEn_sig	:= '0';
				Memory_operation_sig := '0';
				Get_instr_En_sig := '1';	
				mem_ren_sig := '0';
				
				next_state		<= DEC_state;
					
			
			when DEC_state => 
				PC_sel_sig := '0'; 
				PC_Ld_En_sig := '0';
				Get_instr_En_sig := '0';	
				
				if (instr_sig = x"0000_0000") then						-- no op
					next_state <= RESET_state;
				elsif(op_code_sig = "100000") then 						-- ALU
					next_state	<= EXEC_state;
				elsif(op_code_sig = "111000") then 						-- li
					next_state	<= EXEC_immed_state;
				elsif(op_code_sig = "111001") then 						-- lui
					next_state	<= EXEC_immed_state;
				elsif(op_code_sig = "110000") then 						-- addi
					next_state	<= EXEC_immed_state;
				elsif(op_code_sig = "110010") then 						-- andi
					next_state	<= EXEC_immed_state;
				elsif(op_code_sig = "110011") then 						-- ori
					next_state	<= EXEC_immed_state;
				elsif(op_code_sig = "111111") then 						-- b
					next_state	<= BRANCH_CHECK_state;
				elsif(op_code_sig = "010000") then 						-- beq
					next_state	<= BRANCH_CHECK_state;
				elsif(op_code_sig = "010001") then 						-- bne
					next_state	<= BRANCH_CHECK_state;
				elsif(op_code_sig = "000011") then 						-- lb
					next_state	<= MEM_state;
				elsif(op_code_sig = "000111") then 						-- sb
					next_state	<= MEM_state;
				elsif(op_code_sig = "001111") then 						-- lw
					next_state	<= MEM_state;
				elsif(op_code_sig = "011111") then 						-- sw
					next_state	<= MEM_state;
				end if;

			when EXEC_state => -- Execution for ALU instructions without Immediate
				if (func_sig = "110000") then 			-- add
					ALU_func_sig := "0000";
				elsif (func_sig = "110001") then			-- sub
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
				end if;

				ALU_Bin_sel_sig := '0'; 
				next_state		<= R_TYPE_end_state;	

			when EXEC_immed_state => -- Execution for ALU instructions Immediate
				if (op_code_sig = "111000") then 			-- li
					ALU_func_sig := "0000";
				elsif (op_code_sig = "111001") then			-- lui
					ALU_func_sig := "0000";
				elsif (op_code_sig = "110000") then 		-- addi
					ALU_func_sig := "0000";
				elsif (op_code_sig = "110010") then			-- andi
					ALU_func_sig := "0010";
				elsif (op_code_sig = "110011") then			-- ori
					ALU_func_sig := "0011";
				else -- ERROR
					ALU_func_sig := "XXXX";
				end if;
				
				
				ALU_Bin_sel_sig := '1'; 
				next_state		<= R_TYPE_end_state;		

			when R_TYPE_end_state =>
				PC_sel_sig := '0';
				PC_Ld_En_sig := '0';
				RF_Wr_En_sig := '1';
				RF_B_sel_sig := '0';
				RF_WrData_sel_sig := '0';
				ALU_Bin_sel_sig := '0'; 
				ALU_func_sig := "0000"; 
				MEM_WrEn_sig	:= '0';
				Memory_operation_sig := '0';
				mem_ren_sig := '0';
				
				next_state		<= IF_state;
			
			when MEM_state =>
				ALU_Bin_sel_sig := '1'; 
				ALU_func_sig := "0000"; 							
				RF_WrData_sel_sig := '1'; 						

				if (op_code_sig = "000011") then 								-- lb
					Memory_operation_sig := '1';
					next_state <= MEM_LOAD_state;
				elsif (op_code_sig = "000111") then								-- sb
					Memory_operation_sig := '1';
					next_state <= MEM_STORE_state;
				elsif (op_code_sig = "001111") then 							-- lw
					report "LOAD WORDDDDD";
					Memory_operation_sig := '0';
					next_state <= MEM_LOAD_state;
				elsif (op_code_sig = "011111") then								-- sw
					report "STORE WWOOOOOOOOODRD";
					Memory_operation_sig := '0';
					next_state <= MEM_STORE_state;
				else -- 	ERROR
					Memory_operation_sig := 'X';
					next_state <= RESET_state;
				end if;
				
			when MEM_LOAD_state	 =>								
				mem_ren_sig := '1';
				MEM_WrEn_sig := '0'; 	

				next_state <= MEM_end_state;
			
			when MEM_STORE_state =>	
				MEM_WrEn_sig := '1'; 	
				RF_B_sel_sig := '1';
				PC_Ld_En_sig := '0';

				next_state		<= MEM_end_state;
								
			when MEM_end_state => 
				PC_Ld_En_sig := '0';
				RF_Wr_En_sig := '1';
				--RF_B_sel_sig := '0';
				RF_WrData_sel_sig := '1';
				ALU_Bin_sel_sig := '0'; 
				ALU_func_sig := "0000"; 
				--Memory_operation_sig := '0';
				Get_instr_En_sig := '0';	
				mem_ren_sig := '0';
				
				next_state <= IF_STATE;
	

			when BRANCH_CHECK_state => 							-- checks to which branch we should go
				if(op_code_sig = "111111") 	then	-- b
					PC_sel_sig := '1';									
					PC_Ld_En_sig := '1'; 								
					RF_Wr_En_sig := '1'; 								
					RF_B_sel_sig := '0'; 								
					RF_WrData_sel_sig := '0'; 							
					ALU_Bin_sel_sig := '1'; 							
					MEM_WrEn_sig	:= '0'; 								
					Memory_operation_sig := '0';
								
					next_state		<= IF_state; 
					
				elsif(op_code_sig = "010000") then	-- beq
					PC_Ld_En_sig := '0'; 								
					RF_B_sel_sig := '1'; 								
					RF_WrData_sel_sig := '0'; 							
					ALU_Bin_sel_sig := '0'; 							
					MEM_WrEn_sig	:= '0'; 								
					Memory_operation_sig := '0';
				
					ALU_func_sig := "0001"; 
					
					next_state		<= BRANCH_EXEC_state;
					
				elsif(op_code_sig = "010001") then	-- bne
					PC_Ld_En_sig := '0'; 								
					RF_B_sel_sig := '1'; 								
					RF_WrData_sel_sig := '0'; 							
					ALU_Bin_sel_sig := '0'; 							
					MEM_WrEn_sig	:= '0'; 								
					Memory_operation_sig := '0';
			
					ALU_func_sig := "0001"; 
					
					next_state		<= BRANCH_EXEC_state;
					
				end if;	
				
			when BRANCH_EXEC_state => 
				ALU_func_sig := "0001";		
				
				if(op_code_sig = "010000") then	-- beq
					if (ALU_zero = '1')	then	
						PC_sel_sig := '1';  -- +immed
						PC_Ld_En_sig := '1';
					else
						PC_sel_sig := '0';  -- +4 
						PC_Ld_En_sig := '1';
					end if;
					next_state		<= IF_STATE;
					
				elsif(op_code_sig = "010001") then	-- bne
					if (ALU_zero = '1')	then	
						PC_sel_sig := '0';  -- +4
						PC_Ld_En_sig := '1';
					else
						PC_sel_sig := '1';  -- +immed
						PC_Ld_En_sig := '1';
					end if;		
					next_state	<= IF_STATE;
					
				end if;	
				
		end case;
		
		PC_sel <= PC_sel_sig;
		PC_Ld_En <= PC_Ld_En_sig;
		RF_Wr_En <= RF_Wr_En_sig;
		RF_B_sel <= RF_B_sel_sig;
		RF_WrData_sel <= RF_WrData_sel_sig;
		ALU_Bin_sel <= ALU_Bin_sel_sig;
		ALU_func <= ALU_func_sig;
		MEM_WrEn <= MEM_WrEn_sig;
		Memory_operation <= Memory_operation_sig;
		Get_instr_En <= Get_instr_En_sig;
		Mem_REn <= Mem_REn_sig;
		
	end process;
	
	get_next_state: process(Clk, Reset, current_state, next_state)
	begin		
	
	if (Reset = '1') then
		current_state <= RESET_state;
	elsif (Clk'EVENT and Clk = '1') then
		current_state <= next_state;
	end if;
	
	end process;

  
	
	
	
end Behavioral;

