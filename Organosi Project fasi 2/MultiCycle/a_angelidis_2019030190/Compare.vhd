----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:04 03/13/2023 
-- Design Name: 
-- Module Name:    Compare - Behavioral 
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

entity Compare is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Awd : in  STD_LOGIC_VECTOR (4 downto 0);
           equal_flag : out  STD_LOGIC);
end Compare;

architecture Behavioral of Compare is

begin
	equal_flag <= '1' when (Awr = Ard) else '0';	
end Behavioral;

