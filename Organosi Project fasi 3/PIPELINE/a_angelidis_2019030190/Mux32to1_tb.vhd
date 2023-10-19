--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:03:40 03/13/2023
-- Design Name:   
-- Module Name:   C:/Users/nicag/Desktop/Organosi Project/a_angelidis_2019030190/Mux32to1_tb.vhd
-- Project Name:  a_angelidis_2019030190
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux32to1
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mux32to1_tb IS
END Mux32to1_tb;
 
ARCHITECTURE behavior OF Mux32to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux32to1
    PORT(
         din0 : IN  std_logic_vector(31 downto 0);
         din1 : IN  std_logic_vector(31 downto 0);
         din2 : IN  std_logic_vector(31 downto 0);
         din3 : IN  std_logic_vector(31 downto 0);
         din4 : IN  std_logic_vector(31 downto 0);
         din5 : IN  std_logic_vector(31 downto 0);
         din6 : IN  std_logic_vector(31 downto 0);
         din7 : IN  std_logic_vector(31 downto 0);
         din8 : IN  std_logic_vector(31 downto 0);
         din9 : IN  std_logic_vector(31 downto 0);
         din10 : IN  std_logic_vector(31 downto 0);
         din11 : IN  std_logic_vector(31 downto 0);
         din12 : IN  std_logic_vector(31 downto 0);
         din13 : IN  std_logic_vector(31 downto 0);
         din14 : IN  std_logic_vector(31 downto 0);
         din15 : IN  std_logic_vector(31 downto 0);
         din16 : IN  std_logic_vector(31 downto 0);
         din17 : IN  std_logic_vector(31 downto 0);
         din18 : IN  std_logic_vector(31 downto 0);
         din19 : IN  std_logic_vector(31 downto 0);
         din20 : IN  std_logic_vector(31 downto 0);
         din21 : IN  std_logic_vector(31 downto 0);
         din22 : IN  std_logic_vector(31 downto 0);
         din23 : IN  std_logic_vector(31 downto 0);
         din24 : IN  std_logic_vector(31 downto 0);
         din25 : IN  std_logic_vector(31 downto 0);
         din26 : IN  std_logic_vector(31 downto 0);
         din27 : IN  std_logic_vector(31 downto 0);
         din28 : IN  std_logic_vector(31 downto 0);
         din29 : IN  std_logic_vector(31 downto 0);
         din30 : IN  std_logic_vector(31 downto 0);
         din31 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(4 downto 0);
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal din0 : std_logic_vector(31 downto 0) := (others => '0');
   signal din1 : std_logic_vector(31 downto 0) := (others => '0');
   signal din2 : std_logic_vector(31 downto 0) := (others => '0');
   signal din3 : std_logic_vector(31 downto 0) := (others => '0');
   signal din4 : std_logic_vector(31 downto 0) := (others => '0');
   signal din5 : std_logic_vector(31 downto 0) := (others => '0');
   signal din6 : std_logic_vector(31 downto 0) := (others => '0');
   signal din7 : std_logic_vector(31 downto 0) := (others => '0');
   signal din8 : std_logic_vector(31 downto 0) := (others => '0');
   signal din9 : std_logic_vector(31 downto 0) := (others => '0');
   signal din10 : std_logic_vector(31 downto 0) := (others => '0');
   signal din11 : std_logic_vector(31 downto 0) := (others => '0');
   signal din12 : std_logic_vector(31 downto 0) := (others => '0');
   signal din13 : std_logic_vector(31 downto 0) := (others => '0');
   signal din14 : std_logic_vector(31 downto 0) := (others => '0');
   signal din15 : std_logic_vector(31 downto 0) := (others => '0');
   signal din16 : std_logic_vector(31 downto 0) := (others => '0');
   signal din17 : std_logic_vector(31 downto 0) := (others => '0');
   signal din18 : std_logic_vector(31 downto 0) := (others => '0');
   signal din19 : std_logic_vector(31 downto 0) := (others => '0');
   signal din20 : std_logic_vector(31 downto 0) := (others => '0');
   signal din21 : std_logic_vector(31 downto 0) := (others => '0');
   signal din22 : std_logic_vector(31 downto 0) := (others => '0');
   signal din23 : std_logic_vector(31 downto 0) := (others => '0');
   signal din24 : std_logic_vector(31 downto 0) := (others => '0');
   signal din25 : std_logic_vector(31 downto 0) := (others => '0');
   signal din26 : std_logic_vector(31 downto 0) := (others => '0');
   signal din27 : std_logic_vector(31 downto 0) := (others => '0');
   signal din28 : std_logic_vector(31 downto 0) := (others => '0');
   signal din29 : std_logic_vector(31 downto 0) := (others => '0');
   signal din30 : std_logic_vector(31 downto 0) := (others => '0');
   signal din31 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux32to1 PORT MAP (
          din0 => din0,
          din1 => din1,
          din2 => din2,
          din3 => din3,
          din4 => din4,
          din5 => din5,
          din6 => din6,
          din7 => din7,
          din8 => din8,
          din9 => din9,
          din10 => din10,
          din11 => din11,
          din12 => din12,
          din13 => din13,
          din14 => din14,
          din15 => din15,
          din16 => din16,
          din17 => din17,
          din18 => din18,
          din19 => din19,
          din20 => din20,
          din21 => din21,
          din22 => din22,
          din23 => din23,
          din24 => din24,
          din25 => din25,
          din26 => din26,
          din27 => din27,
          din28 => din28,
          din29 => din29,
          din30 => din30,
          din31 => din31,
          sel => sel,
          dout => dout
        );
		  
    -- Stimulus process
   stim_proc: process
   begin
		din0 <= x"7962e71e";
		din1 <= x"debf9ba7";
		din2 <= x"debf9ba7";
		din3 <= x"956ce729";
		din4 <= x"64afde80";
		din5 <= x"f4e92bb0";
		din6 <= x"6ece98b2";
		din7 <= x"74848b3d";
		din8 <= x"c8900ad2";
		din9 <= x"9134f508";
		din10 <= x"8fa4b10e";
		din11 <= x"8cfa3410";
		din12 <= x"73b199cf";
		din13 <= x"c8ac3faa";
		din14 <= x"4f987f8c";
		din15 <= x"72d67dc9";
		din16 <= x"ed35854d";
		din17 <= x"cddf185a";
		din18 <= x"2c0f5977";
		din19 <= x"05916652";
		din20 <= x"a7b4089a";
		din21 <= x"e7640b4d";
		din22 <= x"193487cb";
		din23 <= x"99bbca54";
		din24 <= x"3b6db2ab";
		din25 <= x"5c567da7";
		din26 <= x"e5f3c21d";
		din27 <= x"ff103c28";
		din28 <= x"6c908806";
		din29 <= x"06a70686";
		din30 <= x"70004ba5";
		din31 <= x"d4ee583e";
		
		for i in 0 to 31 loop
			sel <= std_logic_vector(to_unsigned(i, 5));
			wait for 50 ns;
		end loop;		
		
      wait;
   end process;

END;
