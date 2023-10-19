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

	COMPONENT Regi
    PORT(
         clk : IN  std_logic;
			rst : IN std_logic;
         Data : IN  std_logic_vector(31 downto 0);
         WE : IN  std_logic;
         Dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

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
         WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0);
			wrData : out STD_LOGIC_VECTOR (31 downto 0)

        );
    END COMPONENT;
	 
	 COMPONENT DecExecRegister
	 PORT ( 
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

	COMPONENT Mux4_1
	 PORT ( 
			din1 : in  STD_LOGIC_VECTOR (31 downto 0);
			din2 : in  STD_LOGIC_VECTOR (31 downto 0);
			din3 : in  STD_LOGIC_VECTOR (31 downto 0);
			din4 : in  STD_LOGIC_VECTOR (31 downto 0);
			sel : in  STD_LOGIC_VECTOR (1 downto 0);
			dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end COMPONENT;

	COMPONENT ExecMemRegister 
	 PORT ( 
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
	
	COMPONENT MemWriteBackRegister
	 PORT( 
		clk : in  STD_LOGIC;
      rst : in  STD_LOGIC;
		RF_WrData_sel : in STD_LOGIC;
		WB : in  STD_LOGIC;
		Rd : in STD_LOGIC_VECTOR (4 downto 0);
		ALU_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
		ALU_OUT_out : out STD_LOGIC_VECTOR (31 downto 0);
		MEM_OUT_in : in STD_LOGIC_VECTOR (31 downto 0);
		MEM_OUT_out : out STD_LOGIC_VECTOR (31 downto 0);
		signal_register_out : out STD_LOGIC_VECTOR (31 downto 0)			
		);
	END COMPONENT;
	
	COMPONENT Forward_Unit
	 PORT (  
		EX_MEM_RegWrite : in  STD_LOGIC;
		MEM_WB_RegWrite : in  STD_LOGIC;
		DecExecMem : in  STD_LOGIC;
		EX_MEM_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
		DecExecRs : in  STD_LOGIC_VECTOR (4 downto 0);
		DecExMemRd : in  STD_LOGIC_VECTOR (4 downto 0);  
		DecExecRt : in  STD_LOGIC_VECTOR (4 downto 0);
		MEM_WB_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
		ForwardA : out  STD_LOGIC_VECTOR (1 downto 0);
		ForwardB : out  STD_LOGIC_VECTOR (1 downto 0));
	END COMPONENT;

	COMPONENT Stall_Unit 
	 PORT (  
		clk : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		DecExMemReadEn : in  STD_LOGIC;
		DecExMemRd : in  STD_LOGIC_VECTOR (4 downto 0);
		InsDecRs : in  STD_LOGIC_VECTOR (4 downto 0);
		InsDecRt : in  STD_LOGIC_VECTOR (4 downto 0);
		Pc_LdEn : out  STD_LOGIC;
		Instr_Reg_En : out  STD_LOGIC);
	END COMPONENT;
	

signal instr_sig, RF_A_sig, RF_B_sig, immed_sig, ALU_out_sig, MEM_out_sig: STD_LOGIC_VECTOR(31 downto 0);
signal cout_sig, Ovf_sig: STD_LOGIC;
signal instruction_register_out_sig, rf_b_register_out_sig, alu_register_out_sig, memory_register_out_sig: STD_LOGIC_VECTOR(31 downto 0);

-- exec_mem_rf_b_out
signal Pc_LdEn_stall_sig, Get_instr_En_stall_sig: STD_LOGIC;
signal dec_exec_register_out_sig, exec_mem_register_out_sig, mem_wb_register_out_sig, dec_exec_rf_a_sig, dec_exec_rf_b_sig, dec_exec_immed_sig, exec_mem_alu_out, mux_RF_A_out, mux_RF_B_out, dec_write_data_sig: STD_LOGIC_VECTOR(31 downto 0);
signal DecExWB_sig, DecExRF_Wr_DataSel_sig, DecExMemReadEn_sig, DecExMEM_sig, DecExEX_sig, ExecMemWB_sig, ExecMemRF_Wr_DataSel_sig, ExecMemMEM_ReadEn_sig, ExecMemMEM_sig, MemWrBWB_sig, MemWrBRF_Wr_DataSel_sig: STD_LOGIC;
signal DecExRs_sig, DecExRd_sig, DecExRt_sig, ExecMemRd_sig, MemWrBRd_sig : STD_LOGIC_VECTOR(4 downto 0);
signal forwardA_sig, forwardB_sig : STD_LOGIC_VECTOR(1 downto 0);

begin

	initalize_signals :process(dec_exec_register_out_sig, exec_mem_register_out_sig, mem_wb_register_out_sig,DecExWB_sig, DecExRF_Wr_DataSel_sig, DecExMemReadEn_sig, DecExMEM_sig, DecExEX_sig, ExecMemWB_sig, ExecMemRF_Wr_DataSel_sig, ExecMemMEM_ReadEn_sig, ExecMemMEM_sig, MemWrBWB_sig, MemWrBRF_Wr_DataSel_sig,DecExRs_sig, DecExRd_sig, DecExRt_sig, ExecMemRd_sig, MemWrBRd_sig)
   begin
		DecExRs_sig <= dec_exec_register_out_sig(19 downto 15);
		DecExRd_sig <= dec_exec_register_out_sig(14 downto 10);
		DecExRt_sig <= dec_exec_register_out_sig(9 downto 5);
		DecExWB_sig <= dec_exec_register_out_sig(4);
		DecExRF_Wr_DataSel_sig <= dec_exec_register_out_sig(3);
		DecExMemReadEn_sig <= dec_exec_register_out_sig(2);
		DecExMEM_sig <= dec_exec_register_out_sig(1);
		DecExEX_sig <= dec_exec_register_out_sig(0);
		
		ExecMemRd_sig <= exec_mem_register_out_sig(8 downto 4);
		ExecMemWB_sig <= exec_mem_register_out_sig(3);
		ExecMemRF_Wr_DataSel_sig <= exec_mem_register_out_sig(2);
		ExecMemMEM_ReadEn_sig <= exec_mem_register_out_sig(1);
		ExecMemMEM_sig <= exec_mem_register_out_sig(0);
		
		MemWrBRd_sig <= mem_wb_register_out_sig(6 downto 2);
		MemWrBWB_sig <= mem_wb_register_out_sig(1);
		MemWrBRF_Wr_DataSel_sig <= mem_wb_register_out_sig(0);
   end process;
	
	
	stalling_unit : Stall_Unit 
	port map(  
			clk => Clk,
			Reset => Reset,
			DecExMemReadEn => DecExMemReadEn_sig,
			DecExMemRd => DecExRd_sig,
			InsDecRs => instruction_register_out_sig(25 downto 21),
			InsDecRt => instruction_register_out_sig(15 downto 11),
			Pc_LdEn => Pc_LdEn_stall_sig,
			Instr_Reg_En => Get_instr_En_stall_sig
	);
		
	if_stage : IFSTAGE
	port map (
			PC_Immed => dec_exec_immed_sig,
         PC_sel => '0',
         PC_LdEn => Pc_LdEn_stall_sig,
         Reset => Reset,
         Clk => Clk,
         Instr => instr_sig
	);
	
	InsDec_register : Regi
	port map (
		clk => Clk,
		rst => Reset,
      Data => instr_sig,
      WE => Get_instr_En_stall_sig,
		Dout => instruction_register_out_sig
	);
	
	dec_stage : DECSTAGE
	port map (
			Instr => instruction_register_out_sig,
         RF_WrEn => MemWrBWB_sig,
         ALU_out => alu_register_out_sig,
         MEM_out => memory_register_out_sig,
         RF_WrData_sel => MemWrBRF_Wr_DataSel_sig,
			WB_rd => MemWrBRd_sig,
         RF_B_sel => RF_B_sel,
         Clk => Clk,
         Reset => Reset,
         Immed => immed_sig,
         RF_A => RF_A_sig,
         RF_B => RF_B_sig,
			wrData => dec_write_data_sig
	);
	
	DecExec_register : DecExecRegister
	port map ( 
			  clk => Clk,
           rst => Reset,
			  WB => RF_WrEn,
			  RF_WrData_sel => RF_WrData_sel,
			  MEM_ReadEn => Mem_REn,
			  MEM => Mem_WrEn,
			  EX => ALU_Bin_sel,
			  Rt => instruction_register_out_sig(15 downto 11),
			  Rd => instruction_register_out_sig(20 downto 16),
			  Rs => instruction_register_out_sig(25 downto 21),
			  RF_A_in => RF_A_sig,
			  RF_B_in => RF_B_sig,
			  Immed_in => immed_sig,
			  signal_register_out => dec_exec_register_out_sig,
			  RF_A_out => dec_exec_rf_a_sig,
			  RF_B_out => dec_exec_rf_b_sig,
			  Immed_out => dec_exec_immed_sig
	 );
	
	mux_RF_A : Mux4_1
	port map(  
		din1 => dec_exec_rf_a_sig,
		din2 => dec_write_data_sig,
		din3 => exec_mem_alu_out,
		din4 => "00000000000000000000000000000000",
		sel => forwardA_sig,
		dout => mux_RF_A_out
	);

	mux_RF_B : Mux4_1
	port map(  
		din1 => dec_exec_rf_b_sig,
		din2 => dec_write_data_sig,
		din3 => exec_mem_alu_out,
		din4 => alu_register_out_sig,
		sel => forwardB_sig, 
		dout => mux_RF_B_out
	);
	
	exec_stage : EXECSTAGE
	port map (
			RF_A => mux_RF_A_out,
         RF_B => mux_RF_B_out,
         Immed => dec_exec_immed_sig,
         ALU_Bin_sel => DecExEX_sig,
         ALU_func => "0000",
         ALU_out => ALU_out_sig,
			Zero => Zero,
			Cout => cout_sig,
			Ovf => Ovf_sig
	);
	
	ExecMem_register : ExecMemRegister 
	port map (
			clk => Clk,
			rst => Reset,
			RF_WrData_sel => DecExRF_Wr_DataSel_sig,
			WB => DecExWB_sig,
			MEM_ReadEn => DecExMemReadEn_sig,
			MEM => DecExMEM_sig,
			Rd => DecExRd_sig,
			ALU_OUT_in => ALU_out_sig, 
			ALU_OUT_out => exec_mem_alu_out,
			RF_B_in => mux_RF_B_out,
			RF_B_out => rf_b_register_out_sig,
			signal_register_out => exec_mem_register_out_sig
	);
	
	mem_stage : MEMSTAGE
	port map (
			CLK => Clk,
         MEM_WrEn => ExecMemMEM_sig,
         ALU_MEM_Addr => exec_mem_alu_out,
         MEM_DataIn => rf_b_register_out_sig,
         MEM_DataOut => MEM_out_sig,
			Memory_operation => Memory_operation 
	);
	
	MemWriteBack_register : MemWriteBackRegister
	port map( 
			clk => clk,
			rst => Reset,
			RF_WrData_sel => ExecMemRF_Wr_DataSel_sig,
			WB => ExecMemWB_sig,
			Rd => ExecMemRd_sig,
			ALU_OUT_in => exec_mem_alu_out,
			ALU_OUT_out => alu_register_out_sig,
			MEM_OUT_in => MEM_out_sig,
			MEM_OUT_out => memory_register_out_sig,
			signal_register_out => mem_wb_register_out_sig
	);
	
	forwarding_unit :	Forward_Unit
	port map(  
			EX_MEM_RegWrite => ExecMemWB_sig,
			MEM_WB_RegWrite => MemWrBWB_sig,
			DecExecMem => DecExMEM_sig,
			EX_MEM_Rd => ExecMemRd_sig,
			DecExecRs => DecExRs_sig,
			DecExMemRd => DecExRd_sig,
			DecExecRt => DecExRt_sig,
			MEM_WB_Rd => MemWrBRd_sig,
			ForwardA => forwardA_sig,
			ForwardB => forwardB_sig
	);

	Instr <= instruction_register_out_sig;

end Behavioral;

