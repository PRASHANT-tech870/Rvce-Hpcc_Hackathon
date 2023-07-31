
EXPORT File_CrimeProperty:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED PropertyRecovered;
UNSIGNED PropertyStolen;

END;
EXPORT File:=DATASET('pr::crimeproperty.csv',Layout, csv);
END;