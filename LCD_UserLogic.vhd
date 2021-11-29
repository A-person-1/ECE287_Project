--------------------------------------------------------------------------------
--
--   FileName:         lcd_example.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 32-bit Version 11.1 Build 173 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 6/13/2012 Scott Larson
--     Initial Public Release
--
--   Prints "HELLO WORLD" on a HD44780 compatible 8-bit interface character LCD 
--   module using the lcd_controller.vhd component.
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY lcd IS
  PORT(
      clk       : IN  STD_LOGIC;  --system clock
      rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
      lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --data signals for lcd
	   key    : IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		decrypt : IN STD_LOGIC);
END lcd;

ARCHITECTURE behavior OF lcd IS
  SIGNAL   lcd_enable : STD_LOGIC;
  SIGNAL   lcd_bus    : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL   lcd_busy   : STD_LOGIC;

  COMPONENT lcd_controller IS
    PORT(
       clk        : IN  STD_LOGIC; --system clock
       reset_n    : IN  STD_LOGIC; --active low reinitializes lcd
       lcd_enable : IN  STD_LOGIC; --latches data into lcd controller
       lcd_bus    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0); --data and control signals
       busy       : OUT STD_LOGIC; --lcd controller busy/idle feedback
       rw, rs, e  : OUT STD_LOGIC; --read/write, setup/data, and enable for lcd
       lcd_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
  END COMPONENT;
