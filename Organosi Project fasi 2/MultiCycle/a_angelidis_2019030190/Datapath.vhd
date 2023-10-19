----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:00:32 04/04/2023 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
			  RF_WrEn : in STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
			  ALU_func : IN  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WrEn : in  STD_LOGIC;
			  Memory_operation : in  STD_LOGIC;
			  Mem_REn : in  STD_LOGIC;
 			  Get_instr_En : in  STD_LOGIC;
			  Instr : out STD_LOGIC_VECTOR(31 downto 0);
			  Zero : out  STD_LOGIC);

end Datapath;

architecture Behavioral of Datapath is

COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT Regi
    PORT(
         clk : IN  std_logic;
			rst : IN std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 
	COMPONENT EXECSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
			Zero : out  STD_LOGIC;
			Cout : out  STD_LOGIC;
			Ovf : out  STD_LOGIC
        );
    END COMPONENT;

	COMPONENT MEMSTAGE
	 PORT(
			CLK : in  STD_LOGIC;
			Memory_operation : in STD_LOGIC;
         MEM_WrEn : in  STD_LOGIC;
         ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
         MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;

signal instr_sig, RF_A_sig, RF_B_sig, immed_sig, ALU_out_sig, MEM_out_sig: STD_LOGIC_VECTOR(31 downto 0);
signal instruction_register_out_sig, rf_a_register_out_sig, rf_b_register_out_sig, immediate_register_out_sig, alu_register_out_sig, memory_register_out_sig: STD_LOGIC_VECTOR(31 downto 0);
signal cout_sig, Ovf_sig: STD_LOGIC;

begin
	if_stage : IFSTAGE
	port map (
			PC_Immed => immed_sig,
         PC_sel => PC_sel,
         PC_LdEn => PC_LdEn,
         Reset => Reset,
         Clk => Clk,
         Instr => instr_sig
	);
	dec_stage : DECSTAGE
	port map (
			Instr => instruction_register_out_sig,
         RF_WrEn => RF_WrEn,
         ALU_out => alu_register_out_sig,
         MEM_out => memory_register_out_sig,
         RF_WrData_sel => RF_WrData_sel,
         RF_B_sel => RF_B_sel,
         Clk => Clk,
         Reset => Reset,
         Immed => immed_sig,
         RF_A => RF_A_sig,
         RF_B => RF_B_sig
	);
	
	exec_stage : EXECSTAGE
	port map (
			RF_A => rf_a_register_out_sig,
         RF_B => rf_b_register_out_sig,
         Immed => immediate_register_out_sig,
         ALU_Bin_sel => ALU_Bin_sel,
         ALU_func => ALU_func,
         ALU_out => ALU_out_sig,
			Zero => Zero,
			Cout => cout_sig,
			Ovf => Ovf_sig
	);

	mem_stage : MEMSTAGE
	port map (
			CLK => Clk,
         MEM_WrEn => Mem_WrEn,
         ALU_MEM_Addr => alu_register_out_sig,
         MEM_DataIn => rf_b_register_out_sig,
         MEM_DataOut => MEM_out_sig,
			Memory_operation => Memory_operation 
	);
	
	instruction_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => instr_sig,
      WE => Get_instr_En,
		Dout => instruction_register_out_sig
	);
	
	rf_a_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => RF_A_sig,
      WE => '1',
		Dout => rf_a_register_out_sig
	);
	
	rf_b_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => RF_B_sig,
      WE => '1',
		Dout => rf_b_register_out_sig
	);

	immediate_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => immed_sig,
      WE => '1',
		Dout => immediate_register_out_sig
	);
	
	alu_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => ALU_out_sig,
      WE => '1',
		Dout => alu_register_out_sig
	);
	
	memory_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => MEM_out_sig,
      WE => Mem_REn,
		Dout => memory_register_out_sig
	);
	
	Instr <= instruction_register_out_sig;

end Behavioral;

