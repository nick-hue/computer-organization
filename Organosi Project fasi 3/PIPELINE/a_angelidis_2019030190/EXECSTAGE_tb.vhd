--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:48:31 03/31/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/EXECSTAGE_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXECSTAGE
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
 
ENTITY EXECSTAGE_tb IS
END EXECSTAGE_tb;
 
ARCHITECTURE behavior OF EXECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXECSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
			Zero : out  STD_LOGIC;
			Cout : out  STD_LOGIC;
			Ovf : out  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
	signal Zero : std_logic;
	signal Cout : std_logic;
	signal Ovf : std_logic;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXECSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
			 Zero => Zero,
			 Cout => Cout,
			 Ovf => Ovf
        );

   -- Stimulus process
   stim_proc: process
   begin
	
		-- addition 
		RF_A <= x"0000_001f";
      RF_B <= x"0000_0ff7";
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '0';
      ALU_func <= "0000";
		wait for 100ns;
		
		-- addition with immediate to show it works for andi 
		RF_A <= x"0000_001f";
      RF_B <= x"0000_0ff7";
		Immed <= x"0000_0001"; 	
      ALU_Bin_sel <= '1';
      ALU_func <= "0000";
		wait for 100ns;
		
		-- subtraction 
		RF_A <= x"0000_0009";
      RF_B <= x"0000_0003";
		Immed <= x"0000_0000";		-- dont care
      ALU_Bin_sel <= '0';
      ALU_func <= "0001";
		wait for 100ns;
		
		-- and
		RF_A <= x"aaaa_a4e8";
      RF_B <= x"ff00_00ff";
		Immed <= x"0000_0000";		-- dont care
      ALU_Bin_sel <= '0';
      ALU_func <= "0010";
		wait for 100ns;
		
		-- andi
		RF_A <= x"aaaa_a4e8";
      RF_B <= x"ff00_00ff";
		Immed <= x"0000_ffff";		
      ALU_Bin_sel <= '1';
      ALU_func <= "0010";
		wait for 100ns;

		-- or
		RF_A <= x"aaaa_a4e8";
      RF_B <= x"ff00_00ff";
		Immed <= x"0000_0000";		-- dont care
      ALU_Bin_sel <= '0';
      ALU_func <= "0011";
		wait for 100ns;
		
		-- ori
		RF_A <= x"aaaa_a4e8";
      RF_B <= x"ff00_00ff";
		Immed <= x"fff0_aecd";	
      ALU_Bin_sel <= '1';
      ALU_func <= "0011";
		wait for 100ns;
		
		-- not
		RF_A <= x"aaaa_a4e8";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "0100";
		wait for 100ns;
		
		-- arithmetic shift right(signed)
		RF_A <= x"faaa_a4ef";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "1000";
		wait for 100ns;
		
		-- logic shift right (unsigned)
		RF_A <= x"faaa_a4ef";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "1001";
		wait for 100ns;
		
		-- logic shift left (unsigned)
		RF_A <= x"7aaa_a4ef";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "1010";
		wait for 100ns;
		
		-- rotate left
		RF_A <= x"faaa_a4e4";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "1100";
		wait for 100ns;

			
		-- rotate right
		RF_A <= x"7aaa_a4ef";
      RF_B <= x"ff00_00ff"; 		-- dont care
		Immed <= x"0000_0000"; 		-- dont care
      ALU_Bin_sel <= '1';
      ALU_func <= "1101";
		wait for 100ns;
		
      wait;
   end process;

END;
