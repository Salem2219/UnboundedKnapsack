library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity val_rom is
port(addr: in std_logic_vector (3 downto 0);
data: out std_logic_vector (7 downto 0));
end val_rom;
architecture rtl of val_rom is
type rom_type is array (0 to 15) of
std_logic_vector (7 downto 0);
constant program : rom_type := (
"00001010", -- sample contents
"00011110",
"00010100",
"11000011",
"11101110",
"10011111",
"11111110",
"11110101",
"10010000",
"10000000",
"11101000",
"10001111",
"10100000",
"10000000",
"01111000",
"00000000");
begin
data <= program(conv_integer(unsigned(addr)));
end rtl;
