--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:13:31 05/29/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project fasi 2/MultiCycle/a_angelidis_2019030190/Control_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY Control_tb IS
END Control_tb;
 
ARCHITECTURE behavior OF Control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         PC_sel : OUT  std_logic;
         Memory_operation : OUT  std_logic;
         PC_Ld_En : OUT  std_logic;
         RF_Wr_En : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         MEM_WrEn : OUT  std_logic;
         Mem_REn : OUT  std_logic;
         Get_instr_En : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal Memory_operation : std_logic;
   signal PC_Ld_En : std_logic;
   signal RF_Wr_En : std_logic;
   signal RF_B_sel : std_logic;
   signal RF_WrData_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal MEM_WrEn : std_logic;
   signal Mem_REn : std_logic;
   signal Get_instr_En : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          Reset => Reset,
          Clk => Clk,
          Instr => Instr,
          ALU_zero => ALU_zero,
          PC_sel => PC_sel,
          Memory_operation => Memory_operation,
          PC_Ld_En => PC_Ld_En,
          RF_Wr_En => RF_Wr_En,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          MEM_WrEn => MEM_WrEn,
          Mem_REn => Mem_REn,
          Get_instr_En => Get_instr_En
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
		wait for 100ns;
		
		Reset<= '0';		
		-- add r1, r3, r2 
		Instr <= "10000000001000110001000000110000";
		wait for 100ns; 
		
		-- sub r1, r3, r2
		Instr <= "10000000001000110001000000110001";
		wait for 100ns; 
		
		-- and r1, r3, r2
		Instr <= "10000000001000110001000000110010";
		wait for 100ns; 
		
		-- not r1, r3
		Instr <= "10000000001000110000000000110100";
		wait for 100ns; 
		
		-- or r1, r3, r2
		Instr <= "10000000001000110001000000110011";
		wait for 100ns; 
		
		-- srl r1, r3
		Instr <= "10000000001000110000000000111000";
		wait for 100ns;
		
		-- sll r1, r3
		Instr <= "10000000001000110000000000111001";
		wait for 100ns;

		-- sla r1, r3
		Instr <= "10000000001000110000000000111010";
		wait for 100ns;
		
		-- rol r1, r3
		Instr <= "10000000001000110000000000111100";
		wait for 100ns;
		
		-- ror r1, r3
		Instr <= "10000000001000110000000000111101";
		wait for 100ns;
		
		-- li r1, 6
		Instr <= "11100000000000010000000000000110";
		wait for 100ns;
		
		-- lui r1, 6
		Instr <= "11100100000000010000000000000110";
		wait for 100ns;
		
		-- addi r1, r2, 6
		Instr <= "11000000001000100000000000000110";
		wait for 100ns;
		
		-- andi r1, r2, 6
		Instr <= "11001000001000100000000000000110";
		wait for 100ns;
		
		-- ori r1, r2, 6
		Instr <= "11001100001000100000000000000110";
		wait for 100ns;
		
		-- b 6
		Instr <= "11111100000000000000000000000110";
		wait for 100ns;
		
		-- beq r1, r2, 6 / r1 != r2
		Instr <= "01000000001000100000000000000110";
		ALU_zero <= '0';
		wait for 100ns;
		
		-- beq r1, r2, 6 / r1 == r2 
		Instr <= "01000000001000100000000000000110";
		ALU_zero <= '1';
		wait for 100ns;
		
		-- bne r1, r2, 6 / r1 != r2 
		Instr <= "01000100001000100000000000000110";
		ALU_zero <= '0';
		wait for 100ns;
		
		-- bne r1, r2, 6 / r1 == r2 
		Instr <= "01000100001000100000000000000110";
		ALU_zero <= '1';
		wait for 100ns;
		
		-- lb r1, 4(r2)
		Instr<= "00001100001000100000000000000100";
		wait for 100ns;
		
		-- sb r1, 4(r2)
		Instr<= "00011100001000100000000000000100";
		wait for 100ns;
		
		-- lw r1, 4(r2)
		Instr<= "00111100001000100000000000000100";
		wait for 100ns;
		
		-- sw r1, 4(r2)
		Instr<= "01111100001000100000000000000100";
		wait for 100ns;

      wait;
   end process;

END;
