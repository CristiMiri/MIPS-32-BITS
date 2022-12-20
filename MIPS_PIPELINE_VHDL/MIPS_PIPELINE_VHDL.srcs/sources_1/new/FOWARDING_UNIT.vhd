library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;

entity FOWARDING_UNIT is
    Port(   RS          : IN std_logic_vector(adrSize-1 downto 0);
            RT          : IN std_logic_vector(adrSize-1 downto 0);
            RDMEM       : IN std_logic_vector(adrSize-1 downto 0);
            RDWB        : IN std_logic_vector(adrSize-1 downto 0);
            RegWriteMem : in std_logic;
            RegWriteWb  : in std_logic;
            FowardA     : out std_logic_vector(1 downto 0)
--            FowardB     : out std_logic_vector(1 downto 0)                       
);
end FOWARDING_UNIT;

architecture Behavioral of FOWARDING_UNIT is

begin
    FowardA(1) <= '0' when (rdmem /= rs) or (RegWriteMem = '0') else '1';
    FowardA(0) <= '0' when (rdwb /= rt) or (RegWriteWb = '0') else '1';    
end Behavioral;
