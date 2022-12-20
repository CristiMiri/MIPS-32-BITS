library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
USE work.Constants.ALL;


entity ALU_UNIT is
    Port ( ArgA      : in STD_LOGIC_VECTOR (length-1 downto 0);
           ArgB      : in STD_LOGIC_VECTOR (length-1 downto 0);
           AluCtrl   : in STD_LOGIC_VECTOR (3 downto 0);
           AluRes    : out STD_LOGIC_VECTOR (length-1 downto 0);
           Zero      : out STD_LOGIC);
end ALU_UNIT;

architecture Behavioral of ALU_UNIT is
signal Result   : std_logic_vector(length-1 downto 0);
signal IntA,IntB : Integer; --variables for working with operands
begin
IntA<=to_integer(unsigned(ArgA));
IntB<=to_integer(unsigned(ArgB));

process(argA,argB,AluCtrl)      --process for functionality
begin
    case AluCtrl is 
        when "0000" =>  Result <= std_logic_vector(to_unsigned(IntA+IntB,length));      --add 0000
        when "0001" =>  Result <= std_logic_vector(to_unsigned(IntA-IntB,length));      --sub 0001
        when "0010" =>  Result <= std_logic_vector(to_unsigned(IntA*IntB,length));      --mul 0010
        when "0011" =>  Result <= std_logic_vector(to_unsigned(IntA/IntB,length));      --div 0011
        when "0100" =>  Result <= ArgA and ArgB;                                        --and 0100     
        when "0101" =>  Result <= ArgA or  ArgB;                                        --or  0101
        when "0110" =>  Result <= ArgA xor ArgB;                                        --xor 0110
        when "0111" =>  Result <= std_logic_vector(unsigned(ArgA) sll IntB);            --sll 0111
        when "0111" =>  Result <= std_logic_vector(unsigned(ArgA) srl IntB);            --srl 1000
        when "0111" =>  Result <= std_logic_vector(to_unsigned(IntA mod IntB,length));  --mod 1001
    end case;
    
    if Result=std_logic_vector(to_unsigned(0,length)) then --Zero is '1' if result from sub is 0 so branch
        Zero <= '1';
    else
        Zero <= '0';
    end if;
end process;
    AluRes <= Result;
    
end Behavioral;
