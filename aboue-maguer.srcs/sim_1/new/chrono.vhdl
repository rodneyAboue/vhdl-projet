
Skip to content
Pull requests
Issues
Marketplace
Explore
@imhassane
rodneyAboue /
vhdl-projet lignes Stat is unavailable
Public

Code
Issues
Pull requests
Actions
Projects
Wiki
Security

    Insights

vhdl-projet/aboue-maguer.srcs/sources_1/new/moniteur.vhd
@rodneyAboue
rodneyAboue Add files via upload
Latest commit 04681f8 7 days ago
History
1 contributor
96 lines (83 sloc) 2.75 KB
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



entity chrono is
  generic( N: integer :=2);
  Port (
    clk : in std_logic;
    sig : in std_logic_vector( 2 downto 0);
    time : out integer;
    depassement : out std_logic;
    arrive : in std_logic
   );
end chrono;
architecture Behavioral of chrono is
    signal cpt : std_logic_vector(26 downto 0); 
begin
    proc : process (sig,clk,arrive)
    begin
        case (conv_integer(sig)) is 
        when 0 =>
            --nouvelle course 
            cpt <= "000000000000000000000000000";
            time =: 0;
        when 1 =>
            --go 
            if clk ’ event and clk = '1' then
                cpt<= cpt + "000000000000000000000000001";
            end if;
            if conv_integer(cpt) /100000000  then 
                -- depassement pas atteint
                depassement <= '0';
            end if;
            if arrive ='1' then 
                time <= conv_integer(cpt) /100000000;
            end if; 
        when 2 =>
            -- faux depart
            cpt <= "000000000000000000000000000";
        when 3 =>
            -- reset
            cpt <= "000000000000000000000000000";
            time =: 0;
        when others =>
            --do nothing
            cpt <= "000000000000000000000000000";
            time =: 0;
        end case;
        
    end process;
    


end Behavioral;
