----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:47:45 06/01/2023 
-- Design Name: 
-- Module Name:    Mux4_1 - Behavioral 
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

entity Mux4_1 is
	Port ( 
		din1 : in  STD_LOGIC_VECTOR (31 downto 0);
      din2 : in  STD_LOGIC_VECTOR (31 downto 0);
      din3 : in  STD_LOGIC_VECTOR (31 downto 0);
		din4 : in  STD_LOGIC_VECTOR (31 downto 0);
      sel : in  STD_LOGIC_VECTOR (1 downto 0);
      dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux4_1;

architecture Behavioral of Mux4_1 is

begin
	with (sel) select
		dout <=		
			din1 when "00",
			din2 when "01",
			din3 when "10",
			din4 when others;

end Behavioral;

