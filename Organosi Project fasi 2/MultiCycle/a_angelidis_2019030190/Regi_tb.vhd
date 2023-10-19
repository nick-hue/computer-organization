--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:59:42 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Regi_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Regi
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
 
ENTITY Regi_tb IS
END Regi_tb;
 
ARCHITECTURE behavior OF Regi_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Regi
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal Data : std_logic_vector(31 downto 0) := (others => '0');
   signal WE : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Regi PORT MAP (
          clk => clk,
          rst => rst,
          Data => Data,
          WE => WE,
          Dout => Dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		-- total sim time : 1000 ns
		rst <= '1';
		wait for 2*clk_period;
		
		rst <= '0';
		
		WE <= '1';
		Data <= x"AE25_ED01";
		wait for clk_period;
		
		WE <= '1';
		Data <= x"ED01_AE25";
		wait for clk_period;
		
		WE <= '0';
		Data <= x"AE25_ED01";
		wait for clk_period;
		
		WE <= '1';
		Data <= x"AE25_ED01";
		wait for clk_period;
		
		rst <= '1';
		wait for 2*clk_period;
		
		rst <= '0';
		
		WE <= '1';
		Data <= x"8AEF_9AC2";
		wait for clk_period;
		
		WE <= '0';
		Data <= x"AE25_ED01";
		wait for clk_period;

      wait;
   end process;

END;
