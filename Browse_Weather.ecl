
import $;

Weather:=$.File_Weather.File;//this is browse file data
Area:=$.File_Area.File;
WeatherDeath:=$.File_WeatherDeath.File;
myRec:=RECORD
STRING30 State;
UNSIGNED sunnyAccidents;
UNSIGNED rainyAccidents;
UNSIGNED foggyAccidents;
UNSIGNED hailAccidents;
UNSIGNED otherAccidents;
UNSIGNED AvgTemperature;
UNSIGNED TotalAccidents;
UNSIGNED TempDeviation;

END;
myRec myTrans(Weather l):=TRANSFORM
SELF:=L;
SELF.TotalAccidents:=l.sunnyAccidents + l.rainyAccidents + l.foggyAccidents + l.hailAccidents + l.otherAccidents;
SELF.TempDeviation:=ABS(L.AvgTemperature - 25);
END;

Weather_Analyse:=PROJECT(Weather, myTrans(LEFT));



myRec3:=RECORD
Weather_Analyse.State;
Weather_Analyse.sunnyAccidents;
Weather_Analyse.rainyAccidents;
Weather_Analyse.foggyAccidents;
Weather_Analyse.hailAccidents;
Weather_Analyse.otherAccidents;
Weather_Analyse.AvgTemperature;
Weather_Analyse.TotalAccidents;
Weather_Analyse.TempDeviation;
UNSIGNED Deaths;
END;

myRec3 transf(Weather_Analyse l, WeatherDeath r):=transform
SELF.Deaths:=r.Deaths;
SELF:=L;
END;

 WeatherFinal:=JOIN(Weather_Analyse, WeatherDeath, LEFT.State=RIGHT.State, transf(LEFT, RIGHT));

//upto this point, we have accidents+deaths+temp deviation
myRecord1:=RECORD
WeatherFinal.State;
WeatherFinal.sunnyAccidents;
WeatherFinal.rainyAccidents;
WeatherFinal.foggyAccidents;
WeatherFinal.hailAccidents;
WeatherFinal.otherAccidents;
WeatherFinal.AvgTemperature;
WeatherFinal.TotalAccidents;
WeatherFinal.TempDeviation;
WeatherFinal.Deaths;
DECIMAL Area;
END;
myRecord1 transfo(WeatherFinal l, Area r):=transform
SELF.Area:=r.area;
SELF:=L;
END;
Weather_Area:=JOIN(WeatherFinal,Area, LEFT.State=RIGHT.State, transfo(LEFT,RIGHT));

myRec4:=RECORD
Weather_Area.State;
Weather_Area.sunnyAccidents;
Weather_Area.rainyAccidents;
Weather_Area.foggyAccidents;
Weather_Area.hailAccidents;
Weather_Area.otherAccidents;
Weather_Area.AvgTemperature;
Weather_Area.TotalAccidents;
Weather_Area.TempDeviation;
Weather_Area.Deaths;
Weather_Area.Area;
DECIMAL AccidentDensity:=ROUND(Weather_Area.TotalAccidents*1000/Weather_Area.Area);//SCALED TO 1000
UNSIGNED AcciScore:=0;
UNSIGNED DeaScore:=0;
UNSIGNED TempScore:=0;
END;
 WeatherFinal1:=Table(Weather_Area, myRec4);
//score calculation:

AccidentScore:=ITERATE(SORT(WeatherFinal1,-AccidentDensity),TRANSFORM(myRec4,
                                                                   SELF.AcciScore := IF(LEFT.AccidentDensity=RIGHT.AccidentDensity,LEFT.AcciScore,LEFT.AcciScore+1),
                                                                   SELF := RIGHT));
DeathScore:=ITERATE(SORT(AccidentScore,-Deaths),TRANSFORM(myRec4,
                                                                   SELF.DeaScore := IF(LEFT.Deaths=RIGHT.Deaths,LEFT.DeaScore,LEFT.DeaScore+1),
                                                                   SELF := RIGHT));
All_Scores_In_Weather:=ITERATE(SORT(DeathScore,-TempDeviation),TRANSFORM(myRec4,
                                                                   SELF.TempScore := IF(LEFT.TempDeviation=RIGHT.TempDeviation,LEFT.TempScore,LEFT.TempScore+1),
                                                                   SELF := RIGHT));
OUTPUT(All_Scores_In_Weather,,'~class::RDT::INTRO::All_Scores_In_Weather',NAMED('All_Scores_In_Weather'),OVERWRITE);                                                               
                                                                   