architecture a1 of dig_gene is

--signal reset : std_logic ;
signal clk : std_logic := '0' ;


begin

reset <= '0', '1' after 200 ns ;
clk <= not clk after 500 ns ;
clock <= clk ;

process
begin
   start <= '0';
   wait for 1 us ;
   loop
	   start <= '1';
 	   wait for 1 us ;
	   start <= '0';
	   wait for 10 us ;
   end loop ;
end process ;

end ;
