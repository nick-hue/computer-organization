----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:29 06/01/2023 
-- Design Name: 
-- Module Name:    InsDecRegister - Behavioral 
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

entity InsDecRegister is
Port ( 
			  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
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
end InsDecRegister;

architecture Behavioral of InsDecRegister is

COMPONENT Regi
	PORT(
		clk : IN  std_logic;
		rst : IN  std_logic;
		Data : IN  std_logic_vector(31 downto 0);
		WE : IN  std_logic;
		Dout : OUT  std_logic_vector(31 downto 0)
	  );
END COMPONENT;

signal signal_resigter : STD_LOGIC_VECTOR(31 downto 0);
-- signal that holds the values of the signals and the registers 

begin

	InsDec_RF_A : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => RF_A_in,
      WE => '1',
      Dout => RF_A_out
	);
	
	InsDec_RF_B : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => RF_B_in,
      WE => '1',
      Dout => RF_B_out
	);
	
	InsDec_Immed : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => Immed_in,
      WE => '1',
      Dout => Immed_out
	);
	
	process(WB, RF_WrData_sel, MEM_ReadEn, MEM, EX, Rs, Rd, Rt, signal_resigter)
	begin
		signal_register(19 downto 15) <= Rs;
		signal_register(14 downto 10) <= Rd;
		signal_register(9 downto 5) <= Rt;
		signal_register(4) <= WB;
		signal_register(3) <= RF_WrData_sel;
		signal_register(2) <= MEM_ReadEn;
		signal_register(1) <= MEM;
		signal_register(0) <= EX;
	end process;
	
	InsDec_signal_register : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => signal_register,
      WE => '1',
      Dout => signal_register_out
	);


end Behavioral;

