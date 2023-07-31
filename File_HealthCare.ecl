EXPORT File_HealthCare := MODULE
 EXPORT Layout := RECORD
    STRING state;
    decimal BirthRate;
    decimal DeathRate;
    UNSIGNED TotalDoctors;
    UNSIGNED Population;
    
END;

EXPORT File:= DATASET('~class::rdt::intro::healthcare.csv',Layout,csv);
END;