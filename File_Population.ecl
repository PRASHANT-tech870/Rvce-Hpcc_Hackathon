EXPORT File_Population:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED Population;

END;
EXPORT File:=DATASET('~class::pr::intro::population.csv',Layout,csv);
END;