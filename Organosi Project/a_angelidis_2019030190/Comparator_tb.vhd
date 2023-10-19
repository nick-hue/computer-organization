--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:58:17 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Comparator_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comparator
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Comparator_tb IS
END Comparator_tb;
 
ARCHITECTURE behavior OF Comparator_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comparator
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Ard : IN  std_logic_vector(4 downto 0);
         equal : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal equal : std_logic; 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comparator PORT MAP (
          Awr => Awr,
          Ard => Ard,
          equal => equal
        );

   -- Stimulus process
   stim_proc: process
   begin		
      Awr <= "00000";
		Ard <= "00000";
		wait for 100ns;

		Awr <= "10100";
		Ard <= "10100";
		wait for 100ns;
		
		Awr <= "11111";
		Ard <= "00000";
		wait for 100ns;
		
		Awr <= "10101";
		Ard <= "01010";
		wait for 100ns;
	end process;

END;
