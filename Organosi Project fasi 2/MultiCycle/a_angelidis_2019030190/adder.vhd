----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:56:18 04/14/2023 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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
--

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    Port ( DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           Clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  immed : in STD_LOGIC_VECTOR(31 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  DataOutImmed : out  STD_LOGIC_VECTOR (31 downto 0));
end adder;

architecture Behavioral of adder is

signal data_out_sig, data_out_immed_sig: STD_LOGIC_VECTOR(31 downto 0);

begin
	process(DataIn, clk, rst, immed)
	begin
		if rst = '1' then 
			data_out_sig <= x"0000_0000";
			data_out_immed_sig <= x"0000_0000";
		else
			if (rising_edge(clk) and rst = '0')then
				data_out_sig <= DataIn + x"4";
				data_out_immed_sig <= DataIn + x"4" + immed;
			elsif (falling_edge(clk) and rst = '0')then--?
				data_out_sig <= DataIn;
				data_out_immed_sig <= DataIn;
			else 
				data_out_sig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
				data_out_immed_sig <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
			end if;
		end if;
	end process;
	DataOut <= data_out_sig;
	DataOutImmed <= data_out_immed_sig;
end Behavioral;

