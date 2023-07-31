IMPORT $;
J4:=$.BROWSE_cRIME.Join4;
EXPORT Analyse_Crime:=MODULE
myRecCrime5:=RECORD
 j4.State;
 j4.Year;
 j4.No_Of_Homicides;
 j4.No_Of_Living_With_Parents;
 j4.No_Of_JuvenileCrimes;
 j4.No_Of_Property_Stolen;
 j4.No_Of_Property_Recovered;
 j4.No_Of_RapeCases;
 j4.Population;
DECIMAL ViolentCrimePRC;
DECIMAL PropertyRecoveredRatio;
END;



myRecCrime5 myTrans(j4 l):=TRANSFORM
SELF.ViolentCrimePRC:=((l.No_Of_Homicides+l.No_Of_RapeCases+l.No_Of_JuvenileCrimes)*1000000/ l.Population);
SELF.PropertyRecoveredRatio:=(l.No_Of_Property_Recovered/l.No_Of_Property_Stolen)*100;
SELF:=l;
END;

Join5:=PROJECT(j4, myTrans(LEFT));


 myRec7:=RECORD
Join5.State;
DECIMAL AvgVPRC:=ROUND(AVE(GROUP,Join5.ViolentCrimePRC));
DECIMAL AvgPRR:=ROUND(AVE(GROUP,Join5.PropertyRecoveredRatio));
END;

Join_New:=TABLE(Join5, myRec7, State);
EXPORT Crime_Final2:=SORT(TABLE(Join5, myRec7, State), State);
END;
output(Join5);