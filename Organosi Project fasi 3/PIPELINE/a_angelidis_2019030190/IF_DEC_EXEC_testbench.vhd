--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:46:29 04/15/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/IF_DEC_EXEC_testbench.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_DEC_EXEC_MODULE
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
 
ENTITY IF_DEC_EXEC_testbench IS
END IF_DEC_EXEC_testbench;
 
ARCHITECTURE behavior OF IF_DEC_EXEC_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_DEC_EXEC_MODULE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
		--	RF_A : out  STD_LOGIC_VECTOR (31 downto 0);					  

         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);
--	signal RF_A : STD_LOGIC_VECTOR (31 downto 0);					  


   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_DEC_EXEC_MODULE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
			 --RF_A => RF_A,					  
          Instr => Instr
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
      Reset <= '1';
		wait for Clk_period;
		
		Reset <= '0';
		
		-- li 
		PC_Immed<=x"0000_0006";
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		MEM_out <= x"1234_1234"; 										
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		wait for 2*Clk_period;

		MEM_out <= x"1234_1234"; 	


		-- addi 
		PC_Immed <= x"0000_0006";
		PC_sel <= '0'; 								-- pc = pc + 4							
		PC_LdEn <= '1';								-- 
		RF_WrEn <= '1';								-- write on registers
		RF_B_sel <= '0'; 								-- 15 - 11 
		RF_WrData_sel <= '0'; 						-- alu
		ALU_Bin_sel <= '1'; 							-- immed
		ALU_func <= "0000"; 							-- add 
		wait for Clk_period;
				
		wait;
   end process;

END;
