--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:40:03 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Mux2to1_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux2to1
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
 
ENTITY Mux2to1_tb IS
END Mux2to1_tb;
 
ARCHITECTURE behavior OF Mux2to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux2to1
    PORT(
         din1 : IN  std_logic_vector(31 downto 0);
         din2 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal din1 : std_logic_vector(31 downto 0) := (others => '0');
   signal din2 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux2to1 PORT MAP (
          din1 => din1,
          din2 => din2,
          sel => sel,
          dout => dout
        ); 

   -- Stimulus process
   stim_proc: process
   begin
		 din1 <= x"0000_0001";
		 din2 <= x"FFFF_0001";
		 sel <= '0';
		 wait for 100 ns;

		 din1 <= x"0000_0001";
		 din2 <= x"FFFF_0001";
		 sel <= '1';
		 wait for 100 ns;
		 
		 din1 <= x"AEDF_0021";
		 din2 <= x"1111_1111";
		 sel <= '0';
		 wait for 100 ns;
		 
		 din1 <= x"AEDF_0021";
		 din2 <= x"1111_1111";
		 sel <= '1';
		 wait for 100 ns;
		 
		 din1 <= x"1010_FFAA";
		 din2 <= x"5555_AAAA";
		 sel <= '0';
		 wait for 100 ns;
		 
		 din1 <= x"1010_FFAA";
		 din2 <= x"5555_AAAA";
		 sel <= '1';
		 wait for 100 ns;
		
		wait;
		end process;
	end;
