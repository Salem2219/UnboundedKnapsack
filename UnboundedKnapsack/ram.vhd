library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, wr : in std_logic;
i, wt, val, w : in std_logic_vector(7 downto 0);
y : out std_logic_vector(15 downto 0));
end ram;
architecture rtl of ram is
component adder16 is
    port (a : std_logic_vector(7 downto 0);
     b : in std_logic_vector(15 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
component sub8 is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component max is
    port (a, b : std_logic_vector(15 downto 0);
    y : out std_logic_vector (15 downto 0));
end component;
type ram_type is array (0 to 255) of
std_logic_vector(15 downto 0);
signal program: ram_type := (others => (others => '0'));
signal iminuswt : std_logic_vector(7 downto 0);
signal dp1, dp2, dp3, dp4 : std_logic_vector(15 downto 0);
begin
dp1 <= program(conv_integer(unsigned(i)));
u1 : sub8 port map (i, wt, iminuswt);
dp2 <= program(conv_integer(unsigned(iminuswt)));
u2 : adder16 port map (val, dp2, dp3);
u3 : max port map (dp1, dp3, dp4);
process(clk)
begin
if (rising_edge(clk)) then
if (wr = '1') then
program(conv_integer(unsigned(i))) <= dp4;
end if;
end if;
end process;
y <= program(conv_integer(unsigned(w)));
end rtl;