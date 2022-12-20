library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;


entity ID_EX_UNIT is
    Port(   Clk         : in std_logic; 
            Reset       : in std_logic; 
            Enable      : in std_logic; 
            RegWrite    : in std_logic; 
            Instr       : in std_logic_vector(length-1 downto 0);
            PC4         : in std_logic_vector(length-1 downto 0);
            WriteAddr   : in std_logic_vector(adrSize-1 downto 0);
            Writedata   : in std_logic_vector(length-1 downto 0);
            JumpAddres  : out std_logic_vector(length-1 downto 0);
            RegDst      : out std_logic;  
            RegWriteOut : out std_logic;
            Branch      : out std_logic;
            jump        : out std_logic;
            AluSRC      : out std_logic;
            Memwrite    : out std_logic;
            MemtoReg    : out std_logic;
            MemRead     : out std_logic;
            AluOp       : out std_logic_vector(2 downto 0);
            Pc4Reg      : out std_logic_vector(length-1 downto 0);
            ArgA        : out std_logic_vector(length-1 downto 0);
            ArgB        : out std_logic_vector(length-1 downto 0);
            Imm         : out std_logic_vector(length-1 downto 0);
            Funct       : out std_logic_vector(oplength-1 downto 0);
            RegAdrRs    : out std_logic_vector(adrSize-1 downto 0);
            RegAdrRt    : out std_logic_vector(adrSize-1 downto 0)
);
end ID_EX_UNIT;

architecture Behavioral of ID_EX_UNIT is
signal A,B,Immediate : std_logic_vector(length-1 downto 0);
signal RegDstReg,RegWriteReg,BranchReg,MemWriteReg,MemtoRegReg,AluSrcReg,MemReadReg :std_logic;
signal AluOpReg   : std_logic_vector(2 downto 0);
begin

--Register File
RegFile: entity work.REG_FILE_UNIT port map (   Clk=>       clk,      
                                                Enable=>    enable,
                                                Reset=>     reset,    
                                                RegWrite=>  RegWrite, 
                                                ReadAddr1=> Instr(25 downto 21),
                                                ReadAddr2=> Instr(20 downto 16),
                                                WriteAddr=> WriteAddr,
                                                WriteData=> WriteData,
                                                ReadData1=> A, 
                                                ReadData2=> B);
--Sign Extend
SignExt: entity work.SIGN_EXT_UNIT port map (   ExtIn=> Instr(half-1 downto 0),     
                                                ExtOut=>Immediate);
--Control Unit
Control: entity work.CONTROL_UNIT port map  (   Instruction=>   Instr(length-1 downto 26),
                                                RegDst=>        RegDstReg,      
                                                RegWrite=>      RegWriteReg,
                                                Branch=>        BranchReg,     
                                                Jump=>          Jump,       
                                                ALUSrc=>        AluSrcReg,     
                                                ALUOp=>         AluOpReg,      
                                                MemWrite=>      MemWriteReg,
                                                MemRead=>       MemReadReg,   
                                                MemtoReg=>      MemtoRegReg); 

--JumpAddres calculation
JumpAddres<=Pc4(length-1 downto 28) & (Instr(25 downto 0) & "00");

--PipeLine Register                                                
process(clk,reset,enable)
begin
    if reset='1' then
        RegAdrRs<=  (others=>'0');
        RegAdrRt<=  (others=>'0');
        Funct<=     (others=>'0');
        Imm<=       (others=>'0');
        ArgA<=      (others=>'0');
        ArgB<=      (others=>'0');
        ArgB<=      (others=>'0');
        PC4Reg<=    (others=>'0');
        RegDst<=    '0';
        MemRead<=   '0';  
        RegWriteOut<='0';
        Branch<=    '0';  
        jump<=      '0';    
        AluSRC<=    '0';
        Memwrite<=  '0';
        MemtoReg<=  '0';
        AluOp<=     "000";   
    elsif rising_edge(clk) then
        if enable='1' then
            RegAdrRt<=      Instr(15 downto 11);
            RegAdrRs<=      Instr(20 downto 16);
            Funct<=         Instr(5 downto 0);
            Imm<=           Immediate;
            ArgA<=          A;
            ArgB<=          B;
            Pc4Reg<=        Pc4;
            RegDst<=        RegDstReg;  
            RegWriteOut<=   RegWriteReg;
            Branch<=        BranchReg;           
            AluSRC<=        AluSrcReg;  
            Memwrite<=      MemWriteReg;   
            MemtoReg<=      MemtoRegReg;
            AluOp<=         AluOpReg;
            MemRead<=       MemReadReg;
        end if;
end if;
end process;
end Behavioral;
