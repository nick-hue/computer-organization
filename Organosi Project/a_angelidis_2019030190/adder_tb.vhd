--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:42:56 04/14/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/adder_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder
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
 
ENTITY adder_tb IS
END adder_tb;
 
ARCHITECTURE behavior OF adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder
    PORT(
         DataIn : IN  std_logic_vector(31 downto 0);
         Clk : IN  std_logic;
         rst : IN  std_logic;
         immed : IN  std_logic_vector(31 downto 0);
         DataOut : OUT  std_logic_vector(31 downto 0);
         DataOutImmed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal immed : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(31 downto 0);
   signal DataOutImmed : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          DataIn => DataIn,
          Clk => Clk,
          rst => rst,
          immed => immed,
          DataOut => DataOut,
          DataOutImmed => DataOutImmed
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
		rst <= '1';
      DataIn <= x"0000_0000";
      wait for Clk_period; -- initial wait for signals to stabilize

      rst <= '0';
      wait for Clk_period; -- wait for a few clock cycles
			
		immed <= x"0000_000A";

	   for i in 0 to 5 loop -- increment DataIn by 4 each loop
			DataIn <= DataIn + x"4";
			wait for Clk_period; -- wait for a few clock cycles
	   end loop;
		
		wait;
	  
   end process;

END;
