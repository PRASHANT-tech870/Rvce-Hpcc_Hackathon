EXPORT File_EDUCAT := MODULE
 EXPORT Layout := RECORD
    STRING state;
    UNSIGNED Totalboardsofeducation;
    UNSIGNED IntermediateSecSchools;
    UNSIGNED HigherSecSchools;
    UNSIGNED UpperPrimarySchools;
    UNSIGNED PrimarySchools;
    UNSIGNED PrePrimarySchools;
    UNSIGNED PrimaryPTRratio;
    UNSIGNED SecondaryPTRratio;
END;

EXPORT File:= DATASET('~class::rdt::intro::educat.csv',Layout,csv);
END;