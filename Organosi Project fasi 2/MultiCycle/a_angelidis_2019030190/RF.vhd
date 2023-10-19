----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:29 03/13/2023 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Structural of RF is

COMPONENT Decoder
    PORT(
         input : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
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
    
COMPONENT Mux32to1
    PORT(
         din0 : IN  std_logic_vector(31 downto 0);
         din1 : IN  std_logic_vector(31 downto 0);
         din2 : IN  std_logic_vector(31 downto 0);
         din3 : IN  std_logic_vector(31 downto 0);
         din4 : IN  std_logic_vector(31 downto 0);
         din5 : IN  std_logic_vector(31 downto 0);
         din6 : IN  std_logic_vector(31 downto 0);
         din7 : IN  std_logic_vector(31 downto 0);
         din8 : IN  std_logic_vector(31 downto 0);
         din9 : IN  std_logic_vector(31 downto 0);
         din10 : IN  std_logic_vector(31 downto 0);
         din11 : IN  std_logic_vector(31 downto 0);
         din12 : IN  std_logic_vector(31 downto 0);
         din13 : IN  std_logic_vector(31 downto 0);
         din14 : IN  std_logic_vector(31 downto 0);
         din15 : IN  std_logic_vector(31 downto 0);
         din16 : IN  std_logic_vector(31 downto 0);
         din17 : IN  std_logic_vector(31 downto 0);
         din18 : IN  std_logic_vector(31 downto 0);
         din19 : IN  std_logic_vector(31 downto 0);
         din20 : IN  std_logic_vector(31 downto 0);
         din21 : IN  std_logic_vector(31 downto 0);
         din22 : IN  std_logic_vector(31 downto 0);
         din23 : IN  std_logic_vector(31 downto 0);
         din24 : IN  std_logic_vector(31 downto 0);
         din25 : IN  std_logic_vector(31 downto 0);
         din26 : IN  std_logic_vector(31 downto 0);
         din27 : IN  std_logic_vector(31 downto 0);
         din28 : IN  std_logic_vector(31 downto 0);
         din29 : IN  std_logic_vector(31 downto 0);
         din30 : IN  std_logic_vector(31 downto 0);
         din31 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(4 downto 0);
         dout : OUT  std_logic_vector(31 downto 0)
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
	
COMPONENT Comparator
    PORT ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           equal : out  STD_LOGIC);
	 END COMPONENT;

-- SIGNALS
signal dec_out_sig, register_we, mux32_out_sig1, mux32_out_sig2: STD_LOGIC_VECTOR(31 downto 0);
signal equal_sig_1, equal_sig_2, sel1, sel2: STD_LOGIC;
-- Declare an array of 32-bit vectors with 32 elements
type vector_array_t is array (0 to 31) of std_logic_vector(31 downto 0);
signal register_out_array : vector_array_t;

begin
	dec : Decoder
	port map (
		input => Awr,
      output => dec_out_sig
	);
	
	comp1 : Comparator
   port map ( 
		Awr => Awr,
      Ard => Ard1,
      equal => equal_sig_1
	);
	
	comp2 : Comparator
   port map ( 
		Awr => Awr,
      Ard => Ard2,
      equal => equal_sig_2
	);
	
	registers_we_generator: for i in 0 to 31 generate
		register_we(i) <= dec_out_sig(i) AND WrEn;
	end generate;
	
	register_0 : Regi
	port map (
			clk => Clk,
			rst => '1',
			Data => x"0000_0000",
			WE => register_we(0),
			Dout => register_out_array(0)
	);
	
	registers : for i in 1 to 31 generate
		reg : Regi
		port map (
			clk => Clk,
			rst => rst,
			Data => Din,
			WE => register_we(i),
			Dout => register_out_array(i)
		);
	end generate;

	mux32_1 : Mux32to1 
	port map (
			din0 => register_out_array(0),
         din1 => register_out_array(1),
         din2 => register_out_array(2),
         din3 => register_out_array(3),
         din4 => register_out_array(4),
         din5 => register_out_array(5),
         din6 => register_out_array(6),
         din7 => register_out_array(7),
         din8 => register_out_array(8),
         din9 => register_out_array(9),
         din10 => register_out_array(10),
         din11 => register_out_array(11),
         din12 => register_out_array(12),
         din13 => register_out_array(13),
         din14 => register_out_array(14),
         din15 => register_out_array(15),
         din16 => register_out_array(16),
         din17 => register_out_array(17),
         din18 => register_out_array(18),
         din19 => register_out_array(19),
         din20 => register_out_array(20),
         din21 => register_out_array(21),
         din22 => register_out_array(22),
         din23 => register_out_array(23),
         din24 => register_out_array(24),
         din25 => register_out_array(25),
         din26 => register_out_array(26),
         din27 => register_out_array(27),
         din28 => register_out_array(28),
         din29 => register_out_array(29),
         din30 => register_out_array(30),
         din31 => register_out_array(31),
         sel => Ard1,
         dout => mux32_out_sig1
	);
	
	mux32_2 : Mux32to1 
	port map (
			din0 => register_out_array(0),
         din1 => register_out_array(1),
         din2 => register_out_array(2),
         din3 => register_out_array(3),
         din4 => register_out_array(4),
         din5 => register_out_array(5),
         din6 => register_out_array(6),
         din7 => register_out_array(7),
         din8 => register_out_array(8),
         din9 => register_out_array(9),
         din10 => register_out_array(10),
         din11 => register_out_array(11),
         din12 => register_out_array(12),
         din13 => register_out_array(13),
         din14 => register_out_array(14),
         din15 => register_out_array(15),
         din16 => register_out_array(16),
         din17 => register_out_array(17),
         din18 => register_out_array(18),
         din19 => register_out_array(19),
         din20 => register_out_array(20),
         din21 => register_out_array(21),
         din22 => register_out_array(22),
         din23 => register_out_array(23),
         din24 => register_out_array(24),
         din25 => register_out_array(25),
         din26 => register_out_array(26),
         din27 => register_out_array(27),
         din28 => register_out_array(28),
         din29 => register_out_array(29),
         din30 => register_out_array(30),
         din31 => register_out_array(31),
         sel => Ard2,
         dout => mux32_out_sig2
	);

sel1 <= equal_sig_1 AND WrEn;
sel2 <= equal_sig_2 AND WrEn;
	
	mux2_1 : Mux2to1
	port map(
			din1 => mux32_out_sig1,
         din2 => Din,
         sel => sel1,
         dout => Dout1
	);
	
	mux2_2 : Mux2to1
	port map(
			din1 => mux32_out_sig2,
         din2 => Din,
         sel => sel2,
         dout => Dout2
	);
	
end Structural;

