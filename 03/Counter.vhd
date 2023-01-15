library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter is 
	port( clk	: in std_logic;
			sel 	: out unsigned(2 downto 0);
			leds 	: out unsigned(7 downto 0)
		 );
end entity Counter;


architecture rtl of Counter is

signal count 	: unsigned(27 downto 0) := "0000000000000000000000000000";
signal val_un 	: unsigned(9 downto 0) := "0000000000";

component MultiDisplay is 
	port(	val 	: in unsigned(9 downto 0);
			clk	: in std_logic;
			sel 	: out unsigned(2 downto 0);
			leds 	: out unsigned(7 downto 0)
		 );
end component;

begin

	multi : MultiDisplay port map(clk => clk, val => val_un, sel => sel, leds => leds);
	process(clk)
	begin
		if rising_edge(clk) then
			if(count = 5000000) then
				count <= "0000000000000000000000000000";
				val_un <= val_un + 1;
			else
				count <= count + 1;
			end if;
		end if;
	end process;

end architecture rtl;