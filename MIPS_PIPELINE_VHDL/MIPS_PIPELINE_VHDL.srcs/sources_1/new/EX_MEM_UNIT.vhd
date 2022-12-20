library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_Unsigned.all;
USE work.Constants.ALL;


entity EX_MEM_UNIT is
    Port(   Clk        : in std_logic; 
            Reset      : in std_logic; 
            Enable     : in std_logic;
            ArgA       : in std_logic_vector(length-1 downto 0); 
            ArgB       : in std_logic_vector(length-1 downto 0);
            Imm        : in std_logic_vector(length-1 downto 0);
            PC4        : in std_logic_vector(length-1 downto 0);
            Funct      : in std_logic_vector(oplength-1 downto 0);
            RsAdr      : in std_logic_vector(adrSize-1 downto 0); 
            RtAdr      : in std_logic_vector(adrSize-1 downto 0);
            BranchIn   : in std_logic;
            MemReadIn  : in std_logic;
            MemWriteIn : in std_logic;
            MemtoRegIn : in std_logic;
            RegWriteIn : in std_logic;
            AluOp      : in std_logic_vector(2 downto 0);
            AluSrc     : in std_logic;          
            RegDst     : in std_logic;          
            Zero       : out std_logic;
            BranchAddr : out std_logic_vector(length-1 downto 0);
            Result     : out std_logic_vector(length-1 downto 0);
            WriteAddr  : out std_logic_vector(adrSize-1 downto 0);
            MemData    : out std_logic_vector(length-1 downto 0);
            MemWrite   : out std_logic;
            Branch     : out std_logic;
            MemRead    : out std_logic;
            MemtoReg   : out std_logic;
            RegWrite   : out std_logic        
);
end EX_MEM_UNIT;

architecture Behavioral of EX_MEM_UNIT is
signal AluCtrl          : STD_LOGIC_VECTOR (3 downto 0);
signal WriteAddrReg     : std_logic_vector(adrSize-1 downto 0);
signal AluRes           : std_logic_vector(length-1 downto 0);
signal BranchAddrReg    : std_logic_vector(length-1 downto 0);
signal Boperand         : std_logic_vector(length-1 downto 0);
signal ZeroReg          : std_logic;
begin
AluControl: entity work.ALU_CONTROL_UNIT port map ( FUNCT=>     Funct,
                                                    ALUOP=>     AluOp,  
                                                    ALUCTRL=>   AluCtrl);
                                                    
Alu: entity work.ALU_UNIT port map (    ArgA=>      ArgA,
                                        ArgB=>      Boperand,   
                                        AluCtrl=>   AluCtrl,
                                        AluRes=>    AluRes,
                                        Zero=>      ZeroReg);   
with AluSrc select
    WriteAddrReg<= RsAdr when '0',
                RtAdr when '1',
                (others=>'0') when others;
with RegDst select
    Boperand<=  ArgB when '0',
                Imm when '1',
                (others=>'0') when others;
--Branch Address Calculation
BranchAddrReg<=PC4 + (Imm(29 downto 0 )& "00");

--Pipeline register
process(clk,reset,enable)
begin
    if reset='1' then
        WriteAddr<=     (others=>'0');
        MemData<=       (others=>'0');
        Result<=        (others=>'0');
        Zero<=          '0';
        BranchAddr<=    (others=>'0');
        Branch<=        '0';
        MemWrite<=      '0';
        RegWrite<=      '0';  
        MemtoReg<=      '0';
        MemRead<=       '0';                   
    elsif rising_edge(clk) then
        if enable='1' then
            WriteAddr<=     WriteAddrReg;   
            MemData<=       Imm;
            Result<=        AluRes;
            Zero<=          ZeroReg;
            BranchAddr<=    BranchAddrReg;
            Branch<=        BranchIn;
            MemWrite<=      MemWriteIn;
            RegWrite<=      RegWriteIn;
            MemRead<=       MemReadIN;           
            MemtoReg<=      MemtoRegIn;
        end if;
    end if;
end process;
end Behavioral;
