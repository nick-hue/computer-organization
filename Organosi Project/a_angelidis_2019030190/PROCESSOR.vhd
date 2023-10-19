----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:30 04/20/2023 
-- Design Name: 
-- Module Name:    PROCESSOR - Behavioral 
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

entity PROCESSOR is
    Port ( clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC);
end PROCESSOR;

architecture Behavioral of PROCESSOR is

COMPONENT Datapath
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN std_logic;
			Memory_operation : IN STD_LOGIC;
			Instr : out STD_LOGIC_VECTOR(31 downto 0);

         Zero : OUT  std_logic
        );
    END COMPONENT;
	 

COMPONENT Control
    PORT(
			Reset : IN std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         PC_sel : OUT  std_logic;
         PC_Ld_En : OUT  std_logic;
         RF_Wr_En : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         MEM_WrEn : OUT  std_logic;
			Memory_operation : OUT std_logic
        );
    END COMPONENT;

signal PC_sel_sig, PC_LdEn_sig, RF_WrEn_sig, RF_B_sel_sig, RF_WrData_sel_sig, ALU_Bin_sel_sig, zero_sig, Mem_WrEn_sig, Memory_operation_sig : STD_LOGIC;
signal ALU_func_sig : STD_LOGIC_VECTOR (3 downto 0);
signal instr_sig: STD_LOGIC_VECTOR(31 downto 0);

begin
		data_path : Datapath 
		port map(
          Clk => Clk,
          Reset => Reset,
          PC_Sel => PC_sel_sig,
          PC_LdEn => PC_LdEn_sig,
          RF_WrEn => RF_WrEn_sig,
          RF_B_sel => RF_B_sel_sig,
          RF_WrData_sel => RF_WrData_sel_sig,
          ALU_Bin_sel => ALU_Bin_sel_sig,
          ALU_func => ALU_func_sig,
          Mem_WrEn => Mem_WrEn_sig,
			 Memory_operation => Memory_operation_sig,
			 Instr => instr_sig,
          Zero => zero_sig
        );

		con : Control
		port map(
			 Reset => Reset,
          Instr => instr_sig,
          ALU_zero => zero_sig,
          PC_sel => PC_sel_sig,
			 Memory_operation => Memory_operation_sig,
          PC_Ld_En => PC_LdEn_sig,
          RF_Wr_En => RF_WrEn_sig,
          RF_B_sel => RF_B_sel_sig,
          RF_WrData_sel => RF_WrData_sel_sig,
          ALU_Bin_sel => ALU_Bin_sel_sig,
          ALU_func => ALU_func_sig,
          MEM_WrEn => Mem_WrEn_sig
        );



end Behavioral;

