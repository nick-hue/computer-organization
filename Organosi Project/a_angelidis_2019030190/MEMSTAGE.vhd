----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:26 03/31/2023 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( CLK : in  STD_LOGIC;
			  Memory_operation : in  STD_LOGIC;
           MEM_WrEn : in  std_logic;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

COMPONENT Ram_Memory
		PORT(
			a : IN std_logic_vector(9 downto 0);
			d : IN  std_logic_vector(31 downto 0);
			we : IN  std_logic;
			clk : IN std_logic;
			spo : OUT  std_logic_vector(31 downto 0)
	);
	END COMPONENT;

signal mem_out_sig, final_mem_in: STD_LOGIC_VECTOR(31 downto 0);

begin

	ram : Ram_Memory
	port map (
		a => ALU_MEM_Addr(11 downto 2),
		d => final_mem_in,
		we => MEM_WrEn,
		clk => CLK,
		spo => mem_out_sig
	);
	
	with Memory_operation select final_mem_in <= "000000000000000000000000"&MEM_DataIn(7 downto 0) when '1',
																MEM_DataIn when others;

--	with Memory_operation select mem_out_sig <= "000000000000000000000000"&mem_out_sig(7 downto 0) when '1',
--																mem_out_sig when others;
	
	MEM_DataOut <= mem_out_sig;
end Behavioral;

