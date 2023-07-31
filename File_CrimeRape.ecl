EXPORT File_CrimeRape:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED RapeCases;

END;
EXPORT File:=DATASET('pr::crimerape.csv',Layout, csv);
END;