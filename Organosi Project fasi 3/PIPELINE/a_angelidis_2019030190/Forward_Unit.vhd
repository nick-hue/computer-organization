----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:23 06/01/2023 
-- Design Name: 
-- Module Name:    Forward_Unit - Behavioral 
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

entity Forward_Unit is
	Port ( 
		EX_MEM_RegWrite : in  STD_LOGIC;
      MEM_WB_RegWrite : in  STD_LOGIC;
		DecExecMem : in  STD_LOGIC; 
      EX_MEM_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
      DecExecRs : in  STD_LOGIC_VECTOR (4 downto 0);
		DecExMemRd : in  STD_LOGIC_VECTOR (4 downto 0);  
      DecExecRt : in  STD_LOGIC_VECTOR (4 downto 0);
      MEM_WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
      ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
      ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end Forward_Unit;

architecture Behavioral of Forward_Unit is

begin

	process(DecExecRs, EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_Rd, MEM_WB_Rd)
	begin
		if ((EX_MEM_RegWrite = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = DecExecRs)) then
			ForwardA <= "10";
		elsif ((MEM_WB_RegWrite = '1') AND (MEM_WB_Rd /= "00000") AND (MEM_WB_Rd = DecExecRs)) then
			ForwardA <= "01";
		else
			ForwardA <= "00";
		end if;
	end process;

	process(DecExecRt, EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_Rd, MEM_WB_Rd)
	begin
		if ((EX_MEM_RegWrite = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = DecExecRt)) then 
			ForwardB <= "10";
		elsif ((MEM_WB_RegWrite = '1') AND (MEM_WB_Rd /= "00000") AND (MEM_WB_Rd = DecExecRt)) then
			ForwardB <= "01";
		elsif (MEM_WB_Rd = DecExMemRd AND DecExecMem = '1') then
			ForwardB <= "11";
		else
			ForwardB <= "00";
		end if;
	end process;
	
end Behavioral;

