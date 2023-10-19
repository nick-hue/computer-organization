----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:15:53 06/01/2023 
-- Design Name: 
-- Module Name:    DecExecRegister - Behavioral 
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

entity DecExecRegister is
Port ( 
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  WB : in  STD_LOGIC;
			  RF_WrData_sel : in STD_LOGIC;
			  MEM_ReadEn : in  STD_LOGIC;
			  MEM : in  STD_LOGIC;
			  EX : in  STD_LOGIC;
			  Rt : in STD_LOGIC_VECTOR (4 downto 0);
			  Rd : in STD_LOGIC_VECTOR (4 downto 0);
			  Rs : in STD_LOGIC_VECTOR (4 downto 0);
			  signal_register_out : out STD_LOGIC_VECTOR (31 downto 0); 
			  RF_A_in : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_A_out : out STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_in : in STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_out : out STD_LOGIC_VECTOR (31 downto 0);
			  Immed_in : in STD_LOGIC_VECTOR (31 downto 0);
			  Immed_out : out STD_LOGIC_VECTOR (31 downto 0)
			  );
end DecExecRegister;

architecture Behavioral of DecExecRegister is

COMPONENT Regi
	PORT(
		clk : IN  std_logic;
		rst : IN  std_logic;
		Data : IN  std_logic_vector(31 downto 0);
		WE : IN  std_logic;
		Dout : OUT  std_logic_vector(31 downto 0)
	  );
END COMPONENT;

-- signal that holds the values of the signals and the registers 
signal tmp_resigter : STD_LOGIC_VECTOR(31 downto 0);

begin
	DecExec_RF_A : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => RF_A_in,
      WE => '1',
      Dout => RF_A_out
	);
	
	DecExec_RF_B : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => RF_B_in,
      WE => '1',
      Dout => RF_B_out
	);
	
	DecExec_Immed : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => Immed_in,
      WE => '1',
      Dout => Immed_out
	);
	
	DecExec_signal_register : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => tmp_resigter,
      WE => '1',
      Dout => signal_register_out
	);
	
	process(WB, RF_WrData_sel, MEM_ReadEn, MEM, EX, Rs, Rd, Rt, tmp_resigter)
	begin
		tmp_resigter(19 downto 15) <= Rs;
		tmp_resigter(14 downto 10) <= Rd;
		tmp_resigter(9 downto 5) <= Rt;
		tmp_resigter(4) <= WB;
		tmp_resigter(3) <= RF_WrData_sel;
		tmp_resigter(2) <= MEM_ReadEn;
		tmp_resigter(1) <= MEM;
		tmp_resigter(0) <= EX;
	end process;
	
end Behavioral;