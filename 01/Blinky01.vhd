library ieee;
use ieee.std_logic_1164.all;

entity Blinky01 is 
	port(clk : in std_logic;
			a,b : in std_logic;
			y : out std_logic);
	end entity;
	
architecture rtl of Blinky01 is 
	signal foo : std_logic;
	begin
		process(clk)
			begin
				if rising_edge(clk) then 
					foo <= (not a) and (not b);
				end if;
			end process;
		y <= not foo;
	end architecture;
