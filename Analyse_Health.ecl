//JoinCrime
IMPORT $;
EXPORT Analyse_Health:=MODULE
Health:=$.File_HealthCare.File;
myRec:=RECORD
    STRING State;
    decimal BirthRate;
    decimal DeathRate;
    UNSIGNED TotalDoctors;
    UNSIGNED Population;
    DECIMAL BRtoDR_ratio_scaled100;  //birth rate by death rate ratio-parameter1
    DECIMAL PeopleAssignedto1doc;  //No. of people assigned to one doctor-parameter2
END;
myRec tran(Health l):=TRANSFORM
SELF.State:=l.State;
SELF.BirthRate:=l.BirthRate;
SELF.DeathRate:=l.DeathRate;
SELF.TotalDoctors:=l.TotalDoctors;
SELF.Population:=l.Population;
SELF.BRtoDR_ratio_scaled100:=ROUND(l.BirthRate*100/l.DeathRate);
SELF.PeopleAssignedto1doc:=ROUND(l.Population/l.TotalDoctors);
END;
x:=PROJECT(Health, tran(LEFT));
//entire health data of India



//assignment of scores
myRec2:=RECORD
     x.State;
     x.BirthRate;
     x.DeathRate;
     x.TotalDoctors;
     x.Population;
     x.BRtoDR_ratio_scaled100;  //birth rate by death rate ratio-parameter1
     x.PeopleAssignedto1doc;
    //No. of people assigned to one doctor-parameter2
    UNSIGNED BRtoDR_Score:=0;
    UNSIGNED PADScore:=0;
    
END;

//scores:
EXPORT Health_Final:=TABLE(x, myRec2);
END;