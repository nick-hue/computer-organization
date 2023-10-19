--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:19:29 03/12/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/ALU_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

   -- Stimulus process
   stim_proc: process
   begin		
		-- total sim time :  4500 ns
		-- Addition
		Op<="0000";
		
		-- 0 + 0
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;

		-- 0 + 15 
		A<=x"0000_0000";
		B<=x"0000_000F";
		wait for 100 ns;
		
		-- 15 + 0 
		A<=x"0000_000F";
		B<=x"0000_0000";
		wait for 100 ns;

		-- 115 + 1023 = 0000_0073 + 0000_03FF
		A<=x"0000_0073";
		B<=x"0000_03FF";
		wait for 100 ns;
		
		-- carry out case(1)
		A<=x"F000_0000";
		B<=x"F000_0001";
		wait for 100 ns;
		
		-- carry out case(2)
		A<=x"7000_0000";
		B<=x"9000_0001";
		wait for 100 ns;
		
		-- Subtraction 
		Op<="0001";
		
		-- 0 - 0
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		-- 115 - 115 = 0000_0073 - 0000_0073
		A<=x"0000_0073";
		B<=x"0000_0073";
		wait for 100 ns;
		
		-- 1023 - 115 = 0000_03FF - 0000_0073
		A<=x"0000_03FF";
		B<=x"0000_0073";
		wait for 100 ns;
		
		-- 1023 - 0 = 0000_03FF - 0000_0000
		A<=x"0000_03FF";
		B<=x"0000_0000";
		wait for 100 ns;

		-- 0 - 1023 = 0000_0000 -0000_03FF 
		A<=x"0000_0000";
		B<=x"0000_03FF";
		wait for 100 ns;
		
		-- and
		Op<="0010";
		
		A<=x"0000_0000"; 
		B<=x"0000_0000";
		wait for 100 ns;
		
		A<=x"AAAA_AAAA";
		B<=x"5555_5555";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		B<=x"FFFF_FFFF";
		wait for 100 ns;	
		
		A<=x"1FD55055";
		B<=x"7F2CC01D";
		wait for 100 ns;	
		
		-- or
		Op<="0011";
		
		A<=x"0000_0000";
		B<=x"0000_0000";
		wait for 100 ns;
		
		A<=x"AAAA_AAAA";
		B<=x"5555_5555";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		B<=x"FFFF_FFFF";
		wait for 100 ns;	
		
		A<=x"1FD55055";
		B<=x"7F2CC01D";
		wait for 100 ns;	
		
		-- not
		Op<="0100";
		
		A<=x"0000_0000";
		wait for 100 ns;
		
		A<=x"5555_5555";
		wait for 100 ns;
		
		A<=x"AAAA_AAAA";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		wait for 100 ns;	
		
		A<=x"1FD55055";
		wait for 100 ns;	
		
		-- shift right arithmetic
		Op<="1000";
		
		A<=x"7F00_F0E1";
		wait for 100 ns;
		
		A<=x"AAAA_AAAA";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		wait for 100 ns;
		
		A<=x"7FFF_000F";
		wait for 100 ns;	
		
		-- shift right logical
		Op<="1001";
		
		A<=x"0000_0000";
		wait for 100 ns;
		
		A<=x"5555_5555";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		wait for 100 ns;	
		
		A<=x"7F00_F0E1";
		wait for 100 ns;
		
		-- shift left logical
		Op<="1010";
		
		A<=x"0000_0000";
		wait for 100 ns;
		
		A<=x"5555_5555";
		wait for 100 ns;
		
		A<=x"FFFF_FFFF";
		wait for 100 ns;	

		A<=x"7F00_F0E1";
		wait for 100 ns;		

		-- rotate left
		Op<="1100";
		A<=x"8000_A005";
		wait for 100 ns;
		
		A<=x"F000_0000";
		wait for 100 ns;
		
		A<=x"0000_000F";
		wait for 100 ns;
		
		-- rotate right
		Op<="1101";
		A<=x"8000_0001";
		wait for 100 ns;
		
		A<=x"F000_0000";
		wait for 100 ns;
		
		A<=x"0000_000F";
		wait for 100 ns;
		
		Op<="1111";
		wait for 300 ns;
		
      wait;
   end process;

END;
