----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:00:58 03/13/2023 
-- Design Name: 
-- Module Name:    Mux32to1 - Behavioral 
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

entity Mux32to1 is
    Port ( din0 : in  STD_LOGIC_VECTOR (31 downto 0);
           din1 : in  STD_LOGIC_VECTOR (31 downto 0);
           din2 : in  STD_LOGIC_VECTOR (31 downto 0);
           din3 : in  STD_LOGIC_VECTOR (31 downto 0);
           din4 : in  STD_LOGIC_VECTOR (31 downto 0);
           din5 : in  STD_LOGIC_VECTOR (31 downto 0);
           din6 : in  STD_LOGIC_VECTOR (31 downto 0);
           din7 : in  STD_LOGIC_VECTOR (31 downto 0);
           din8 : in  STD_LOGIC_VECTOR (31 downto 0);
           din9 : in  STD_LOGIC_VECTOR (31 downto 0);
           din10 : in  STD_LOGIC_VECTOR (31 downto 0);
           din11 : in  STD_LOGIC_VECTOR (31 downto 0);
           din12 : in  STD_LOGIC_VECTOR (31 downto 0);
           din13 : in  STD_LOGIC_VECTOR (31 downto 0);
           din14 : in  STD_LOGIC_VECTOR (31 downto 0);
           din15 : in  STD_LOGIC_VECTOR (31 downto 0);
           din16 : in  STD_LOGIC_VECTOR (31 downto 0);
           din17 : in  STD_LOGIC_VECTOR (31 downto 0);
           din18 : in  STD_LOGIC_VECTOR (31 downto 0);
           din19 : in  STD_LOGIC_VECTOR (31 downto 0);
           din20 : in  STD_LOGIC_VECTOR (31 downto 0);
           din21 : in  STD_LOGIC_VECTOR (31 downto 0);
           din22 : in  STD_LOGIC_VECTOR (31 downto 0);
           din23 : in  STD_LOGIC_VECTOR (31 downto 0);
           din24 : in  STD_LOGIC_VECTOR (31 downto 0);
           din25 : in  STD_LOGIC_VECTOR (31 downto 0);
           din26 : in  STD_LOGIC_VECTOR (31 downto 0);
           din27 : in  STD_LOGIC_VECTOR (31 downto 0);
           din28 : in  STD_LOGIC_VECTOR (31 downto 0);
           din29 : in  STD_LOGIC_VECTOR (31 downto 0);
           din30 : in  STD_LOGIC_VECTOR (31 downto 0);
           din31 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux32to1;

architecture Behavioral of Mux32to1 is

begin
	with (sel) select
		dout <=	din0  when "00000",
					din1  when "00001",
					din2  when "00010",
					din3  when "00011",
					din4  when "00100",
					din5  when "00101",
					din6  when "00110",
					din7  when "00111",
					din8  when "01000",
					din9  when "01001",
					din10  when "01010",
					din11  when "01011",
					din12  when "01100",
					din13  when "01101",
					din14  when "01110",
					din15  when "01111",
					din16  when "10000",
					din17  when "10001",
					din18  when "10010",
					din19  when "10011",
					din20  when "10100",
					din21  when "10101",
					din22  when "10110",
					din23  when "10111",
					din24  when "11000",
					din25  when "11001",
					din26  when "11010",
					din27  when "11011",
					din28  when "11100",
					din29  when "11101",
					din30  when "11110",
					din31  when others;


end Behavioral;

