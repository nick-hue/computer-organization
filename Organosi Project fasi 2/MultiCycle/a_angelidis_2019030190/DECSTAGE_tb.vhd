--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:12:59 03/31/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/DECSTAGE_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
USE ieee.numeric_std.ALL;
 
ENTITY DECSTAGE_tb IS
END DECSTAGE_tb;
 
ARCHITECTURE behavior OF DECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Reset => Reset,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		RF_WrEn <= '1'; 													-- na mporoume na grapsoume 

		-- entoli: kane add ton kataxoriti rs(6) kai rt(8) kai balton ston kataxoriti rd(4)
		-- RF[rd] <- RF[rs] + RF[rt]
		-- 			  add | rs | rd | rt | nu | add
		
		-- choice should be : XX
		-- immed should be : don't care
		-- grafoume ston rf b apo tin alu 
		Instr	<=   "10000000110001000100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_ffff"; 										-- timi tis alu 
		MEM_out <= x"1234_1234"; 										-- timi tis mnimis
	   RF_WrData_sel <= '0'; 											-- grafoume apo alu
		RF_B_sel <= '1';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;
		

		-- choice should be : 00 (zero filling)
		-- immed should be : 00000000000000000100000000110000 
		-- grafoume ston rf b apo tin memory (ram) 
		Instr	<=   "11001000110001000100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_ffff"; 										-- timi tis alu 
		MEM_out <= x"1234_1234"; 										-- timi tis mnimis
	   RF_WrData_sel <= '1'; 											-- grafoume apo alu
		RF_B_sel <= '1';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;

		-- choice should be : 01 (sign extend)
		-- immed should be : 11111111111111111100000000110000
		-- grafoume ston rf A apo tin alu 
		Instr	<=   "11100000110001101100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_ffff"; 										-- timi tis alu 
		MEM_out <= x"1234_1234"; 										-- timi tis mnimis
	   RF_WrData_sel <= '0'; 											-- grafoume apo alu
		RF_B_sel <= '0';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;
				
		-- choice should be : 10 (zero fill and shift left 16 bits)
		-- immed should be : 01000000001100000000000000000000	
		-- grafoume ston rf a apo tin memory (ram) 		
		Instr	<=   "11100100110001100100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_ffff"; 										-- timi tis alu 
		MEM_out <= x"1234_1234"; 										-- timi tis mnimis
	   RF_WrData_sel <= '1'; 											-- grafoume apo alu
		RF_B_sel <= '0';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;
		
		-- choice should be : 11 (sign extend and shift left 2 bits)
		-- immed should be : 11111111111111110000000011000000
		-- grafoume kai stous dio rf apo tin alu 		
		Instr	<=   "01000000110001101100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_ffff"; 										-- timi tis alu 
		MEM_out <= x"1234_1234"; 										-- timi tis mnimis
	   RF_WrData_sel <= '0'; 											-- grafoume apo alu
		RF_B_sel <= '1';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;
		
		RF_WrEn <= '0'; 													-- na mporoume na grapsoume 
		
		-- den allazoume tis times tou rfa kai rfb 
		Instr	<=   "01000000110001101100000000110000";  		-- entoli poy dothike
		ALU_out <= x"0000_5555"; 										-- timi tis alu 
		MEM_out <= x"aaaa_0000"; 										-- timi tis mnimis
	   RF_WrData_sel <= '0'; 											-- grafoume apo alu
		RF_B_sel <= '1';													-- gia ti typou entoli milame an '0' 
		wait for Clk_period;


		
      wait;
   end process;

END;
