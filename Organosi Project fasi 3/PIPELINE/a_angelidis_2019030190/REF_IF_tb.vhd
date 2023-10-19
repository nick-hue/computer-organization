--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:39:57 03/23/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/REF_IF_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: REF_IF
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
 
ENTITY REF_IF_tb IS
END REF_IF_tb;
 
ARCHITECTURE behavior OF REF_IF_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REF_IF
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REF_IF PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          Instr => Instr
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
      -- PC sel = 0 
		Reset <= '1';
		wait for Clk_period;
		
		Reset <= '0';
		
		-- can't load
		-- afou dialegoume tin din1 tou multiplexer den mas noiazei to immidiate
		PC_sel <= '0';
		PC_LdEn <= '0';
		wait for Clk_period;
		
		-- prepei na grapsei
		-- 2 kyklous gia PC = PC + 4
		PC_LdEn <= '1';
		wait for 2*Clk_period;
				
		-- 2 kyklous gia PC = PC + 4 + immed(0000_ffff)
		PC_sel <= '1';
		PC_Immed <= x"0000_ffff";
		wait for 2*Clk_period;

		-- na min grapsei
		PC_LdEn <= '0';
		wait for Clk_period;

		-- reset
		Reset <= '1';
		wait for Clk_period;
		
		-- na min grapsei meta to reset
		Reset <= '0';
		wait for Clk_period;

		-- na grapsei PC = PC + 4 + immed(ffff_0000)
		PC_LdEn <= '1';
		PC_sel <= '1';
		PC_Immed <= x"ffff_0000";
		wait for Clk_period;
				
		-- na grapsei PC = PC + 4 mexri na teleiwsei to simulation
		PC_sel <= '0';
		wait for Clk_period;

		wait;
   end process;

END;
