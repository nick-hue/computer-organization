--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:36:19 03/23/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Mux2_5_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux2_5
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
 
ENTITY Mux2_5_tb IS
END Mux2_5_tb;
 
ARCHITECTURE behavior OF Mux2_5_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux2_5
    PORT(
         din1 : IN  std_logic_vector(4 downto 0);
         din2 : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         dout : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal din1 : std_logic_vector(4 downto 0) := (others => '0');
   signal din2 : std_logic_vector(4 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(4 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux2_5 PORT MAP (
          din1 => din1,
          din2 => din2,
          sel => sel,
          dout => dout
        );

   -- Stimulus process
   stim_proc: process
   begin		
		din1 <= "11111";
		din2 <= "00000";
		sel <= '0';
		wait for 100 ns;

		din1 <= "11111";
		din2 <= "00000";
		sel <= '1';
		wait for 100 ns;
		 
		din1 <= "10101";
		din2 <= "11011";
		sel <= '0';
		wait for 100 ns;
		 
		din1 <= "10101";
		din2 <= "11011";
		sel <= '1';
		wait for 100 ns;
		
		wait;
      wait;
   end process;

END;
