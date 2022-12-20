library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.Constants.ALL;

entity ALU_CONTROL_UNIT is
    Port ( FUNCT    : in STD_LOGIC_VECTOR (oplength-1 downto 0);
           ALUOP    : in STD_LOGIC_VECTOR (2 downto 0);
           ALUCTRL  : out STD_LOGIC_VECTOR (3 downto 0));
end ALU_CONTROL_UNIT;

architecture Behavioral of ALU_CONTROL_UNIT is

begin
process(Funct,AluOp)
begin
    case AluOp is 
        when "000"   => case Funct is
                            when "000-000" => AluCtrl <="0000";
                            when "000-001" => AluCtrl <="0001";
                            when "000-010" => AluCtrl <="0010";
                            when "000-011" => AluCtrl <="0011";
                            when "000-100" => AluCtrl <="0100";
                            when "000-101" => AluCtrl <="0101";
                            when "000-110" => AluCtrl <="0110";
                            when "000-111" => AluCtrl <="0111";
                            when "001-000" => AluCtrl <="1000";
                            when "001-001" => AluCtrl <="1001";
                        end case;
        when "001"   => AluCtrl <="0000";
        when "010"   => AluCtrl <="0001";
        when "011"   => AluCtrl <="1011";
        when "100"   => AluCtrl <="1010";
        when others  => AluCtrl <="0000";
    end case;
end process;
end Behavioral;
