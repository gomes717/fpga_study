library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Display7Seg is 
	port(	val 	: in unsigned(3 downto 0);
			leds 	: out unsigned(7 downto 0)
		 );
end entity Display7Seg;


architecture rtl of Display7Seg is
signal leds_r : unsigned(7 downto 0) := "00000000";
begin 
	with val select
		leds_r <= 	"00111111" when "0000",
						"00000110" when "0001",
						"01011011" when "0010",
						"01001111" when "0011",
						"01100110" when "0100",
						"01101101" when "0101",
						"01111101" when "0110",
						"00000111" when "0111",
						"01111111" when "1000",
						"01101111" when "1001",
						"01110110" when others;
	leds <= not leds_r;

end architecture rtl;