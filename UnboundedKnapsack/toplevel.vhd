library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, start : in std_logic;
    w, n, val, wt: in std_logic_vector(7 downto 0);
    val_addr, wt_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
     port (clk, rst, wr, i_ld, j_ld, sel : in std_logic;
    w, n, val, wt : in std_logic_vector(7 downto 0);
    x1, x2, x3 : out std_logic;
    val_addr, wt_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end component;
component ctrl is
   port(clk,rst, start, x1, x2, x3: in std_logic;
        wr, i_ld, j_ld, sel: out std_logic);
end component;
signal  wr, i_ld, j_ld, sel, x1, x2, x3 : std_logic;
begin
    datapath : dp port map (clk, rst, wr, i_ld, j_ld, sel, w, n, val, wt, x1, x2, x3, val_addr, wt_addr, y);
    control : ctrl port map (clk, rst, start, x1, x2, x3, wr, i_ld, j_ld, sel);
end rtl;