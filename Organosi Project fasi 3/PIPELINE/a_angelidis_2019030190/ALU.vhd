----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:48:18 03/12/2023 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal out_sig : STD_LOGIC_VECTOR (31 downto 0);
signal cout_sig : STD_LOGIC;
signal zero_sig : STD_LOGIC;
signal overflow_sig : STD_LOGIC;

begin
	process(Op, A, B, out_sig, cout_sig, zero_sig, overflow_sig)
	variable tmp_sig: STD_LOGIC_VECTOR (32 downto 0);
	begin 
	cout_sig <= '0';
		case Op is
			when "0000" => 										-- addition 
				tmp_sig := STD_LOGIC_VECTOR(("0" & A) + ("0" & B));
				out_sig <= tmp_sig(31 downto 0); 			-- result
				cout_sig <= tmp_sig(32); 						-- carry 
				if (A(31) = B(31)) and (A(31) /= out_sig(31)) then -- overflow
					overflow_sig <= '1';
				else 
					overflow_sig <= '0';
				end if;

			when "0001" =>											-- subtraction
				tmp_sig := STD_LOGIC_VECTOR(("0" & A) - ("0" & B));
				out_sig <= tmp_sig(31 downto 0); 			-- result
				cout_sig <= tmp_sig(32); 						-- carry
				if (A(31) /= B(31)) and (A(31) = out_sig(31)) then
					overflow_sig <= '1';
				else
					overflow_sig <= '0';
				end if;
				
			when "0010" => 										-- and
				out_sig <= A and B;		
			
			when "0011" =>											-- or
				out_sig <= A or B;
			
			when "0100" => 										-- not
				out_sig <= not A;			
			
			when "1000" =>											-- sla
				out_sig(30 downto 0) <= A(31 downto 1);
				out_sig(31) <= A(31);
				
			when "1001" => 										-- srl
				out_sig(30 downto 0) <= A(31 downto 1);
				out_sig(31) <= '0'; 
				
			when "1010" => 										-- sll 
				out_sig(31 downto 1) <= A(30 downto 0);
				out_sig(0) <= '0';
				
			when "1100" => 										-- rotate left
				out_sig(31 downto 1) <= A(30 downto 0);
				out_sig(0) <= A(31);
				
			when "1101" => 										-- rotate right
				out_sig(30 downto 0) <= A(31 downto 1);
				out_sig(31) <= A(0);
				
			when others =>
				out_sig <= "00000000000000000000000000000000";
		end case;
		
		if (out_sig = "00000000000000000000000000000000") then
			zero_sig <= '1';
		else 
			zero_sig <= '0';
		end if;
--		
--		case out_sig is
--			
--			when "00000000000000000000000000000000" => zero_sig <= '1';
--			when others => zero_sig <= '0';
--		end case;
		
	end process;
	
	Output <= out_sig;
	Cout <= cout_sig;
	Zero <= zero_sig;
	Ovf <= overflow_sig;
	
end Behavioral;

