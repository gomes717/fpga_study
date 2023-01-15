library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx_driver is
	port(	tx 		: out std_logic;
			clk 		: in std_logic;
			data		: in std_logic_vector(7 downto 0);
			send  	: in std_logic;
			sending	: out std_logic
			);

end entity;


architecture tx_driver_a of tx_driver is

signal data_buff   : std_logic_vector(7 downto 0) := "00000000";
signal sending_buf : std_logic := '0';
signal count 		 : unsigned(27 downto 0) := "0000000000000000000000000000";
signal tx_buf		 : std_logic := '1';
signal state		 : unsigned(1 downto 0) := "00";
signal bit_count	 : unsigned(2 downto 0) := "000";

begin
	
	process(clk)
	begin
		if (rising_edge(clk)) then
			if( send = '1' and sending_buf = '0') then
				sending_buf <= '1';
			end if;
			
			if(sending_buf = '1') then
				if state = "00" then
					state <= "01";
					tx_buf <= '0';
					data_buff <= data;
				end if;
					
				if( count = 5207 ) then
					count <= "0000000000000000000000000000";
					if state = "01" then
						state <= "10";
						tx_buf <= data_buff(to_integer(bit_count));
						bit_count <= bit_count + 1;
					elsif state = "10" then
						tx_buf <= data_buff(to_integer(bit_count));
						if (bit_count = 7) then
							bit_count <= "000";
							state <= "11";
						else
							bit_count <= bit_count + 1;
						end if;
					elsif(state = "11") then
						sending_buf <= '0';
						tx_buf <= '1';
						state <= "00";
						data_buff <= "00000000";
					end if;
				else
					count <= count + 1;
				end if;
			end if;
		end if;
	end process;
	tx <= tx_buf;
	sending <= sending_buf;
end architecture;