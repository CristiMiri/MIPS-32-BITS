library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;
use IEEE.NUMERIC_STD.ALL;

entity INSTRUC_MEM_UNIT is
    Port (  Address :   in std_logic_vector(length-1 downto 0);     --Addres of instruction from Memory
            Instruc :   out std_logic_vector(length-1 downto 0));   --Instruction from Memory 32 bits 
end INSTRUC_MEM_UNIT;

architecture Behavioral of INSTRUC_MEM_UNIT is
type Memory is array (0 to 128) of std_logic_vector(length-1 downto 0);
signal ROM : Memory := (others => (others => '0'));
begin

    Instruc <= ROM(to_integer(unsigned(Address)));      --Read instruction from Memory from address provided         

end Behavioral;
