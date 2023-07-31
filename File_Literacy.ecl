EXPORT File_literacy := MODULE
 EXPORT Layout := RECORD
    STRING state;
    decimal LiteracyRate;
  
    
END;

EXPORT File:= DATASET('~class::rdt::intro::literacy.csv',Layout,csv);
END;