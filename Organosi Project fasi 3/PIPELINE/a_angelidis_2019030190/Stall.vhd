----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:55:28 06/01/2023 
-- Design Name: 
-- Module Name:    Stall - Behavioral 
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

entity Stall_unit is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DecExMemReadEn : in  STD_LOGIC;
			  DecExMemRd : in  STD_LOGIC_VECTOR (4 downto 0);
           InsDecRs : in  STD_LOGIC_VECTOR (4 downto 0);
           InsDecRt : in  STD_LOGIC_VECTOR (4 downto 0);
           Pc_LdEn : out  STD_LOGIC;
           Instr_Reg_En : out  STD_LOGIC);
end Stall_unit;

architecture Behavioral of Stall_unit is

type state is (stall_state, continue_state);
signal current_state, next_state: state;

begin


	process(current_state,DecExMemReadEn,InsDecRs,InsDecRt)
	begin
		case current_state is

		when stall_state =>	
			PC_LdEn <= '0';
			Instr_Reg_En <= '0';
			next_state <= continue_state;
											
		when continue_state =>	
			if ((DecExMemReadEn = '1') AND (InsDecRs = DecExMemRd OR InsDecRt = DecExMemRd)) then 
				PC_LdEn <= '0';
				Instr_Reg_En <= '0';
				next_state <= stall_state;
			else
				PC_LdEn <= '1';
				Instr_Reg_En <= '1';
				next_state <= continue_state;
			end if;
		end case;
	end process;
	
	process (clk)
	begin
		if (Reset ='1') then
			current_state <= continue_state;
		elsif (rising_edge(clk)) then
		  current_state <= next_state;
		end if;
	end process;

end Behavioral;

