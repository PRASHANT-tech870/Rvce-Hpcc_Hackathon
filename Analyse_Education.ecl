
IMPORT $;
Education:=$.File_EDUCAT.File;
Literate:=$.File_Literacy.File;
EXPORT Analyse_Education:=MODULE
myRecEd:=RECORD
    STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
    UNSIGNED PrimaryPTRratio;
    UNSIGNED SecondaryPTRratio;
    UNSIGNED TotalPrimary;
    UNSIGNED TotalSecondary;
    
 END;
 myRecEd tran(Education l):=TRANSFORM
 SELF.TotalSecondary:=l.IntermediateSecSchools+ l.HigherSecSchools;
 SELF.TotalPrimary:=l.UpperPrimarySchools + l.PrimarySchools + l.PrePrimarySchools;
 SELF:=l;
 END;
 x:=PROJECT(Education, tran(LEFT));
 
 
Student:=$.File_Students.File;


myRec:=RECORD
STRING30 State;
UNSIGNED TotalStudents;
UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
END;

myTab:= DATASET([{'ANDAMAN AND NICOBAR ISLANDS', 73861, 6885, 25964, 17719, 11810, 11483}], MyRec);
x2:=SORT(Student, State);
BWR_STUDENTS:=MERGE(X2, MYTAB, SORTED(State));
myRec2:=RECORD
STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
UNSIGNED PrimaryPTRratio;
UNSIGNED SecondaryPTRratio;
UNSIGNED TotalPrimary;
UNSIGNED TotalSecondary;

UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
UNSIGNED Total_Students;
END; 

MYREC2 tranS(x l, bwr_students r):=TRANSFORM
SELF.State:=l.state;
    SELF.Totalboardsofeducation:=L.Totalboardsofeducation;
    SELF.IntermediateSecSchools:=L.IntermediateSecSchools;
    SELF.HigherSecSchools:=L.HigherSecSchools;
    SELF.UpperPrimarySchools:=L.UpperPrimarySchools;
    SELF.PrimarySchools:=L.PrimarySchools;
    SELF.PrePrimarySchools:=L.PrePrimarySchools;
SELF.PrimaryPTRratio:=L.PrimaryPTRratio;
SELF.SecondaryPTRratio:=L.SecondaryPTRratio;
SELF.TotalPrimary:=L.TotalPrimary;
SELF.TotalSecondary:=L.TotalSecondary;
SELF.PreprimaryStudents:=R.PreprimaryStudents;
SELF.PrimaryStudents:=R.PrimaryStudents;
SELF.UpperPrimaryStudents:=R.UpperPrimaryStudents;
SELF.SecStudents:=R.SecStudents;
SELF.HigherSecStudents:=R.HigherSecStudents;
SELF.Total_Students:=R.PreprimaryStudents+ R.PrimaryStudents+R.UpperPrimaryStudents+R.SecStudents+R.HigherSecStudents;
END;
student_education:=JOIN(X, BWR_STUDENTS, LEFT.STATE=RIGHT.STATE, tranS(LEFT, RIGHT));


myRec6:=RECORD
STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
UNSIGNED PrimaryPTRratio;
UNSIGNED SecondaryPTRratio;
UNSIGNED TotalPrimary;
UNSIGNED TotalSecondary;

UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
UNSIGNED TotalSchools;
UNSIGNED Total_Students;


END; 

myRec6 Tras(student_education L):=TRANSFORM
SELF.TotalSchools:=l.TotalPrimary+l.TotalSecondary;
SELF:=L;
END;

schools_without_literacy:=PROJECT(student_education, tras(LEFT));


myRec7:=RECORD
STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
UNSIGNED PrimaryPTRratio;
UNSIGNED SecondaryPTRratio;
UNSIGNED TotalPrimary;
UNSIGNED TotalSecondary;

UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
UNSIGNED TotalSchools;
UNSIGNED Total_Students;
UNSIGNED StudentsPerSchool;

END; 
myRec7 tran4(schools_without_literacy L):=TRANSFORM
SELF.StudentsPerSchool:=l.Total_Students/l.TotalSchools;
SELF:=L;
END;

new_without_literacy:=PROJECT(schools_without_literacy, tran4(LEFT));



MYREC8:=RECORD
STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
UNSIGNED PrimaryPTRratio;
UNSIGNED SecondaryPTRratio;
UNSIGNED TotalPrimary;
UNSIGNED TotalSecondary;

UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
UNSIGNED TotalSchools;
UNSIGNED Total_Students;
UNSIGNED StudentsPerSchool;
UNSIGNED LiteracyRate;
END;

MYREC8 tran8(new_without_literacy l, literate r):=TRANSFORM
SELF.LiteracyRate:=r.LiteracyRate;
SELF:=l;
END;

EXPORT lm := JOIN(new_without_literacy,literate, LEFT.State=RIGHT.State, tran8(LEFT, RIGHT));

END;                                                                 
                                                                   