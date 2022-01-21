----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2022 12:34:10
-- Design Name: 
-- Module Name: moniteur - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity moniteur is
  generic( N: integer :=2);
  Port (
  clk : in std_logic;
  led : out std_logic;
  wcet : in std_logic_vector(23 downto 0);
  indice : in  std_logic_vector( N downto 0);
  sig : in std_logic_vector( N+1 downto 0)
   );
end moniteur;
architecture Behavioral of moniteur is
    type bank_counter is array (0 to N) of std_logic_vector(23 downto 0);  
    signal cnts : bank_counter;
    signal wcet_tab : bank_counter;
    signal old_indice : std_logic_vector(N downto 0);  
    --state  correspond a l'etat ( ecriture ou lecture )
    
begin
    proc : process (sig,clk)
    begin
        if old_indice/=indice then 
            led<= '0';
        end if;
        if conv_integer(cnts(conv_integer(indice)))> conv_integer(wcet_tab(conv_integer(indice))) then 
                led<='1';
                old_indice<= indice;
        end if;
        case (conv_integer(sig)) is 
        when 0 =>
            --init
            wcet_tab(conv_integer(indice))<= wcet;
            cnts(conv_integer(indice))<= "000000000000000000000000";
            
        when 1 =>
            --start
            cnts(conv_integer(indice))<= cnts(conv_integer(indice))+"000000000000000000000001";
            
        when 2 =>
            --pause ne rien faire 
            cnts(conv_integer(indice))<= cnts(conv_integer(indice))+"000000000000000000000000";
        when 3 => 
            --resume 
             cnts(conv_integer(indice))<= cnts(conv_integer(indice))+"000000000000000000000001";
             
        when 4 =>
            --stop
            wcet_tab(conv_integer(indice))<= "000000000000000000000000";
            cnts(conv_integer(indice))<= "000000000000000000000000";
            led<='0';
         when 5 =>
            --reset compteur job 
            cnts(conv_integer(indice))<= "000000000000000000000000";
        when others =>
            --do nothing
        end case;
        
    end process;
    


end Behavioral;
