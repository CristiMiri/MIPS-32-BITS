PACKAGE Constants IS 
-- globals 
CONSTANT length : NATURAL := 32; 
-- definitions for regfile 
CONSTANT depth: positive := 32; -- register file depth = 2**adrsize 
CONSTANT adrSize : positive := 5; -- address vector size = log2(depth) 
END Constants; 