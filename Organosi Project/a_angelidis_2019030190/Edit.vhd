----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:03:23 03/31/2023 
-- Design Name: 
-- Module Name:    Edit - Behavioral 
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

entity Edit is
    Port ( Instr : in  STD_LOGIC_VECTOR (15 downto 0);
           Choice : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0));
end Edit;

architecture Behavioral of Edit is

signal out_sig : STD_LOGIC_VECTOR(31 downto 0);

begin
	process (Instr, Choice) 
	begin
		case (Choice) is
			-- choice == 00 we do zero filling 
			when "00" => out_sig <= "0000000000000000" & Instr;
			
			-- choice == 01 we do sign extend
			when "01" => out_sig(15 downto 0) <= Instr;
							 for i in 16 to 31 loop
								out_sig(i) <= Instr(15);
							 end loop;
			-- choice == 10 we do zero fill and after left for 16 bits 
			when "10" => out_sig(31 downto 16) <= Instr(15 downto 0);
							 out_sig(15 downto 0) <= (others => '0');
							 
			-- choice == 11 we do sign extend and shift left for 2 bits				
			when "11" => out_sig(17 downto 2) <= Instr;
							 for i in 18 to 31 loop
								out_sig(i) <= Instr(15);
							 end loop;
							 out_sig(1 downto 0) <= "00";	 
							 
			when others => out_sig <= x"0000_0000";
		end case;	
	end process;
	Output <= out_sig;

end Behavioral;