BEGIN
  --instantiate the lcd controller for first line
  dut: lcd_controller
    PORT MAP(clk => clk, reset_n => '1', lcd_enable => lcd_enable, lcd_bus => lcd_bus, 
             busy => lcd_busy, rw => rw, rs => rs, e => e, lcd_data => lcd_data);
  
  PROCESS(clk)
    VARIABLE char   :  INTEGER RANGE 0 TO 57:= 0;
	 VARIABLE extra : STD_LOGIC_VECTOR(9 downto 0);
	 
	 --variables for the first 16 values
	 VARIABLE letter1a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter2a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter3a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter4a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter5a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter6a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter7a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter8a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter9a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter10a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter11a:  STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter12a :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter13a :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter14a :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter15a :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter16a :STD_LOGIC_VECTOR(9 downto 0);
	 --variables for the next 16 values
	 VARIABLE letter1b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter2b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter3b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter4b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter5b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter6b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter7b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter8b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter9b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter10b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter11b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter12b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter13b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter14b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter15b :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter16b :STD_LOGIC_VECTOR(9 downto 0);
	 --these are the variables for the decryption
	  VARIABLE letter1c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter2c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter3c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter4c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter5c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter6c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter7c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter8c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter9c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter10c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter11c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter12c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter13c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter14c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter15c :STD_LOGIC_VECTOR(9 downto 0);
	 VARIABLE letter16c :STD_LOGIC_VECTOR(9 downto 0);
	 
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN
      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
        lcd_enable <= '1';
        IF(char < 57) THEN
          char := char + 1;
        END IF;
		  
		  
		  letter1a := "1001001000"; --H
		  letter2a := "1001000101"; --E
		  letter3a := "1001001100"; --L
		  letter4a := "1001001100"; --L
		  letter5a := "1001001111"; --O
		  letter6a := "1000100000"; -- space
		  letter7a := "1001010111"; --W
		  letter8a := "1001001111"; --O
		  letter9a := "1001010010"; --R
		  letter10a := "1001001100"; --L
		  letter11a := "1001000100"; --D
		  letter12a := "1000100000"; --space
		  letter13a := "1000100000"; --space
		  letter14a := "1000100000"; --space
		  letter15a := "1000100000"; --space
		  letter16a := "1000100000"; --space
		  
		  --this catches errors when key shifts a letter past z
		  if letter1a + key > "1001011010" then
				extra := letter1a + key - "1001011010";
				letter1b := "1001000000" + extra;
		  else 
				letter1b := letter1a + key;
		  end if;
		  
		   if letter2a + key > "1001011010" then
				extra := letter2a + key - "1001011010";
				letter2b := "1001000000" + extra;
		  else 
				letter2b := letter2a + key;
		  end if;
		  
		   if letter3a + key > "1001011010" then
				extra := letter3a + key - "1001011010";
				letter3b := "1001000000" + extra;
		  else 
				letter3b := letter3a + key;
		  end if;
		  
		   if letter4a + key > "1001011010" then
				extra := letter4a + key - "1001011010";
				letter4b := "1001000000" + extra;
		  else 
				letter4b := letter4a + key;
		  end if;
		  
		   if letter5a + key > "1001011010" then
				extra := letter5a + key - "1001011010";
				letter5b := "1001000000" + extra;
		  else 
				letter5b := letter5a + key;
		  end if;
		  
		   if letter6a + key > "1001011010" then
				extra := letter6a + key - "1001011010";
				letter6b := "1001000000" + extra;
		  else 
				letter6b := letter6a + key;
		  end if;
		  
		   if letter7a + key > "1001011010" then
				extra := letter7a + key - "1001011010";
				letter7b := "1001000000" + extra;
		  else 
				letter7b := letter7a + key;
		  end if;
		  
		   if letter8a + key > "1001011010" then
				extra := letter8a + key - "1001011010";
				letter8b := "1001000000" + extra;
		  else 
				letter8b := letter8a + key;
		  end if;
		  
		   if letter9a + key > "1001011010" then
				extra := letter9a + key - "1001011010";
				letter9b := "1001000000" + extra;
		  else 
				letter9b := letter9a + key;
		  end if;
		  
		   if letter10a + key > "1001011010" then
				extra := letter10a + key - "1001011010";
				letter10b := "1001000000" + extra;
		  else 
				letter10b := letter10a + key;
		  end if;
		  
		   if letter11a + key > "1001011010" then
				extra := letter11a + key - "1001011010";
				letter11b := "1001000000" + extra;
		  else 
				letter11b := letter11a + key;
		  end if;
		  
		   if letter12a + key > "1001011010" then
				extra := letter12a + key - "1001011010";
				letter12b := "1001000000" + extra;
		  else 
				letter12b := letter12a + key;
		  end if;
		  
		   if letter13a + key > "1001011010" then
				extra := letter13a + key - "1001011010";
				letter13b := "1001000000" + extra;
		  else 
				letter13b := letter13a + key;
		  end if;
		  
		   if letter14a + key > "1001011010" then
				extra := letter14a + key - "1001011010";
				letter14b := "1001000000" + extra;
		  else 
				letter14b := letter14a + key;
		  end if;
		  
		   if letter15a + key > "1001011010" then
				extra := letter15a + key - "1001011010";
				letter15b := "1001000000" + extra;
		  else 
				letter15b := letter15a + key;
		  end if;
		  
		   if letter16a + key > "1001011010" then
				extra := letter16a + key - "1001011010";
				letter16b := "1001000000" + extra;
		  else 
				letter16b := letter16a + key;
		  end if;
		  
		  
		  --this catches errors when key decrypts past 
		  if letter1b - key < "1001000001" then
				extra := key - (letter1b - "1001000001");
				letter1c := "1001011011" - extra;
		  else 
				letter1c := letter1b - key;
		  end if;
		  if letter2b - key < "1001000001" then
				extra := key - (letter2b - "1001000001");
				letter2c := "1001011011" - extra;
		  else 
				letter2c := letter2b - key;
		  end if;
		  if letter3b - key < "1001000001" then
				extra := key - (letter3b - "1001000001");
				letter3c := "1001011011" - extra;
		  else 
				letter3c := letter3b - key;
		  end if;
		  if letter4b - key < "1001000001" then
				extra := key - (letter4b - "1001000001");
				letter4c := "1001011011" - extra;
		  else 
				letter4c := letter4b - key;
		  end if;
		  if letter5b - key < "1001000001" then
				extra := key - (letter5b - "1001000001");
				letter5c := "1001011011" - extra;
		  else 
				letter5c := letter5b - key;
		  end if;
		  if letter6b - key < "1001000001" then
				extra := key - (letter6b - "1001000001");
				letter6c := "1001011011" - extra;
		  else 
				letter6c := letter6b - key;
		  end if;
		  if letter7b - key < "1001000001" then
				extra := key - (letter7b - "1001000001");
				letter7c := "1001011011" - extra;
		  else 
				letter7c := letter7b - key;
		  end if;
		  if letter8b - key < "1001000001" then
				extra := key - (letter8b - "1001000001");
				letter8c := "1001011011" - extra;
		  else 
				letter8c := letter8b - key;
		  end if;
		  if letter9b - key < "1001000001" then
				extra := key - (letter9b - "1001000001");
				letter9c := "1001011011" - extra;
		  else 
				letter9c := letter9b - key;
		  end if;
		  if letter10b - key < "1001000001" then
				extra := key - (letter10b - "1001000001");
				letter10c := "1001011011" - extra;
		  else 
				letter10c := letter10b - key;
		  end if;
		  if letter11b - key < "1001000001" then
				extra := key - (letter11b - "1001000001");
				letter11c := "1001011011" - extra;
		  else 
				letter11c := letter11b - key;
		  end if;
		  if letter12b - key < "1001000001" then
				extra := key - (letter12b - "1001000001");
				letter12c := "1001011011" - extra;
		  else 
				letter12c := letter12b - key;
		  end if;
		  if letter13b - key < "1001000001" then
				extra := key - (letter13b - "1001000001");
				letter13c := "1001011011" - extra;
		  else 
				letter13c := letter13b - key;
		  end if;
		  if letter14b - key < "1001000001" then
				extra := key - (letter14b - "1001000001");
				letter14c := "1001011011" - extra;
		  else 
				letter14c := letter14b - key;
		  end if;
		  if letter15b - key < "1001000001" then
				extra := key - (letter15b - "1001000001");
				letter15c := "1001011011" - extra;
		  else 
				letter15c := letter15b - key;
		  end if;
		  if letter16b - key < "1001000001" then
				extra := key - (letter16b - "1001000001");
				letter16c := "1001011011" - extra;
		  else 
				letter16c := letter16b - key;
		  end if;
		   
	
		  
		  --this keeps spaces as spaces
		  if letter1a = "1000100000" then
				letter1b := "1000100000";
		  end if;
		  
		  if letter1b = "1000100000" then
				letter1c := "1000100000";
		  end if;
		  
		  if letter2a = "1000100000" then
				letter2b := "1000100000";
		  end if;
		  
		  if letter2b = "1000100000" then
				letter2c := "1000100000";
		  end if;
		  
		  if letter3a = "1000100000" then
				letter3b := "1000100000";
		  end if;
		  
		  if letter3b = "1000100000" then
				letter3c := "1000100000";
		  end if;
		  
		  if letter4a = "1000100000" then
				letter4b := "1000100000";
		  end if;
		  
		  if letter4b = "1000100000" then
				letter4c := "1000100000";
		  end if;
		  
		  if letter5a = "1000100000" then
				letter5b := "1000100000";
		  end if;
		  
		  if letter5b = "1000100000" then
				letter5c := "1000100000";
		  end if;
		  
		  if letter6a = "1000100000" then
				letter6b := "1000100000";
		  end if;
		  
		  if letter6b = "1000100000" then
				letter6c := "1000100000";
		  end if;
		  
		  if letter7a = "1000100000" then
				letter7b := "1000100000";
		  end if;
		  
		  if letter7b = "1000100000" then
				letter7c := "1000100000";
		  end if;
		  
		  if letter8a = "1000100000" then
				letter8b := "1000100000";
		  end if;
		  
		  if letter8b = "1000100000" then
				letter8c := "1000100000";
		  end if;
		  
		  if letter9a = "1000100000" then
				letter9b := "1000100000";
		  end if;
		  
		  if letter9b = "1000100000" then
				letter9c := "1000100000";
		  end if;
		  
		  if letter10a = "1000100000" then
				letter10b := "1000100000";
		  end if;
		  
		  if letter10b = "1000100000" then
				letter10c := "1000100000";
		  end if;
		  
		  if letter11a = "1000100000" then
				letter11b := "1000100000";
		  end if;
		  
		  if letter11b = "1000100000" then
				letter11c := "1000100000";
		  end if;
		  
		  if letter12a = "1000100000" then
				letter12b := "1000100000";
		  end if;
		  
		  if letter12b = "1000100000" then
				letter12c := "1000100000";
		  end if;
		  
		  if letter13a = "1000100000" then
				letter13b := "1000100000";
		  end if;
		  
		  if letter13b = "1000100000" then
				letter13c := "1000100000";
		  end if;
		  
		  if letter14a = "1000100000" then
				letter14b := "1000100000";
		  end if;
		  
		  if letter14b = "1000100000" then
				letter14c := "1000100000";
		  end if;
		  
		  if letter15a = "1000100000" then
				letter15b := "1000100000";
		  end if;
		  
		  if letter15b = "1000100000" then
				letter15c := "1000100000";
		  end if;
		  
		  if letter16a = "1000100000" then
				letter16b := "1000100000";
		  end if;
		  
		  if letter16b = "1000100000" then
				letter16c := "1000100000";
		  end if;
		  
		  
		  IF(decrypt = '0') THEN 
			  CASE char IS
				 WHEN 1 => lcd_bus <= letter1a; --H
				 WHEN 2 => lcd_bus <= letter2a; --E
				 WHEN 3 => lcd_bus <= letter3a;	--L
				 WHEN 4 => lcd_bus <= letter4a; --L
				 WHEN 5 => lcd_bus <= letter5a;	--O
				 WHEN 6 => lcd_bus <= letter6a;	-- space
				 WHEN 7 => lcd_bus <= letter7a;	--W
				 WHEN 8 => lcd_bus <= letter8a;	--O
				 WHEN 9 => lcd_bus <= letter9a;	--R
				 WHEN 10 => lcd_bus <= letter10a;	--L
				 WHEN 11 => lcd_bus <= letter11a;	--D
				 WHEN 12 => lcd_bus <= letter12a; -- space
				 WHEN 13 => lcd_bus <= letter13a; -- space
				 WHEN 14 => lcd_bus <= letter14a; -- space
				 WHEN 15 => lcd_bus <= letter15a; -- space
				 WHEN 16 => lcd_bus <= letter16a; -- space
		 
				--move to next line/set the DDRam address to 0x40
				 When 17 => lcd_bus <= "1000100000";
				 When 18 => lcd_bus <= "1000100000";
				 When 19 => lcd_bus <= "1000100000";
				 When 20 => lcd_bus <= "1000100000";
				 When 21 => lcd_bus <= "1000100000";
				 When 22 => lcd_bus <= "1000100000";
				 When 23 => lcd_bus <= "1000100000";
				 When 24 => lcd_bus <= "1000100000";
				 When 25 => lcd_bus <= "1000100000";
				 When 26 => lcd_bus <= "1000100000";
				 When 27 => lcd_bus <= "1000100000";
				 When 28 => lcd_bus <= "1000100000";
				 When 29 => lcd_bus <= "1000100000";
				 When 30 => lcd_bus <= "1000100000";
				 When 31 => lcd_bus <= "1000100000";
				 When 32 => lcd_bus <= "1000100000";
				 When 33 => lcd_bus <= "1000100000";
				 When 34 => lcd_bus <= "1000100000";
				 When 35 => lcd_bus <= "1000100000";
				 When 36 => lcd_bus <= "1000100000";
				 When 37 => lcd_bus <= "1000100000";
				 When 38 => lcd_bus <= "1000100000";
				 When 39 => lcd_bus <= "1000100000";
				 when 40 => lcd_bus <= "1000100000";
						 
				 --message on second line
				 WHEN 41 => lcd_bus <= letter1b; 
				 WHEN 42 => lcd_bus <= letter2b; 
				 WHEN 43 => lcd_bus <= letter3b;	
				 WHEN 44 => lcd_bus <= letter4b; 
				 WHEN 45 => lcd_bus <= letter5b;	
				 WHEN 46 => lcd_bus <= letter6b;	
				 WHEN 47 => lcd_bus <= letter7b;	
				 WHEN 48 => lcd_bus <= letter8b;	
				 WHEN 49 => lcd_bus <= letter9b;	
				 WHEN 50 => lcd_bus <= letter10b;	
				 WHEN 51 => lcd_bus <= letter11b;	
				 WHEN 52 => lcd_bus <= letter12b;
				 WHEN 53 => lcd_bus <= letter13b;
				 WHEN 54 => lcd_bus <= letter14b;
				 WHEN 55 => lcd_bus <= letter15b;
				 WHEN 56 => lcd_bus <= letter16b;
				 WHEN OTHERS => lcd_enable <= '0';
				 END CASE;
		  ELSE
			CASE char IS
				 WHEN 1 => lcd_bus <= letter1b; 
				 WHEN 2 => lcd_bus <= letter2b; 
				 WHEN 3 => lcd_bus <= letter3b;	
				 WHEN 4 => lcd_bus <= letter4b; 
				 WHEN 5 => lcd_bus <= letter5b;	
				 WHEN 6 => lcd_bus <= letter6b;	
				 WHEN 7 => lcd_bus <= letter7b;	
				 WHEN 8 => lcd_bus <= letter8b;	
				 WHEN 9 => lcd_bus <= letter9b;	
				 WHEN 10 => lcd_bus <= letter10b;	
				 WHEN 11 => lcd_bus <= letter11b;	
				 WHEN 12 => lcd_bus <= letter12b; 
				 WHEN 13 => lcd_bus <= letter13b; 
				 WHEN 14 => lcd_bus <= letter14b; 
				 WHEN 15 => lcd_bus <= letter15b; 
				 WHEN 16 => lcd_bus <= letter16b; 
		 
				--move to next line/set the DDRam address to 0x40
				 When 17 => lcd_bus <= "1000100000";
				 When 18 => lcd_bus <= "1000100000";
				 When 19 => lcd_bus <= "1000100000";
				 When 20 => lcd_bus <= "1000100000";
				 When 21 => lcd_bus <= "1000100000";
				 When 22 => lcd_bus <= "1000100000";
				 When 23 => lcd_bus <= "1000100000";
				 When 24 => lcd_bus <= "1000100000";
				 When 25 => lcd_bus <= "1000100000";
				 When 26 => lcd_bus <= "1000100000";
				 When 27 => lcd_bus <= "1000100000";
				 When 28 => lcd_bus <= "1000100000";
				 When 29 => lcd_bus <= "1000100000";
				 When 30 => lcd_bus <= "1000100000";
				 When 31 => lcd_bus <= "1000100000";
				 When 32 => lcd_bus <= "1000100000";
				 When 33 => lcd_bus <= "1000100000";
				 When 34 => lcd_bus <= "1000100000";
				 When 35 => lcd_bus <= "1000100000";
				 When 36 => lcd_bus <= "1000100000";
				 When 37 => lcd_bus <= "1000100000";
				 When 38 => lcd_bus <= "1000100000";
				 When 39 => lcd_bus <= "1000100000";
				 when 40 => lcd_bus <= "1000100000";
						 
				 --message on second line
				 WHEN 41 => lcd_bus <= letter1c; 
				 WHEN 42 => lcd_bus <= letter2c; 
				 WHEN 43 => lcd_bus <= letter3c;	
				 WHEN 44 => lcd_bus <= letter4c; 
				 WHEN 45 => lcd_bus <= letter5c;	
				 WHEN 46 => lcd_bus <= letter6c;	
				 WHEN 47 => lcd_bus <= letter7c;	
				 WHEN 48 => lcd_bus <= letter8c;	
				 WHEN 49 => lcd_bus <= letter9c;	
				 WHEN 50 => lcd_bus <= letter10c;	
				 WHEN 51 => lcd_bus <= letter11c;	
				 WHEN 52 => lcd_bus <= letter12c;
				 WHEN 53 => lcd_bus <= letter13c;
				 WHEN 54 => lcd_bus <= letter14c;
				 WHEN 55 => lcd_bus <= letter15c;
				 WHEN 56 => lcd_bus <= letter16c;
				 WHEN OTHERS => lcd_enable <= '0';
				 END CASE;
		END If;
	
		
      ELSE
        lcd_enable <= '0';
      END IF;
		
    END IF;
  END PROCESS;
  
END behavior;
