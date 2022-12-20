PACKAGE Constants IS 
-- globals 
CONSTANT length : NATURAL := 32; 
CONSTANT half   : NATURAL := 16;
-- definitions for regfile 
CONSTANT depth: positive := 32; -- register file depth = 2**adrsize 
CONSTANT adrSize : positive := 5; -- address vector size = log2(depth) 
CONSTANT memsize : positive := 128; --size of rom memory
CONSTANT oplength : positive :=6; -- size of op code 
END Constants; 