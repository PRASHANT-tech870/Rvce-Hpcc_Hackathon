IMPORT $;
//score assignment
lm:=$.Analyse_Education.lm;
MYREC9:=RECORD
 lm.state;

 lm.PrimaryPTRratio;
 lm.SecondaryPTRratio;
 lm.TotalPrimary;
 lm.TotalSecondary;

 lm.TotalSchools;
 lm.Total_Students;
 lm.StudentsPerSchool;
 lm.LiteracyRate;
UNSIGNED LiteracyScore:=0;
UNSIGNED PrimPTRScore:=0;
UNSIGNED SecPTRScore:=0;
UNSIGNED StudentPerSchoolScore:=0
END;

Edu_With_Scores1:=TABLE(lm, myRec9);
LitScore:=ITERATE(SORT(Edu_With_Scores1,LiteracyRate),TRANSFORM(myRec9,
                                                                   SELF.LiteracyScore := IF(LEFT.LiteracyRate=RIGHT.LiteracyRate,LEFT.LiteracyScore,LEFT.LiteracyScore+1),
                                                                   SELF := RIGHT));
PriPTRScore:=ITERATE(SORT(LitScore,-PrimaryPTRratio),TRANSFORM(myRec9,
                                                                   SELF.PrimPTRScore := IF(LEFT.PrimaryPTRratio=RIGHT.PrimaryPTRratio,LEFT.PrimPTRScore,LEFT.PrimPTRScore+1),
                                                                   SELF := RIGHT));
SecPTRSc:=ITERATE(SORT(PriPTRScore,-SecondaryPTRratio),TRANSFORM(myRec9,
                                                                   SELF.SecPTRScore := IF(LEFT.SecondaryPTRratio=RIGHT.SecondaryPTRratio,LEFT.SecPTRScore,LEFT.SecPTRScore+1),
                                                                   SELF := RIGHT));   
Final_Edu_Data:=ITERATE(SORT(SecPTRSc,-StudentsPerSchool),TRANSFORM(myRec9,
                                                                   SELF.StudentPerSchoolScore := IF(LEFT.StudentsPerSchool=RIGHT.StudentsPerSchool,LEFT.StudentPerSchoolScore,LEFT.StudentPerSchoolScore+1),
                                                                   SELF := RIGHT));
OUTPUT(Final_Edu_Data,,'~class::RDT::INTRO::FinalEduData',NAMED('EduScore'),OVERWRITE); 