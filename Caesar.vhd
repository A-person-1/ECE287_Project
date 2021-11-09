library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Caesar is
	port
	(
		word : in string(1 to 20);
		key : in integer := 3;
		result : out string(1 to 20);
		choice : in STD_LOGIC
	);
end Caesar;

architecture Caesar_cipher of Caesar is
	signal first : character;
	signal changed : character;

	begin -- architecture
	process(first, changed, choice, key)
	begin -- process
	if choice = '0' then
		FOR i in 0 TO word'LENGTH LOOP
			first <= word'pos(i);
			changed <= first + key;
			result'pos(i) <= changed;
		end LOOP;
		else
			FOR i in 0 TO word'LENGTH LOOP
			first <= word'pos(i);
			changed <= first - key;
			result'pos(i) <= changed;
		end LOOP;
	end if;
	end process;
end Caesar_cipher;
