IMPORT $;
Crime_Final2:=$.Analyse_Crime.Crime_Final2;

MyRec9:=RECORD
STRING30 State:=Crime_Final2.State;
UNSIGNED AvgVPRC:= Crime_Final2.AvgVPRC;
UNSIGNED AvgPRR:=Crime_Final2.AvgPRR;
UNSIGNED VPRC_SCORE:=0;
UNSIGNED PRR_SCORE:=0;
END;
Crime_Final:=TABLE(Crime_Final2, myRec9);
AddVPRC_Score := ITERATE(SORT(Crime_Final,-AvgVPRC),TRANSFORM(MyRec9, SELF.VPRC_SCORE := IF(LEFT.AvgVPRC=RIGHT.AvgVPRC,LEFT.VPRC_SCORE,LEFT.VPRC_SCORE+1),
                         SELF := RIGHT));             

CrimeScore:=ITERATE(SORT(AddVPRC_Score,AvgPRR),TRANSFORM(MyRec9,SELF.PRR_SCORE := IF(LEFT.AvgPRR=RIGHT.AvgPRR,LEFT.PRR_SCORE,LEFT.PRR_SCORE+1),
                             SELF := RIGHT));  
                                                                
OUTPUT(CrimeScore,,'~class::RDT::INTRO::CrimeScore',NAMED('TopCrime'),OVERWRITE);