library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IF_ID_UNIT is
    Port (  CLK         : in std_logic;
            Enable      : in std_logic;
            Reset       : in std_logic;
            PcSRC       : in std_logic;
            Jump        : in std_logic;
            JumpAddr    : in std_logic_vector(length-1 downto 0);
            BranchAddr  : in std_logic_vector(length-1 downto 0);
            PC4         : out std_logic_vector(length-1 downto 0); 
            Instr       : out std_logic_vector(length-1 downto 0) 
);
end IF_ID_UNIT;

architecture Behavioral of IF_ID_UNIT is
signal PcIn     : std_logic_vector(length-1 downto 0);
signal PCnext   : std_logic_vector(length-1 downto 0);
signal PcOut    : std_logic_vector(length-1 downto 0);
signal InstrReg : std_logic_vector(length-1 downto 0);
signal PC4Reg   : std_logic_vector(length-1 downto 0);
begin

--Mux for addres select in case of branch or the next consecutive address
with PcSrc select 
    PcNext<=    BranchAddr when '1',
                Pc4Reg  when '0',
                (others=>'0') when others;
            
--Mux for addres select in case of jump or the next consecutive address
with Jump select
    PcIn<=  PcNext when '0',
            JumpAddr when '1',
            (others=>'0') when others;

--Program counter
PC: entity Work.PC_UNIT port map (  Clk=>   clk,   
                                    Enable=>enable,
                                    Reset=> reset, 
                                    PcIn=>  PcIn,  
                                    PcOut=> PcOut); 
--Instruction Memory
Instr_MEM: entity work.INSTRUC_MEM_UNIT port map (  Address=>   PcOut,  
                                                    Instruc=>   InstrReg);
-- +4 Adder for next instruction
PC4Reg <= PcOut + 4;
--Pipeline Register
process(clk,reset,enable,PC4Reg,InstrReg)
begin
    if reset='1' then
        PC4<=   (others=>'0');
        Instr<= (others=>'0');
    elsif rising_edge(clk) then
        if enable='1' then
            Pc4<=   PC4Reg;
            Instr<= InstrReg;
        end if;
    end if;
end process;
end Behavioral;
