IMPORT $;
Health_Final:=$.Analyse_Health.Health_Final;

myRec2:=RECORD
     Health_Final.State;
     Health_Final.BirthRate;
     Health_Final.DeathRate;
     Health_Final.TotalDoctors;
     Health_Final.Population;
     Health_Final.BRtoDR_ratio_scaled100;  //birth rate by death rate ratio-parameter1
     Health_Final.PeopleAssignedto1doc;
    //No. of people assigned to one doctor-parameter2
    UNSIGNED BRtoDR_Score:=0;
    UNSIGNED PADScore:=0;
    
END;
Add_Score_brtodr := ITERATE(SORT(Health_Final,-BRtoDR_ratio_scaled100),TRANSFORM(myRec2,
                                                                   SELF.BRtoDR_Score := IF(LEFT.BRtoDR_ratio_scaled100=RIGHT.BRtoDR_ratio_scaled100,LEFT.BRtoDR_Score,LEFT.BRtoDR_Score+1),
                                                                   SELF := RIGHT));  
Health_Score := ITERATE(SORT(Add_Score_brtodr,-PeopleAssignedto1doc),TRANSFORM(myRec2,
                                                                   SELF.PADScore := IF(LEFT.PeopleAssignedto1doc=RIGHT.PeopleAssignedto1doc,LEFT.PADScore,LEFT.PADScore+1),
                                                                   SELF := RIGHT));
OUTPUT(Health_Score,,'~class::RDT::INTRO::Health_Score',NAMED('Health_Score'),OVERWRITE); 