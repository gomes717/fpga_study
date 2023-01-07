library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultiDisplay is 
	port(	val 	: in unsigned(9 downto 0);
			clk	: in std_logic;
			sel 	: out unsigned(2 downto 0);
			leds 	: out unsigned(7 downto 0)
		 );
end entity MultiDisplay;


architecture rtl of MultiDisplay is

signal count 	: unsigned(27 downto 0) := "0000000000000000000000000000";
signal val_un 	: unsigned(9 downto 0) := "0000000000";
signal sel_r 	: unsigned(2 downto 0) := "001";

component Display7Seg is 
	port(	val 	: in unsigned(3 downto 0);
			leds 	: out unsigned(7 downto 0)
		 );
end component;

begin 
	display : Display7Seg port map(val => val_un(3 downto 0), leds => leds);
	process(clk)
	begin
		if rising_edge(clk) then
			if(count = 250000) then
				sel_r <= sel_r(1 downto 0) & sel_r(2);
				count <= "0000000000000000000000000000";
			else
				count <= count + 1;
			end if;
		end if;
	end process;
	sel <= sel_r;
	with sel_r select
	val_un <= val mod 10 when "100",
				 (val mod 100)/10 when "010",
				 (val mod 1000)/100 when "001",
				 "1111111111" when others;
				 
end architecture rtl;