EXPORT File_CrimeJuvenile:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED NoOfHomelessJuveniles;
UNSIGNED NoOfJuvenilesWithGuardian;
UNSIGNED NoOfJuvenilesAtHome;
UNSIGNED TotalArrestedJuveniles;
END;
EXPORT File:=DATASET('pr::crimejuvenile.csv',Layout, csv);
END;
