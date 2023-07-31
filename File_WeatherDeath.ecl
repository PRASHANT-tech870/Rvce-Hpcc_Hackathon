EXPORT File_WeatherDeath := MODULE
myRecord:=RECORD
STRING30 State;
UNSIGNED Deaths;
END;
EXPORT File:=DATASET('~class::rdt::intro::WeatherDeath.csv',myRecord,csv);
END;