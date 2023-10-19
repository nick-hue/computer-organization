----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:32 03/23/2023 
-- Design Name: 
-- Module Name:    REF_IF - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REF_IF is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end REF_IF;

architecture Behavioral of REF_IF is

COMPONENT Mux2to1
    PORT(
         din1 : IN  std_logic_vector(31 downto 0);
         din2 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

COMPONENT Regi
    PORT(
         clk : IN  std_logic;
			rst : IN std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

-- PC_in = mux2_out
signal PC_in, PC_out, mux_in1, mux_in2 : STD_LOGIC_VECTOR (31 downto 0);

begin
	
	mux2 : Mux2to1
	port map(
			din1 => mux_in1,
         din2 => mux_in2,
         sel => PC_sel,
         dout => PC_in
	);
	
	PC : Regi
	port map (
			clk => clk,
			rst => Reset,
			Data => PC_in,
			WE => PC_LdEn,
			Dout => PC_out
	);
	Instr <= PC_out;
	mux_in1 <= PC_out+x"4";
	mux_in2 <= PC_Immed + PC_out + x"4";
	
	
		
end Behavioral;

