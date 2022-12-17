library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_FILE_UNIT is
    Port (  Clk         : in std_logic;
            Enable      : in std_logic;
            RegWrite    : in std_logic;
            ReadAddr1   : in std_logic_vector(adrSize-1 downto 0);
            ReadAddr2   : in std_logic_vector(adrSize-1 downto 0);
            WriteAddr   : in std_logic_vector(adrSize-1 downto 0);
            WriteData   : in std_logic_vector(length-1 downto 0);
            ReadData1   : out std_logic_vector(length-1 downto 0);
            ReadData2   : out std_logic_vector(length-1 downto 0));
end REG_FILE_UNIT;

architecture Behavioral of REG_FILE_UNIT is
type memory is array(depth-1 to 0) of STD_LOGIC_VECTOR(length-1 downto 0);  --Memory type 32 array of 32 bits vectors
signal regFile : memory := (others => X"0000");                             --Memory signal
begin
    regFile(0)<=(others=>'0');      --Register 0 is always 0
    --register write process
    process(clk,RegWrite,Enable)			
    begin
        if falling_edge(clk) then   -- Falling edge for structural hazard
            if Enable='1' and regWrite = '1' then
                regFile(to_integer(unsigned(WriteAddr))) <=WriteData ;      --Write data at location from write address
            end if;
        end if;
    end process;
    
    --Exit signals
    ReadData1 <= regFile(to_integer(unsigned(ReadAddr1)));      -- rs
    ReadData2 <= regFile(to_integer(unsigned(ReadAddr1)));      -- rt
  
end Behavioral;
