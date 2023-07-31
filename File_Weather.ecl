EXPORT File_Weather:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED sunnyAccidents;
UNSIGNED rainyAccidents;
UNSIGNED foggyAccidents;
UNSIGNED hailAccidents;
UNSIGNED otherAccidents;
UNSIGNED AvgTemperature;

END;
EXPORT File:=DATASET('~class::pr::intro::weather.csv',Layout,csv);
END;