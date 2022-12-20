library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE work.Constants.ALL;

entity SIGN_EXT_UNIT is
    Port ( ExtIn : in STD_LOGIC_VECTOR (15 downto 0);
           ExtOut : out STD_LOGIC_VECTOR (length-1 downto 0));
end SIGN_EXT_UNIT;

architecture Behavioral of SIGN_EXT_UNIT is

begin
ExtOut(15 downto 0) <=ExtIn; --First half is the same

with ExtIn(15) select
    ExtOut(length-1 downto 16) <=   (others=>'0') when '0',     --Sign extend second half is full of '0' when first bit is '0'
                                    (others=>'1') when '1',     --Sign extend second half is full of '1' when first bit is '1'
                                    (others=>'0') when others;
                                    
end Behavioral;
