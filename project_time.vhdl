library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use std.TEXTIO.all;

entity digital_part is
port{
	reset, clock		: in std_logic;
	start, comp			: in std_logic;
	clkcomp				: out std_logic;
	SAp, SAn, SBp, SBn	: out std_logic;
	result				: out std_logic_vector(3 downto 0);
}
end;

architecture a1 of digital_part is
type statetype is (S_in, S_ref, S_TVN, S_VTN, S_2XN, S_TVP, S_VTP, S_2XP);
 signal state 							: statetype;
 signal sa, sb, sc, sd, se, sf			: std_logic;
-- signal s				: std_logic_vector(8 downto 0); 

begin 
	process(clock, reset, start)
	
	variable count : integer;	
	begin
		if reset 	= '0' then

			sa 		<= '0';
			sb 		<= '0';
			sc 		<= '0';
			sd 		<= '1';
			se		<= '1';
			sf		<= '1';
			state 	<= S_in;
			
			s		<= (others => '1');
			result	<= (others => '0');
			count	:= 7;


		else 
			if rising_edge(clock)  then 
			
				case state is
					when S_in =>
						sa 		<= '1';
						sb 		<= '0';
						sc 		<= '0';
						sd 		<= '1';
						se		<= '1';
						sf		<= '1';
					
					when S_ref =>
					
						sa 		<= '0';
						sb 		<= '0';
						sc 		<= '1';
						sd 		<= '1';
						se		<= '0';
						sf		<= '1';
						
						-- Here C1 and C2 are reset. Here C1 and C2 are connected to ground
					
					when S_TVN =>		-- C1 is charged with Tres
						sa 		<= '0';
						sb 		<= '1';
						sc 		<= '0';
						sd 		<= '0';
						se		<= '1';
						sf		<= '1';
					
					
					when S_VTN =>		-- C2 is charged with Tref
						sa 		<= '0';
						sb 		<= '0';
						sc 		<= '1';
						sd 		<= '1';
						se		<= '0';
						sf		<= '1';
					
					when S_2XN =>  -- How we will make sure C2 is charged twice
						sa 		<= '0';
						sb 		<= '0';
						sc 		<= '1';
						sd 		<= '1';
						se		<= '0';
						sf		<= '1';
						
						-- Here C1 and C2 are reset. Here C1 and C2 are connected to ground


					when S_TVP =>		-- C2 is charged with Tres
						sa 		<= '0';
						sb 		<= '0';
						sc 		<= '1';
						sd 		<= '1';
						se		<= '1';
						sf		<= '1';
					
					
					when S_VTP =>
						
						sa 		<= '0';
						sb 		<= '1';
						sc 		<= '1';
						sd 		<= '0';
						se		<= '1';
						sf		<= '0';
					
					when S_2XP =>
					
					
					
			
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

Sp <= s;
Sm <= not(s);
clkcomp <= not(clock); 

end;