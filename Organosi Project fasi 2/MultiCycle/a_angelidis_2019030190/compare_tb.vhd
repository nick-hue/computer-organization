--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:50:45 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Compare_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Compare
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
 
ENTITY Compare_tb IS
END Compare_tb;
 
ARCHITECTURE behavior OF Compare_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Compare
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Awd : IN  std_logic_vector(4 downto 0);
         equal_flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Awd : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal equal_flag : std_logic;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Compare PORT MAP (
          Awr => Awr,
          Awd => Awd,
          equal_flag => equal_flag
        );


   -- Stimulus process
   stim_proc: process
   begin
		Awr <= "00000";
		Awd <= "00000";
		wait for 100ns;
		
		Awr <= "11111";
		Awd <= "11111";
		wait for 100ns;
		
		Awr <= "10101";
		Awd <= "01010";
		wait for 100ns;
		
		Awr <= "10100";
		Awd <= "10100";
		wait for 100ns;

      wait;
   end process;

END;
