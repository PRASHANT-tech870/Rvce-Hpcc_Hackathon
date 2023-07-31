EXPORT File_CrimeHomicide:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED NoOfHomicides;

END;
EXPORT File:=DATASET('pr::crimehomicide.csv',Layout,csv);
END;