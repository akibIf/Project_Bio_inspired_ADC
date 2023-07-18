
architecture a1 of msb_test is

type statetype is (S_in, S_ref );  -- , S_dis_C1C2, S_TVN, S_VTN, S_disC1, S_2XN, S_TVP, S_VTP, S_disC2, S_2XP

signal state : statetype;
signal sa     		: std_logic;
signal sb		    : std_logic;
signal sc     		: std_logic;
signal sd		    : std_logic;
signal se     		: std_logic;
signal count_reg : unsigned(1 downto 0) := "00"; 
--signal s				: std_logic_vector(8 downto 0);

begin 
	process(clock, reset, start)

	variable v1 : integer := 0;

	begin

		if reset 	 = '0' then
			sa 		 <= '1';
			sb 		 <= '0';
			sc		 <= '1';
			sd 		 <= '1';
			se 		 <= '0';
	--		result	 <= (others => '0');
			--bit_count := 7;
			state 	 <= S_in;
			count_reg <= "00";


		else 
			if rising_edge(clock)  then 
			
				case state is

					when S_in =>
						sa 		 <= '0';
						sb 		 <= '0';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '0';
						state	<= S_ref;


					when S_ref =>
						sa 		 <= '1';
						sb 		 <= '0';
						sc		 <= '0';
						sd 		 <= '0';
						se 		 <= '1';
						if comp='0' then
							count_reg <= count_reg + 1;
						--else
					--		state	<= S_dis_C1C2;
       				    end if;

		
			
				end case;
			end if;
		end if;
end process;

SAp <= sa;
SAm <= not(sa);

SBp <= sb;
SBm <= not(sb);

SCp <= sc;
SCm <= not(sc);

SDp <= sd;
SDm <= not(sd);

SEp <= se;
SEm <= not(se);


result <= std_logic_vector(count_reg);


--clkcomp <= not(clock);

end a1;
