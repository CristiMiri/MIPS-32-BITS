library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;
use IEEE.NUMERIC_STD.ALL;
entity DATA_MEM_UNIT is
    Port (  Clk         : in std_logic;
            Enable      : in std_logic;
            Reset       : in std_logic;
            Addr        : in std_logic_vector(length-1 downto 0);
            WriteData   : in std_logic_vector(length-1 downto 0);
            MemRead     : in std_logic;
            MemWrite    : in std_logic;
            ReadData    : out std_logic_vector(length-1 downto 0)
  );
end DATA_MEM_UNIT;

architecture Behavioral of DATA_MEM_UNIT is
type memory is array(depth -1 downto 0) of STD_LOGIC_VECTOR(length-1 downto 0);  --Memory type 32 array of 32 bits vectors
signal RAM :memory :=(
    std_logic_vector(to_unsigned(1, length)),
    std_logic_vector(to_unsigned(4, length)),
    std_logic_vector(to_unsigned(8, length)),
    others=> (others =>'0'));

begin
process(clk,enable,reset,writeData,addr,memread,memwrite)
begin
    if rising_edge(clk) then 
        if enable='1' and MemWrite='1' then
             Ram(to_integer(unsigned(Addr))) <=WriteData ; 
        elsif enable='1' and MemRead='1' then
            ReadData <= Ram(to_integer(unsigned(Addr)));
        end if;
    elsif reset='1' then
        Ram<= (others=> (others=>'0'));
    end if;
end process;

end Behavioral;
