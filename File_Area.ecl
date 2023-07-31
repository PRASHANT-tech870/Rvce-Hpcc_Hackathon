EXPORT File_Area:= MODULE
 EXPORT Layout := RECORD
    STRING state;
    unsigned area;
  
    
END;

EXPORT File:= DATASET('~class::rdt::intro::area.csv',Layout,csv);
END;