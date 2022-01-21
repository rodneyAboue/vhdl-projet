
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_moniteur is
--  Port ( );
end tb_moniteur;

architecture Behavioral of tb_moniteur is
  signal t_clk :std_logic :='0';
  signal t_led: std_logic;
  signal t_wcet : std_logic_vector(23 downto 0);
  signal t_indice : std_logic_vector(2 downto 0);
  signal t_sig: std_logic_vector (3 downto 0);
  component moniteur is port (
  clk : in std_logic;
  led : out std_logic;
  wcet : in std_logic_vector(23 downto 0);
  indice : in  std_logic_vector( 2 downto 0);
  sig : in std_logic_vector( 3 downto 0)
   );
   end component;
begin
iut: entity work.moniteur(behavioral)
port map(
    clk=>t_clk,
    wcet => t_wcet,
    indice => t_indice,
    sig => t_sig,
    led => t_led
);
    t_clk <= not t_clk after 10 ns;
    process_1 : process
    begin
    --initialisation de trois  jobs
    --job1
    t_indice<="000";
    t_sig <= "0000";
    t_wcet <= "000000000000000000000010";
    wait for 50 ns ;
    --job2
    t_indice<="010";
    t_sig <= "0000";
    t_wcet <= "000000000000000000001000";
    wait for 50 ns;

    -----------------------------------
    --start job1
    t_indice<="001";
    t_sig <= "0001";
    wait for 50 ns;
    
    --pause job 1
    t_indice<="001";
    t_sig <= "0010";
    wait for 100 ns ;
    
    --start job2
    t_indice<="010";
    t_sig <= "0001";
    wait for 50 ns;
    
    --pause job2
    t_indice<="010";
    t_sig <= "0010";
    wait for 100 ns;
    
    --resume job 1
    t_indice<="001";
    t_sig <= "0011";
    
    --pause job 1
    t_indice<="001";
    t_sig <= "0010";
    wait for 100 ns ;

     --stop  job2
    t_indice<="010";
    t_sig <= "0010";
    wait for 100 ns;
    
    --reset compteur   job1
    t_indice<="001";
    t_sig <= "0101";
    wait for 10 ns;   
end process;


end Behavioral;
