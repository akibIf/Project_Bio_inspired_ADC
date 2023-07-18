architecture a1 of digital_part is

type statetype is (initial, S_ref, S_dis_C1C2, S_TVN, S_VTN, S_disC1, S_2XN, S_TVP, S_VTP, S_disC2, S_2XP );

signal state : statetype;
signal sa     		: std_logic;
signal sb		    : std_logic;
signal sc     		: std_logic;
signal sd		    : std_logic;
signal se     		: std_logic;
signal sf     		: std_logic;
signal count_reg : unsigned(10 downto 0) := "00000000000"; 
--signal s				: std_logic_vector(8 downto 0);


--signal s				: std_logic_vector(8 downto 0);

begin 
	process(clock, reset, start)

	variable v1 : integer := 0;	 

	begin
			if reset 	 = '0' then
				sa 		 <= '0'; -- sa (0) is connected to gnd S1
				sb 		 <= '0'; -- sb (0) connects C2 via S2
				sc		 <= '1'; -- sc(1) connects to C1 via s-
				sd 		 <= '0'; -- sd(0) connects gnd via s1
				se 		 <= '0'; -- se(1) connects to C1 via s-
				sf 		 <= '0'; -- se(1) connects to C1 via s-
			--	result	 <= (others => '0');

				state 	 <= initial;
				count_reg <=  "00000000000"; 

		
		else 
			if rising_edge(clock)  then 
			
				case state is
					when initial =>
								sa 		 <= '0'; -- sa (0) is connect	ed to gnd S1
								sb 		 <= '0'; -- sb (0) connects C2 via S2
								sc		 <= '1'; -- sc(1) connects to C1 via s-
								sd 		 <= '0'; -- sd(0) connects gnd via s1
								se 		 <= '0'; -- se(1) connects to C1 via s-
								sf 		 <= '0';
							

						if start = '1' then
								state 	 <= S_in;
								count_reg <=  "00000000000"; 
						end if;	

					when S_in =>
						sa 		 <= '1'; -- sa(1) is connected to C1 charging
						sb 		 <= '0'; -- sb(0) is connected to open
						sc		 <= '0'; -- sc(1) is connected to C1 charging
						sd 		 <= '0'; -- sd(0) is connected to gnd
						se 		 <= '0'; -- se(0) is open
						sf 		 <= '0';
						state	<= S_ref;


					when S_ref =>
						sa 		 <= '1'; -- sa(1) connected to Iin
						sb 		 <= '0'; -- sb(0) connects Iref with c2 via s2
						sc		 <= '1'; -- sc(0) is disconnected
						sd 		 <= '1'; -- sd(1) conneced to c2
						se 		 <= '1'; -- se(1) is connected to C2
						sf 		 <= '0';
						if comp='1' then
							count_reg <= count_reg + 1;
						else
						  	
						     	state	<= S_dis_C1C2;
       				    end if;

					when S_dis_C1C2 =>
								sa 		 <= '0'; -- sa (0) is connect	ed to gnd S1
								sb 		 <= '0'; -- sb (0) connects C2 via S2
								sc		 <= '1'; -- sc(1) connects to C1 via s-
								sd 		 <= '0'; -- sd(0) connects gnd via s1
								se 		 <= '0'; -- se(1) connects to C1 via s-
								sf 		 <= '0';
								
						if v1 = 1 then
							state	<= S_TVP;
						else
							state	<= S_TVN;
						end if;
 
					when	 S_TVN =>
						sa 		 <= '1';
						sb 		 <= '1';
						sc		 <= '1';
						sd 		 <= '0';
						se 		 <= '1';
						sf 		 <= '1';
						state	<= S_VTN;

					when	 S_VTN =>
						sa 		 <= '1';
						sb 		 <= '0';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '1';
						sf 		 <= '0';
						state	<= S_disC1;


					when	 S_disC1 =>
						sa 		 <= '1';
						sb 		 <= '1';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '0';
						sf 		 <= '0';
						state	<= S_2XN;

					when	 S_2XN =>
						sa 		 <= '1';
						sb 		 <= '1';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '1';
						sf 		 <= '1';
						v1 := 1;
						state	<= S_dis_C1C2;


					when	 S_TVP =>
						sa 		 <= '1';
						sb 		 <= '0';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '1';
						sf 		 <= '0';
						state	<= S_VTP;

					when	 S_VTP =>
						sa 		 <= '1';
						sb 		 <= '1';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '1';
						sf 		 <= '1';
						state	<= S_disC2;

					when	 S_disC2 =>
						sa 		 <= '1';
						sb 		 <= '1';
						sc		 <= '1';
						sd 		 <= '0';
						se 		 <= '0';
						sf 		 <= '0';
						state	<= S_2XP;

					when	 S_2XP =>
						sa 		 <= '1';
						sb 		 <= '0';
						sc		 <= '1';
						sd 		 <= '1';
						se 		 <= '1';
						sf 		 <= '0';
						v1 := 0;
						state	<= S_dis_C1C2;

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

SFp <= sf;
SFm <= not(sf);

result <= std_logic_vector(resize(count_reg, result'length));


end a1;