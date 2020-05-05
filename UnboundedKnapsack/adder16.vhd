library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity adder16 is
    port (a : std_logic_vector(7 downto 0);
     b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end adder16;

architecture rtl of adder16 is
signal y_uns : unsigned(15 downto 0);
begin
y_uns <= unsigned(a) + unsigned(b);
y <= std_logic_vector(y_uns);
end rtl;
