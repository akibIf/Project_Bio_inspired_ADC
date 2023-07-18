architecture a1 of msb_digital_part_SAR is

type statetype is (sample, hold, compare);

signal state : statetype;
signal sa     		: std_logic;
signal sb		    : std_logic;
signal s				: std_logic_vector(8 downto 0);

begin 
	process(clock, reset, start)

	variable bit_count : integer;	 

	begin

		if reset 	 = '0' then
			state 	 <= sample;
			sb 		 <= '0';
			sa 		 <= '1';
			s		 <= (others => '1');
			result	 <= (others => '0');
			bit_count := 7;


		else 
			if rising_edge(clock)  then 
			
				case state is
					when sample =>
						sb 	<= '0';
						sa 	<= '1';
						s	<= (others => '1');
						if (start = '1') then
							state <= hold;
				 		end if;
							bit_count := 7;
					
					when hold =>
						sb 	<= '1';
						sa 	<= '0';
						s	<= (8 => '1' , others => '0');
						state <= compare;
				
					when compare =>
						s(bit_count + 1) <= comp;	
						s(bit_count)     <= '1';
						if (bit_count = 0) then
							state <= sample;
							result <= s(8 downto 2) & comp;
						else
							bit_count := bit_count - 1 ;
						end if;
						
				end case;
			end if;
		end if;
end process;

SAp <= sa;
SAm <= not(sa);

SBp <= sb;
SBm <= not(sb);

Sp <= s;
Sm <= not (s);

clkcomp <= not(clock);

end a1;
