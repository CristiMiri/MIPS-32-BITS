library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;

entity PC_UNIT is
    Port ( Clk      : in STD_LOGIC;
           Enable   : in STD_LOGIC;
           Reset    : in STD_LOGIC;
           PcIn     : in STD_LOGIC_VECTOR (length-1 downto 0);
           PcOut    : out STD_LOGIC_VECTOR (length-1 downto 0));
end PC_UNIT;

architecture Behavioral of PC_UNIT is

begin
process(clk,enable,reset,pcIn)
begin
    if rising_edge(clk) then
        if enable='1' then
            PcOut <=PcIn;
        end if;
    elsif reset='1' then
        PcOut <=(others =>'0');
    end if;
end process;
end Behavioral;
