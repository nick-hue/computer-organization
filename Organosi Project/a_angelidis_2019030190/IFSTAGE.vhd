----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:17:27 03/31/2023 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

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

--COMPONENT Mem_Rom
--		PORT(
--			ADDRA : IN std_logic_vector(9 downto 0);
--			CLKA : IN std_logic;
--			DOUTA : OUT  std_logic_vector(31 downto 0)
--	);
--	END COMPONENT;
--	
COMPONENT Rom_Memory
		PORT(
			a : IN std_logic_vector(9 downto 0);
			spo : OUT  std_logic_vector(31 downto 0)
	);
	END COMPONENT;
	
--COMPONENT adder
--    PORT(
--         DataIn : IN  std_logic_vector(31 downto 0);
--         Clk : IN  std_logic;
--         rst : IN  std_logic;
--         immed : IN  std_logic_vector(31 downto 0);
--         DataOut : OUT  std_logic_vector(31 downto 0);
--			DataOutImmed : OUT  std_logic_vector(31 downto 0)
--        );
--    END COMPONENT;

-- PC_in = mux2_out
-- mux_in1 : PC + 4
-- mux_in2 : PC + 4 + PC_immediate
signal PC_in, PC_out, mux_in1, mux_in2, rom_data: STD_LOGIC_VECTOR (31 downto 0);

begin	
	rom : Rom_Memory
	port map(
			a => PC_out(11 downto 2),
			spo => rom_data
	);
	
--	rom : Mem_Rom
--	port map (
--			ADDRA => PC_out(11 downto 2),
--			CLKA => clk,
--			DOUTA => rom_data
--	);
--	
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

	mux_in1 <= PC_out+x"4";
	mux_in2 <= PC_Immed + PC_out + x"4";
	
	Instr <= rom_data;
end Behavioral;

