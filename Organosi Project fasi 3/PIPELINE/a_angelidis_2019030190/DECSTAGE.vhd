----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:20 03/23/2023 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
  			  WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  wrData : out STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

COMPONENT Edit
    PORT(
         Instr : IN  std_logic_vector(15 downto 0);
         Choice : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

COMPONENT Mux2_5
    PORT(
         din1 : IN  std_logic_vector(4 downto 0);
         din2 : IN  std_logic_vector(4 downto 0);
         sel : IN  std_logic;
         dout : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
	 
COMPONENT Mux2to1
    PORT(
         din1 : IN  std_logic_vector(31 downto 0);
         din2 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         rst : IN  std_logic;
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

signal mux_alu_mem_out_sig: STD_LOGIC_VECTOR(31 downto 0);
signal sig_25_21, sig_20_16, sig_15_11, mux_instr_out_sig: STD_LOGIC_VECTOR (4 downto 0); -- 5 bits
signal sig_15_0 : STD_LOGIC_VECTOR (15 downto 0);
signal op_code_sig : STD_LOGIC_VECTOR (5 downto 0);
signal choice_sig : STD_LOGIC_VECTOR (1 downto 0);

begin
	op_code_sig <= Instr(31 downto 26);
	sig_25_21 <= Instr(25 downto 21);
	sig_20_16 <= Instr(20 downto 16);
	sig_15_11 <= Instr(15 downto 11);
	sig_15_0 <= Instr(15 downto 0);
	
	process (op_code_sig)
	begin
		case (op_code_sig) is 
			when "111000" => choice_sig <= "01"; -- li
			when "111001" => choice_sig <= "10"; -- lui
			when "110000" => choice_sig <= "01"; -- addi
			when "110010" => choice_sig <= "00"; -- andi
			when "110011" => choice_sig <= "00"; -- ori 
			when "111111" => choice_sig <= "11"; -- b 
			when "010000" => choice_sig <= "11"; -- beq
			when "010001" => choice_sig <= "11"; -- bne
			when "000011" => choice_sig <= "01"; -- lb
			when "000111" => choice_sig <= "01"; -- sb
			when "001111" => choice_sig <= "01"; -- lw
			when "011111" => choice_sig <= "01"; -- sw
			
			when others => choice_sig <= "XX";
		end case;
	end process;
	
	editor : Edit
	port map (
		Instr => sig_15_0,
		Choice => choice_sig,
		output => Immed
	);
	
	mux2_instr : Mux2_5
		port map(
				din1 => sig_15_11,
				din2 => sig_20_16,
				sel => RF_B_sel,
				dout => mux_instr_out_sig
		);
		
	mux2_ALU_MEM : Mux2to1
		port map(
				din1 => ALU_out,
				din2 => MEM_out,
				sel => RF_WrData_sel,
				dout => mux_alu_mem_out_sig
		);
		
	wrData <= mux_alu_mem_out_sig;
	
	register_file : RF 
		port map (
         Ard1  => sig_25_21,
         Ard2 => mux_instr_out_sig,
         Awr => WB_Rd,
         Din => mux_alu_mem_out_sig,
         WrEn => RF_WrEn,
         Clk => Clk,
         rst => Reset,
         Dout1 => RF_A,
         Dout2 => RF_B
		);
		
end Behavioral;

