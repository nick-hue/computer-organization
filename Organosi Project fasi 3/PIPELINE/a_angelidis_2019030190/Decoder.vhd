----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:00:41 03/13/2023 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( input : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal out_sig : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(input, out_sig)
	begin
		case input is
			when "00000" => out_sig <= X"0000_0001";
			when "00001" => out_sig <= X"0000_0002";
			when "00010" => out_sig <= X"0000_0004";
			when "00011" => out_sig <= X"0000_0008";
			when "00100" => out_sig <= X"0000_0010";
			when "00101" => out_sig <= X"0000_0020";
			when "00110" => out_sig <= X"0000_0040";
			when "00111" => out_sig <= X"0000_0080";
			when "01000" => out_sig <= X"0000_0100";
			when "01001" => out_sig <= X"0000_0200";
			when "01010" => out_sig <= X"0000_0400";
			when "01011" => out_sig <= X"0000_0800";
			when "01100" => out_sig <= X"0000_1000";
			when "01101" => out_sig <= X"0000_2000";
			when "01110" => out_sig <= X"0000_4000";
			when "01111" => out_sig <= X"0000_8000";
			when "10000" => out_sig <= X"0001_0000";
			when "10001" => out_sig <= X"0002_0000";
			when "10010" => out_sig <= X"0004_0000";
			when "10011" => out_sig <= X"0008_0000";
			when "10100" => out_sig <= X"0010_0000";
			when "10101" => out_sig <= X"0020_0000";
			when "10110" => out_sig <= X"0040_0000";
			when "10111" => out_sig <= X"0080_0000";
			when "11000" => out_sig <= X"0100_0000";
			when "11001" => out_sig <= X"0200_0000";
			when "11010" => out_sig <= X"0400_0000";
			when "11011" => out_sig <= X"0800_0000";
			when "11100" => out_sig <= X"1000_0000";
			when "11101" => out_sig <= X"2000_0000";
			when "11110" => out_sig <= X"4000_0000";
			when others => out_sig <= X"8000_0000";
		end case;
	end process;
	output <= out_sig;
	
end Behavioral;

