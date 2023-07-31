IMPORT $;
WeatherFinal1:=Table(Weather_Area, myRec4);
AccidentScore:=ITERATE(SORT(WeatherFinal1,-AccidentDensity),TRANSFORM(myRec4,
                                                                   SELF.AcciScore := IF(LEFT.AccidentDensity=RIGHT.AccidentDensity,LEFT.AcciScore,LEFT.AcciScore+1),
                                                                   SELF := RIGHT));
DeathScore:=ITERATE(SORT(AccidentScore,-Deaths),TRANSFORM(myRec4,
                                                                   SELF.DeaScore := IF(LEFT.Deaths=RIGHT.Deaths,LEFT.DeaScore,LEFT.DeaScore+1),
                                                                   SELF := RIGHT));
All_Scores_In_Weather:=ITERATE(SORT(DeathScore,-TempDeviation),TRANSFORM(myRec4,
                                                                   SELF.TempScore := IF(LEFT.TempDeviation=RIGHT.TempDeviation,LEFT.TempScore,LEFT.TempScore+1),
                                                                   SELF := RIGHT));
All_Scores_In_Weather;                                                                   
                                        