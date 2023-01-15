library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UART is
	port( rx 	: in std_logic;
			tx 	: out std_logic;
			clk 	: in std_logic
			);

end entity;


architecture Uart_a of UART is

signal count 	: unsigned(27 downto 0) := "0000000000000000000000000000";
signal send_i : std_logic := '0';
signal sending_tx : std_logic := '0';

component tx_driver is
	port(	tx 	: out std_logic;
			clk 	: in std_logic;
			data	: in unsigned(7 downto 0);
			send  : in std_logic;
			sending : out std_logic
			);

end component;

begin

	tx_d : tx_driver port map( clk => clk, tx => tx, data => "11111111", send => send_i, sending => sending_tx);
	
	process(clk)
	begin
		if rising_edge(clk) then
			if( count = 50000000 ) then
				send_i <= '1';
				count <= "0000000000000000000000000000";
			else
				count <= count + 1;
				if sending_tx = '1' then
					send_i <= '0';
				end if;
			end if;
		end if;
	end process;
end architecture;