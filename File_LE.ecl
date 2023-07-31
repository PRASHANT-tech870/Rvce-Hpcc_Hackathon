EXPORT File_LifeExpectancy:= MODULE
 EXPORT Layout := RECORD
    STRING state;
    decimal LE;
  
    
END;

EXPORT File:= DATASET('~class::rdt::intro::LifeExpectancy.csv',Layout,csv);
END;