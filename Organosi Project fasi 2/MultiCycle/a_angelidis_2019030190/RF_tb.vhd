--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:28:03 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/RF_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RF_tb IS
END RF_tb;
 
ARCHITECTURE behavior OF RF_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         rst : IN  std_logic;
         Dout1 : INOUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal Dout1 : std_logic_vector(31 downto 0);

 	--Outputs
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          rst => rst,
          Dout1 => Dout1,
          Dout2 => Dout2
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
			-- total sim time : 1700 ns
			rst <= '1';	
			wait for Clk_period;
			
			rst <= '0';
			
			-- should not write on register '3' the number ffff_ffff 
			WrEn <= '0';
			Din <= x"FFFF_FFFF"; -- 1,505,901,262
			Ard1 <= "00011";
			Awr <= "00011";
         wait for Clk_period;
			
			WrEn <= '1';			-- WrEN on
			
			-- should write on register '3' the number ffff_ffff 
			Din <= x"FFFF_FFFF"; 
			Ard1 <= "00011";
			Awr <= "00011";
         wait for Clk_period;
			
			-- should not write on register '7' the number ffff_ffff 
			Din <= x"FFFF_FFFF"; 
			Ard1 <= "00111";
			Awr <= "00001";
         wait for Clk_period;
			
			Din <= x"0000_0000"; 

			
			WrEn <= '0';			-- WrEN off
			Awr <= "00000";
			
			Ard1 <= "00011"; -- show register '3'
			wait for Clk_period;
			
			Ard1 <= "00111"; -- show register '7'
			wait for Clk_period;
			
			Ard1 <= "00011"; -- show register '3'
			wait for Clk_period;

			-- should not write on register '4' the number 0000_ffff 
			Din <= x"0000_FFFF"; 
			Ard2 <= "00100";
			Awr <= "00100";
         wait for Clk_period;

			WrEn <= '1';			-- WrEN on

			-- should write on register '4' the number 0000_ffff 
			Din <= x"0000_FFFF"; 
			Ard2 <= "00100";
			Awr <= "00100";
         wait for Clk_period;
			
			-- should write on register '28' the number 0000_ffff 
			Din <= x"FF00_00FF"; 
			Ard2 <= "11100";
			Awr <= "11100";
         wait for Clk_period;
			
			WrEn <= '0';			-- WrEN off
			Awr <= "00000";
			
			Ard2 <= "00100"; -- show register '4'
			wait for Clk_period;
			
			Ard2 <= "11100"; -- show register '28'
			wait for Clk_period;
				
			WrEn <= '1';			-- WrEN on

			-- Register '0' should always be 0
			Ard1 <= "00000"; -- show register '0'
			Ard2 <= "00000"; -- show register '0'
			wait for Clk_period;	

			Awr <= "00001"; -- change awr to not write on register 0 
			wait for Clk_period;	
			
			WrEn <= '0';			-- WrEN on
			wait for Clk_period;
			
			
			Ard1 <= "00100"; -- show register '4'			
			Ard2 <= "11100"; -- show register '28'
			wait for Clk_period;
			
			rst <= '1';
			wait for Clk_period;

			rst <= '0';
			Ard1 <= "00100"; -- show register '4'			
			Ard2 <= "11100"; -- show register '28'
			wait for Clk_period;
			
			wait;

	end process;

END;
