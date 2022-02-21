----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:01 04/09/2018 
-- Design Name: 
-- Module Name:    sbox - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sbox is
    Port (-- a : in  STD_LOGIC_VECTOR (63 downto 0);
           b : out  STD_LOGIC_VECTOR (63 downto 0);
			  --p : out  STD_LOGIC_VECTOR (63 downto 0);
			  --d:buffer STD_LOGIC_VECTOR (63 downto 0);
           --c:buffer STD_LOGIC_VECTOR (63 downto 0);
           clk : in  STD_LOGIC);
           --key : in  STD_LOGIC_VECTOR (63 downto 0));
end sbox;

architecture Behavioral of sbox is
--type state_machine is(Sbox
signal count:integer range 0 to 32:=0;
signal count2:integer range 0 to 34:=1;
signal key1,d,c:STD_LOGIC_VECTOR (63 downto 0);
signal parity:STD_LOGIC_VECTOR (15 downto 0):=x"0000";
signal c1:STD_LOGIC_VECTOR (3 downto 0):=x"0";
signal c3:STD_LOGIC_VECTOR (3 downto 0):=x"0";
signal c4:STD_LOGIC_VECTOR (3 downto 0):=x"0";
signal c2:STD_LOGIC_VECTOR (15 downto 0):=x"0000";

type state_machine is (SBOX,AC,ART,SHF,MIXC,end1,endi);
signal round: state_machine:=SBOX;
begin
--d<=a;
process(clk)
begin
if (clk' event and clk='1') then 
if (count2<35) then
 case round is
	when SBOX=>

		c4<=c3 xor c1;
		count<=count+1;
		if (count2=1 and count=1) then
		d<=X"06034f957724d19d";
		key1<=X"f5269826fc681238";
		elsif (count2>1 and count=1) then
		d<=c;
		end if;
		if (count<18 and count>1) then
			d(3 downto 0)<=d(7 downto 4);
			d(59 downto 4)<=d(63 downto 8); 
			d(63 downto 60)<=d(3 downto 0);
			c(3 downto 0)<=c(7 downto 4);
			c(59 downto 4)<=c(63 downto 8);
			c(63 downto 60)<=c(3 downto 0);
			c(3)<=((d(2)nor d(3)) xor d(0));
			c(2)<=((d(1)nor d(2)) xor d(3));
			c(1)<=(((d(2)nor d(3)) xor d(0)) nor d(1)) xor d(2);
			c(0)<=(((d(1)nor d(2)) xor d(3)) nor((d(2)nor d(3)) xor d(0))) xor d(1);
			parity(14 downto 0)<=parity(15 downto 1);
			parity(15)<=parity(0);
			parity(0)<=(d(2)and(d(1)xor d(3)))or((not d(0)) and d(2)) or ((not d(2)) and d(0) and d(3));
			--c1<= (d(0));-- and (d(1)xor d(3)));
		elsif (count =19) then
			parity(14 downto 0)<=parity(15 downto 1);
			parity(15)<=parity(0);
			c(3 downto 0)<=c(7 downto 4);
			c(59 downto 4)<=c(63 downto 8);
			c(63 downto 60)<=c(3 downto 0);
			count<=0;
			round<=AC;
		end if;
	when AC=>
		c(31 downto 28)<=c(31 downto 28) xor X"2";
		parity(7)<=parity(7) xor '1';
		round<=ART;
		case count2 is
			when 1=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"1";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 2=>
			
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"3";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 3=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"7";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 4=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"f";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 5=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"f";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 6=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"e";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 7=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"d";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 8=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"b";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 9=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"7";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 10=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"f";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 11=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"e";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 12=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"c";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 13=>
				c(63 downto 60)<=c(63 downto 60) xor X"9";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 14=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"3";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 15=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"7";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 16=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"e";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 17=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"d";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 18=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"a";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 19=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"5";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 20=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"b";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 21=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"6";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 22=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"c";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 23=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"8";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 24=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"0";
				c(47 downto 44)<=c(47 downto 44) xor X"3";
				
			when 25=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"1";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 26=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"2";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 27=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"5";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 28=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"b";
				c(47 downto 44)<=c(47 downto 44) xor X"0";
				
			when 29=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"7";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 30=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"e";
				c(47 downto 44)<=c(47 downto 44) xor X"2";
				
			when 31=>
				parity(15)<=parity(15) xor '0';
				parity(11)<=parity(11) xor '1';
				c(63 downto 60)<=c(63 downto 60) xor X"c";
				c(47 downto 44)<=c(47 downto 44) xor X"1";
				
			when 32=>
				parity(15)<=parity(15) xor '1';
				parity(11)<=parity(11) xor '0';
				c(63 downto 60)<=c(63 downto 60) xor X"8";
				c(47 downto 44)<=c(47 downto 44) xor X"3";	
			 when others=>
			    c<=c;
		end case;
	
	when ART=>
		parity(15)<=parity(15) xor key1(63)  xor key1(62)  xor key1(61)  xor key1(60);
		parity(14)<=parity(14) xor key1(59)  xor key1(58)  xor key1(57)  xor key1(56);
		parity(13)<=parity(13) xor key1(55)  xor key1(54)  xor key1(53)  xor key1(52);
		parity(12)<=parity(12) xor key1(51)  xor key1(50)  xor key1(49)  xor key1(48);
		c(63 downto 60)<=c(63 downto 60) xor key1(63 downto 60);--3 downto 0
		c(59 downto 56)<=c(59 downto 56) xor key1(59 downto 56);--7 downto 4
		c(55 downto 52)<=c(55 downto 52) xor key1(55 downto 52);--11 downto 8
		c(51 downto 48)<=c(51 downto 48) xor key1(51 downto 48);	--15 downto 12
		--------------------------------------------------
		parity(11)<=parity(11) xor key1(47)  xor key1(46)  xor key1(45)  xor key1(44);
		parity(10)<=parity(10) xor key1(43)  xor key1(42)  xor key1(41)  xor key1(40);
		parity(9)<=parity(9) xor key1(39)  xor key1(38)  xor key1(37)  xor key1(36);
		parity(8)<=parity(8) xor key1(35)  xor key1(34)  xor key1(33)  xor key1(32);
		c(47 downto 44)<=c(47 downto 44) xor key1(47 downto 44);--19 downto 16
		c(43 downto 40)<=c(43 downto 40) xor key1(43 downto 40);--23 downto 20
		c(39 downto 36)<=c(39 downto 36) xor key1(39 downto 36);--27 downto 24
		c(35 downto 32)<=c(35 downto 32) xor key1(35 downto 32);	--31 downto 28
-------------------------------------------------------------------------		
		key1(63 downto 60)<=key1(27 downto 24);--3 downto 0
		key1(59 downto 56)<=key1(3 downto 0);--7 downto 4
		key1(55 downto 52)<=key1(31 downto 28);--11 downto 8
		key1(51 downto 48)<=key1(11 downto 8);	--15 downto 12
		--------------------------------------------------
		key1(47 downto 44)<=key1(23 downto 20);--19 downto 16
		key1(43 downto 40)<=key1(7 downto 4);--23 downto 20
		key1(39 downto 36)<=key1(15 downto 12);--27 downto 24
		key1(35 downto 32)<=key1(19 downto 16);	--31 downto 28		
		--------------------------------------------------
		key1(31 downto 28) <= key1(63 downto 60);--35 downto 32
		key1(27 downto 24) <= key1(59 downto 56);--39 downto 36	
		key1(23 downto 20) <= key1(55 downto 52);--43 downto 40
		key1(19 downto 16) <= key1(51 downto 48);--47 downto 44
		--------------------------------------------------		
		key1(15 downto 12) <= key1(47 downto 44);--51 downto 48
		key1(11 downto 8) <= key1(43 downto 40);--55 downto 52
		key1(7 downto 4) <= key1(39 downto 36);--59 downto 56
		key1(3 downto 0) <= key1(35 downto 32);--63 downto 60
		round<=SHF;


		
	When ShF=>
		parity(10 downto 8)<=parity(11 downto 9);
		parity(11)<=parity(8);
		c(47 downto 44)<=c(35 downto 32);--19 downto 16
		c(43 downto 40)<=c(47 downto 44);--23 downto 20
		c(39 downto 36)<=c(43 downto 40);--27 downto 24
		c(35 downto 32)<=c(39 downto 36);--31 downto 28
		--------------------------------------------------	
		parity(7 downto 6)<=parity(5 downto 4);
		parity(5 downto 4)<=parity(7 downto 6);
		c(31 downto 28) <= c(23 downto 20);--35 downto 32
		c(27 downto 24) <= c(19 downto 16);--39 downto 36	
		c(23 downto 20) <= c(31 downto 28);--43 downto 40
		c(19 downto 16) <= c(27 downto 24);--47 downto 44
		--------------------------------------------------	
		parity(3 downto 1)<=parity(2 downto 0);
		parity(0)<=parity(3);		
		c(15 downto 12) <= c(11 downto 8);--51 downto 48
		c(11 downto 8) <= c(7 downto 4);--55 downto 52
		c(7 downto 4) <= c(3 downto 0);--59 downto 56
		c(3 downto 0) <= c(15 downto 12);--63 downto 60
		round<=MIXC;

		
	when MIXC=>
		
	   c(63 downto 60)<=c(15 downto 12) xor c(31 downto 28) xor c(63 downto 60);--3 downto 0
		c(59 downto 56)<=c(11 downto 8) xor c(27 downto 24) xor c(59 downto 56);--7 downto 4
		c(55 downto 52)<=c(7 downto 4) xor c(23 downto 20) xor c(55 downto 52);--11 downto 8
		c(51 downto 48)<=c(3 downto 0) xor c(19 downto 16) xor c(51 downto 48);	--15 downto 12
		--------------------------------------------------
		c(47 downto 44)<=c(63 downto 60);--19 downto 16
		c(43 downto 40)<=c(59 downto 56);--23 downto 20
		c(39 downto 36)<=c(55 downto 52);--27 downto 24
		c(35 downto 32)<=c(51 downto 48);	--31 downto 28
		--------------------------------------------------	
		c(31 downto 28) <=c(31 downto 28) xor c(47 downto 44);--35 downto 32
		c(27 downto 24) <=c(27 downto 24)  xor c(43 downto 40);--39 downto 36	
		c(23 downto 20) <= c(23 downto 20) xor c(39 downto 36);--43 downto 40
		c(19 downto 16) <= c(19 downto 16) xor c(35 downto 32);--47 downto 44
		--------------------------------------------------			
		c(15 downto 12) <= c(31 downto 28) xor c(63 downto 60);--51 downto 48
		c(11 downto 8) <= c(27 downto 24) xor c(59 downto 56);--55 downto 52
		c(7 downto 4) <= c(23 downto 20) xor c(55 downto 52);--59 downto 56
		c(3 downto 0) <= c(19 downto 16) xor c(51 downto 48);--63 downto 60
		---------------check parity mix------------------------------------
		c1(3)<=parity(0) xor parity(4) xor parity(8) xor parity(12);
		c1(2)<=parity(1) xor parity(5) xor parity(9) xor parity(13);
		c1(1)<=parity(2) xor parity(6) xor parity(10) xor parity(14);
		c1(0)<=parity(3) xor parity(7) xor parity(11) xor parity(15);
		-------------------------------------------------------------------
		c2(3 downto 0)<=c(63 downto 60) xor c(47 downto 44) xor  c(31 downto 28) xor c(15 downto 12);
		c2(7 downto 4)<=c(59 downto 56) xor c(43 downto 40)  xor  c(27 downto 24) xor c(11 downto 8);
		c2(11 downto 8)<=c(55 downto 52) xor c(39 downto 36) xor  c(23 downto 20) xor c(7 downto 4);
		c2(15 downto 12)<=c(51 downto 48) xor c(35 downto 32) xor  c(19 downto 16) xor c(3 downto 0);
		-------------------------------------------------------------------
		
		--------------------------------------------------------------------
		if (c4=x"0") then			
			round<=end1;	
		else 
			round<=endi;
		end if;
	when end1=>
		c3(0)<=c2(0) xor c2(1) xor c2(2) xor c2(3);
		c3(1)<=c2(4) xor c2(5) xor c2(6) xor c2(7);
		c3(2)<=c2(8) xor c2(9) xor c2(10) xor c2(11);
		c3(3)<=c2(12) xor c2(13) xor c2(14) xor c2(15);
		count2<=count2+1;
		if (count2=32) then
			round<=end1;	
		elsif(count2<32) then
			round<=SBOX; 
		elsif(count2=33) then
			c4<=c3 xor c1;
			round<=endi;
		end if;
		
	
		
	when endi=>
		if (c4=x"0") then
			b<=c;
		else
		b<=X"0000000000000000";
		end if;
	end case;
end if;
end if;
end process;


end Behavioral;

