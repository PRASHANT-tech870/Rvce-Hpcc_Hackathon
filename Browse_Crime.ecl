//JoinCrime
IMPORT $;
CrimeHomicide:=$.File_CrimeHomicide.File;//left1
CrimeJuvenile:=$.File_CrimeJuvenile.File;//right1
//the above is now one table
CrimeProperty:=$.File_CrimeProperty.File;//this is right2
//the above is table two. which is the new left table for join 3
CrimeRape:=$.File_CrimeRape.File;//this becomes the final right table
Population:=$.File_Population.File;
EXPORT Browse_Crime:=MODULE
myRecCrime1:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED No_Of_Homicides;
UNSIGNED No_Of_Living_With_Parents;
UNSIGNED No_Of_JuvenileCrimes;

END;


myRecCrime1 transCrime(CrimeHomicide l,CrimeJuvenile r):=TRANSFORM//records of join1
SELF.State:=l.State;
SELF.Year:=l.Year;
SELF.No_Of_Homicides:=l.NoOfHomicides;
SELF.No_Of_Living_With_Parents:=r.NoOfJuvenilesAtHome;
SELF.No_Of_JuvenileCrimes:=r.TotalArrestedJuveniles;
END;

join1:=JOIN(CrimeHomicide, CrimeJuvenile, LEFT.State=RIGHT.State AND LEFT.Year=RIGHT.Year, transCrime(LEFT,RIGHT));
//join1;


//definition of join2
myRecCrime2:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED No_Of_Homicides;
UNSIGNED No_Of_Living_With_Parents;
UNSIGNED No_Of_JuvenileCrimes;
UNSIGNED No_Of_Property_Stolen;
UNSIGNED No_Of_Property_Recovered;
END;

myRecCrime2 transCrime2(join1 l,CrimeProperty r):=TRANSFORM//records of join1
SELF.State:=l.State;
SELF.Year:=l.Year;
SELF.No_Of_Homicides:=l.No_Of_Homicides;
SELF.No_Of_Living_With_Parents:=l.No_Of_Living_With_Parents;
SELF.No_Of_JuvenileCrimes:=l.No_Of_JuvenileCrimes;
SELF.No_Of_Property_Stolen:=r.PropertyStolen;
SELF.No_Of_Property_Recovered:=r.PropertyRecovered;
END;

join2:=JOIN(join1,CrimeProperty,LEFT.State=RIGHT.State AND LEFT.Year=RIGHT.Year, transCrime2(LEFT,RIGHT));

//final crime join to be performed here
myRecCrime3:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED No_Of_Homicides;
UNSIGNED No_Of_Living_With_Parents;
UNSIGNED No_Of_JuvenileCrimes;
UNSIGNED No_Of_Property_Stolen;
UNSIGNED No_Of_Property_Recovered;
UNSIGNED No_Of_RapeCases;
END;

myRecCrime3 transCrime3(join2 l,CrimeRape r):=TRANSFORM//records of join1
SELF.State:=l.State;
SELF.Year:=l.Year;
SELF.No_Of_Homicides:=l.No_Of_Homicides;
SELF.No_Of_Living_With_Parents:=l.No_Of_Living_With_Parents;
SELF.No_Of_JuvenileCrimes:=l.No_Of_JuvenileCrimes;
SELF.No_Of_Property_Stolen:=l.No_Of_Property_Stolen;
SELF.No_Of_Property_Recovered:=l.No_Of_Property_Recovered;
SELF.No_Of_RapeCases:=r.RapeCases;
END;

join3:=JOIN(join2, CrimeRape, LEFT.State=RIGHT.State AND LEFT.Year=RIGHT.Year, transCrime3(LEFT,RIGHT));
//this table consists of all the major crimes statewise across India.

//let us now join population data to it
myRecCrime4:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED No_Of_Homicides;
UNSIGNED No_Of_Living_With_Parents;
UNSIGNED No_Of_JuvenileCrimes;
UNSIGNED No_Of_Property_Stolen;
UNSIGNED No_Of_Property_Recovered;
UNSIGNED No_Of_RapeCases;
UNSIGNED Population;
END;

myRecCrime4 trans(join3 l, Population r):=TRANSFORM
SELF:=l;
SELF.Population:=r.Population;
END;

EXPORT Join4:=JOIN(join3, Population, LEFT.State=RIGHT.State AND LEFT.Year=RIGHT.Year, trans(LEFT,RIGHT));
END;

/*//Population added to the factors-usage of %danger.= vics/pops*100
myRecCrime5:=RECORD
STRING30 State;
UNSIGNED Year;
UNSIGNED No_Of_Homicides;
UNSIGNED No_Of_Living_With_Parents;
UNSIGNED No_Of_JuvenileCrimes;
UNSIGNED No_Of_Property_Stolen;
UNSIGNED No_Of_Property_Recovered;
UNSIGNED No_Of_RapeCases;
UNSIGNED Population;
DECIMAL ViolentCrimePRC;
DECIMAL PropertyRecoveredRatio;
END;
myRecCrime5 myTrans(join4 l):=TRANSFORM
SELF.ViolentCrimePRC:=((l.No_Of_Homicides+l.No_Of_RapeCases+l.No_Of_JuvenileCrimes)*1000000/ l.Population);
SELF.PropertyRecoveredRatio:=(l.No_Of_Property_Recovered/l.No_Of_Property_Stolen)*100;
SELF:=l;
END;

 Join5:=PROJECT(join4, myTrans(LEFT));

//

 myRec7:=RECORD
Join5.State;
DECIMAL AvgVPRC:=ROUND(AVE(GROUP,Join5.ViolentCrimePRC));
DECIMAL AvgPRR:=ROUND(AVE(GROUP,Join5.PropertyRecoveredRatio));
END;

Join_New:=TABLE(Join5, myRec7, State);
Crime_Final2:=SORT(TABLE(Join5, myRec7, State), State);
//till here analyse crime
//assignment of scores based on Violent Crimes per person(as a scale of 100000) and Property Recovered Ratio


MyRec9:=RECORD
STRING30 State:=Crime_Final2.State;
UNSIGNED AvgVPRC:= Crime_Final2.AvgVPRC;
UNSIGNED AvgPRR:=Crime_Final2.AvgPRR;
UNSIGNED VPRC_SCORE:=0;
UNSIGNED PRR_SCORE:=0;
END;
Crime_Final:=TABLE(Crime_Final2, myRec9);
AddVPRC_Score := ITERATE(SORT(Crime_Final,-AvgVPRC),TRANSFORM(MyRec9,
                                                                   SELF.VPRC_SCORE := IF(LEFT.AvgVPRC=RIGHT.AvgVPRC,LEFT.VPRC_SCORE,LEFT.VPRC_SCORE+1),
                                                                   SELF := RIGHT));             

AddPRR_Score:=ITERATE(SORT(AddVPRC_Score,AvgPRR),TRANSFORM(MyRec9,
                                                                   SELF.PRR_SCORE := IF(LEFT.AvgPRR=RIGHT.AvgPRR,LEFT.PRR_SCORE,LEFT.PRR_SCORE+1),
                                                                   SELF := RIGHT));  
                                                                
AddPRR_Score;*/
