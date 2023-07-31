IMPORT $;
Student:=$.File_Students.File;
Student;

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

