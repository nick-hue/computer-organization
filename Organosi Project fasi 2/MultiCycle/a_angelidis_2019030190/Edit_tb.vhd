--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:29:08 03/31/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Edit_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Edit
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
 
ENTITY Edit_tb IS
END Edit_tb;
 
ARCHITECTURE behavior OF Edit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Edit
    PORT(
         Instr : IN  std_logic_vector(15 downto 0);
         Choice : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(15 downto 0) := (others => '0');
   signal Choice : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
			
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Edit PORT MAP (
          Instr => Instr,
          Choice => Choice,
          Output => Output
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		Instr <= "0000000000011111";
		
		Choice <= "00";
		wait for 100ns;
		Choice <= "01";
		wait for 100ns;
		Choice <= "10";
		wait for 100ns;
		Choice <= "11";
		wait for 100ns;


		Instr <= "1111100000011111";
		
		Choice <= "00";
		wait for 100ns;
		Choice <= "01";
		wait for 100ns;
		Choice <= "10";
		wait for 100ns;
		Choice <= "11";
		wait for 100ns;		
		
		Instr <= "1111111111111111";
	
		Choice <= "00";
		wait for 100ns;
		Choice <= "01";
		wait for 100ns;
		Choice <= "10";
		wait for 100ns;
		Choice <= "11";
		wait for 100ns;		
		
		

      wait;
   end process;

END;
