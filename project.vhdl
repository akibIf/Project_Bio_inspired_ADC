architecture a1 of digital_part is
type statetype is (sample, hold, compare);
signal state : statetype;
signal sa, sb		: std_logic;
signal s				: std_logic_vector(8 downto 0);

begin 
	process(clock, reset, start)
	
	variable count : integer;	
	begin
		if reset 	= '0' then
			state 	<= sample;
			sa 		<= '1';
			sb 		<= '0';
			s		<= (others => '1');
			result	<= (others => '0');
			count	:= 7;


		else 
			if rising_edge(clock)  then 
			
				case state is
					when sample =>
						sa 		<= '1';
						sb 		<= '0';
						s		<= (others => '1');
						if (start = '1') then
							state <= hold;
						end if;
					count	:= 7; 
					
					when hold =>
					
						sa 		<= '0';
						sb 		<= '1';
						s		<= (8 => '1', others => '0');	
						state 	<= compare;

					when compare =>

								s(count + 1) <= comp;
								s(count) <= '1';

							if count = 0 then
								state <= sample;
								result <=  s(8 downto 2) & comp;
							else
								count := count - 1;
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
Sm <= not(s);
clkcomp <= not(clock); 

end;