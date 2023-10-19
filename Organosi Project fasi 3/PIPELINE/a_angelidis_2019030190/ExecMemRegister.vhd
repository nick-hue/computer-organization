----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:26:05 06/01/2023 
-- Design Name: 
-- Module Name:    ExecMemRegister - Behavioral 
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

entity ExecMemRegister is
		Port ( 
			clk : in  STD_LOGIC;
			rst : in  STD_LOGIC;
			RF_WrData_sel : in STD_LOGIC;
			WB : in  STD_LOGIC;
			MEM_ReadEn : in  STD_LOGIC;
			MEM : in  STD_LOGIC;
			Rd : in STD_LOGIC_VECTOR (4 downto 0);
			ALU_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
			ALU_OUT_out : out STD_LOGIC_VECTOR (31 downto 0);
			RF_B_in : in STD_LOGIC_VECTOR (31 downto 0);
			RF_B_out : out STD_LOGIC_VECTOR (31 downto 0);
			signal_register_out : out STD_LOGIC_VECTOR (31 downto 0)			
			  );
end ExecMemRegister;

architecture Behavioral of ExecMemRegister is

COMPONENT Regi
	PORT(
		clk : IN  std_logic;
		rst : IN  std_logic;
		Data : IN  std_logic_vector(31 downto 0);
		WE : IN  std_logic;
		Dout : OUT  std_logic_vector(31 downto 0)
	  );
END COMPONENT;

signal tmp_resigter : STD_LOGIC_VECTOR(31 downto 0);

begin

	ExecMem_ALU : Regi
		port map (
			clk => clk,
			rst => rst,
			Data => ALU_OUT_in,
			WE => '1',
			Dout => ALU_OUT_out
		);
		
	ExecMem_RF_B : Regi
		port map (
			clk => clk,
			rst => rst,
			Data => RF_B_in,
			WE => '1',
			Dout => RF_B_out
		);
		
		ExecMem_signal_register : Regi
	port map (
		clk => clk,
		rst => rst,
      Data => tmp_resigter,
      WE => '1',
      Dout => signal_register_out
	);
		
	process(WB, RF_WrData_sel, MEM_ReadEn, MEM, Rd, tmp_resigter)
	begin
		tmp_resigter(8 downto 4) <= Rd;
		tmp_resigter(3) <= WB;
		tmp_resigter(2) <= RF_WrData_sel;
		tmp_resigter(1) <= MEM_ReadEn;
		tmp_resigter(0) <= MEM;
	end process;

end Behavioral;

