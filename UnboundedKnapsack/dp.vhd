library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dp is
    port (clk, rst, wr, i_ld, j_ld, sel : in std_logic;
    w, n, val, wt : in std_logic_vector(7 downto 0);
    x1, x2, x3 : out std_logic;
    val_addr, wt_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
end dp;

architecture rtl of dp is
component compgr is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic);
end component;
component plus1 is
    port (a : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component reg8 is
port (clk, rst, en: in std_logic;
reg_in: in std_logic_vector(7 downto 0);
reg_out: out std_logic_vector(7 downto 0));
end component;
component ram is
port(clk, wr : in std_logic;
i, wt, val, w : in std_logic_vector(7 downto 0);
y : out std_logic_vector(15 downto 0));
end component;
component complt is
    port (
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic);
end component;
signal i, i_in, iplus1, j, j_in, jplus1 :  std_logic_vector(7 downto 0);
begin
    i_op : plus1 port map (i, iplus1);
    i_mux : mux8 port map (sel, "00000000", iplus1, i_in);
    i_reg : reg8 port map (clk, rst, i_ld, i_in, i);
    j_op : plus1 port map (j, jplus1);
    j_mux : mux8 port map (sel, "00000000", jplus1, j_in);
    j_reg : reg8 port map (clk, rst, j_ld, j_in, j);
    iw_comp : compgr port map (i, w, x1);
    jn_comp : complt port map (j, n, x2);
    wti_comp : compgr port map (wt, i, x3);
    dp_ram : ram port map (clk, wr, i, wt, val, w, y);
    val_addr <= j(3 downto 0);
    wt_addr <= j(3 downto 0);
end rtl;

