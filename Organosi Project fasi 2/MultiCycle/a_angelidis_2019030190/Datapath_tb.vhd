--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:07:48 04/15/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Datapath_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Datapath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Datapath_tb IS
END Datapath_tb;
 
ARCHITECTURE behavior OF Datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
			Instr : out STD_LOGIC_VECTOR(31 downto 0);
         Zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal Mem_WrEn : std_logic := '0';

 	--Outputs
	signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal Zero : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          Clk => Clk,
          Reset => Reset,
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
			 Instr => Instr,
          Zero => Zero
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		-- total sim time : ns 
      Reset <= '1';
		wait for Clk_period;
		
		Reset <= '0';
		
		PC_sel <='0'; 
		PC_LdEn<='1'; 
		RF_WrEn <='1';
		RF_WrData_sel <='0'; --Alu out --0
		RF_B_sel  <='0'; --rt
		ALU_Bin_sel <='1';  --Immed
		ALU_func <="0000"; --add			
		Mem_WrEn  <='0';
		
		-- alu function signals from control
		PC_sel <= '0';									-- pc = pc + 4
		PC_LdEn <= '1'; 								-- we want to increment the PC counter by 4 
		RF_WrEn <= '1'; 								-- write on registers
		RF_B_sel <= '0'; 								-- get 15->11
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '0'; 							-- RF B
		MEM_WrEn	<= '0'; 								-- we dont mess with memory
		
		-- add
		ALU_func <= "0000";
		wait for Clk_period;
		
		-- sub
		ALU_func <= "0001";
		wait for Clk_period;							
		
		-- and
		ALU_func <= "0010";
		wait for Clk_period;	
		
		-- or
		ALU_func <= "0011";
		wait for Clk_period;
		
		-- not
		ALU_func <= "0100";
		wait for Clk_period;
		
		-- sra
		ALU_func <= "1001";
		wait for Clk_period;
		
		-- srl
		ALU_func <= "1010";
		wait for Clk_period;
		
		-- sll 
		ALU_func <= "1000";
		wait for Clk_period;
		
		-- rol
		ALU_func <= "1100";
		wait for Clk_period;
		
		-- ror
		ALU_func <= "1101";
		wait for Clk_period;				
				
		-- li
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;
		
		-- lui
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;

		-- addi
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;
		
		-- andi
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0010"; 							-- and 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;
		
		-- ori
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0011"; 							-- or 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;				
		
		-- b
		PC_sel <= '1'; 								-- pc = pc + 4	+ immediate					
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '0';								-- dont write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "1111"; 							-- dont care 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;				
			
--		-- beq
--		if (ALU_zero = '1') then					-- if the subtraction of the two registers equals to zero it means they are equal so do the jump if not don't
--			PC_sel <= '1'; 							-- pc = pc + 4 + immed
--		else
--			PC_Sel <= '0'; 							-- pc = pc + 4
--		end if;
--		PC_LdEn <= '1'; 								-- 
--		RF_WrEn <= '0'; 								-- dont write on registers
--		RF_B_sel <= '1'; 								-- 20 - 16 
--		RF_WrData_sel <= '0'; 						-- alu ( dont care ) 
--		ALU_Bin_sel <= '0'; 							-- RF B
--		ALU_func <= "0001"; 							-- sub
--		MEM_WrEn	<= '0'; 								-- dont mess with memory
--		wait for Clk_period;				
--		
--		-- bne
--		if (ALU_zero = '0') then					-- if the subtraction of the two registers does not equal to zero it means they are not equal so do the jump if not don't
--			PC_sel <= '1'; 							-- pc = pc + 4 + immed
--		else
--			PC_Sel <= '0'; 							-- pc = pc + 4
--		end if;
--		PC_LdEn <= '1'; 								-- 
--		RF_WrEn <= '0'; 								-- dont write on registers
--		RF_B_sel <= '1'; 								-- 20 - 16 
--		RF_WrData_sel <= '0'; 						-- alu ( dont care ) 
--		ALU_Bin_sel <= '0'; 							-- RF B
--		ALU_func <= "0001"; 							-- sub
--		MEM_WrEn	<= '0'; 								-- dont mess with memory
--		wait for Clk_period;
--		
		-- lb
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '1'; 						-- mem
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;

		-- sb
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '0';								-- dont write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 ( dont care ) 
		RF_WrData_sel <= '1'; 						-- mem
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '1'; 								-- mess with memory
		wait for Clk_period;
											
		-- lw
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '1'; 						-- mem
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '0'; 								-- dont mess with memory
		wait for Clk_period;
								
		-- sw
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '0';								-- dont write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 ( dont care ) 
		RF_WrData_sel <= '1'; 						-- mem
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		MEM_WrEn	<= '1'; 								-- mess with memory
		wait for Clk_period;
	
		
      wait;
   end process;

END;
