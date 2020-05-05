library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start: std_logic;
  signal val_addr, wt_addr : std_logic_vector(3 downto 0);
  signal  w, n, val, wt : std_logic_vector (7 downto 0);
  signal  y : std_logic_vector (15 downto 0);
  component toplevel
   port (clk, rst, start : in std_logic;
    w, n, val, wt: in std_logic_vector(7 downto 0);
    val_addr, wt_addr : out std_logic_vector(3 downto 0);
    y : out std_logic_vector(15 downto 0));
  end component ;
  component val_rom is
port(addr: in std_logic_vector (3 downto 0);
data: out std_logic_vector (7 downto 0));
end component;
component wt_rom is
port(addr: in std_logic_vector (3 downto 0);
data: out std_logic_vector (7 downto 0));
end component;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    w <= "01100100";
    n <= "00000011";
    dut: toplevel port map(clk,rst,start,w, n, val, wt, val_addr, wt_addr, y);
    rom1 : val_rom port map (val_addr, val);
    rom2 : wt_rom port map (wt_addr, wt);
  end behav;