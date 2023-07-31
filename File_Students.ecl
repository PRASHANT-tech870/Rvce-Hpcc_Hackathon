EXPORT File_Students:=MODULE
EXPORT Layout:=RECORD
STRING30 State;
UNSIGNED TotalStudents;
UNSIGNED PreprimaryStudents;
UNSIGNED PrimaryStudents;
UNSIGNED UpperPrimaryStudents;
UNSIGNED SecStudents;
UNSIGNED HigherSecStudents;
END;
EXPORT File:=DATASET('~class::rdt::intro::students.csv',Layout,csv);
END;