library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;


entity MEM_WB_UNIT is
    Port(   Clk         : in std_logic; 
            Reset       : in std_logic; 
            Enable      : in std_logic;
            WriteAddr   : in std_logic_vector(adrSize-1 downto 0);
            MemData     : in std_logic_vector(length-1 downto 0); 
            MEMAddr     : in std_logic_vector(length-1 downto 0); 
            zero        : in std_logic;
            BranchAddr  : in std_logic_vector(length-1 downto 0); 
            Branch      : in std_logic;
            MemWrite    : in std_logic;
            MemRead     : in std_logic;
            RegWriteIn  : in std_logic;
            MemtoReg    : in std_logic;
            ReadData    : out std_logic_vector(length-1 downto 0); 
            AluRes      : out std_logic_vector(length-1 downto 0);
            WriteAddrReg: out std_logic_vector(adrSize-1 downto 0);
            MemtoRegReg : out std_logic;
            RegWrite    : out std_logic;
            PcSrc       : out std_logic   
);
end MEM_WB_UNIT;

architecture Behavioral of MEM_WB_UNIT is
signal ReadDataReg  : std_logic_vector(length-1 downto 0); 
begin
MEMORY: entity work.DATA_MEM_UNIT port map( Clk=>       CLK,      
                                            Enable=>    Enable,   
                                            Reset=>     RESET,    
                                            Addr=>      MEMAddr,
                                            WriteData=> MemData,
                                            MemRead=>   MemRead,  
                                            MemWrite=>  MemWrite,
                                            ReadData=>  ReadDataReg);

PcSrc <=Branch and Zero;
--Pipeline register
process(clk,reset,enable)
begin
    if reset='1' then
        ReadData<=      (others=>'0');    
        AluRes<=        (others=>'0');      
        WriteAddrReg<=  (others=>'0');
        MemtoRegReg<=   '0'; 
        RegWrite<=      '0';                                                                
    elsif rising_edge(clk) then
        if enable='1' then
            ReadData<=      ReadDataReg;      
            AluRes<=        WriteAddr;
            WriteAddrReg<=  WriteAddr;
            MemtoRegReg<=   MemtoReg;
            RegWrite<=      RegWriteIn;                                    
        end if;
    end if;
end process;

end Behavioral;
