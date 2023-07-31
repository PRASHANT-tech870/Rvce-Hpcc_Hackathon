IMPORT $;

EXPORT File_Composite:=MODULE
CrimeScores:=RECORD
STRING    State;
UNSIGNED VPRC_SCORE;
UNSIGNED PRR_Score;
end;
EXPORT CrimeScoreDS := DATASET('~class::RDT::INTRO::CrimeScore',CrimeScores,thor);

HealthScore:=RECORD
STRING    State;
UNSIGNED BRtoDR_Score;
UNSIGNED PADScore;
end;
EXPORT HealthScoreDS := DATASET('~class::RDT::INTRO::Health_Score',HealthScore,thor);


WeatherScore:=Record
STRING    State;
UNSIGNED AcciScore;
UNSIGNED DeaScore;
UNSIGNED TempScore;
end;
EXPORT WeatherScoreDS := DATASET('~class::RDT::INTRO::All_Scores_In_Weather',WeatherScore,thor);

EducationScore := RECORD
STRING   State;
UNSIGNED LiteracyScore;
UNSIGNED PrimPTRScore;
UNSIGNED SecPTRScore;
UNSIGNED StudentPerSchoolScore;
END;
EXPORT EducationScoreDS := DATASET('~class::RDT::INTRO::FinalEduData',EducationScore,thor);

export Layout:=RECORD
STRING    State;
UNSIGNED VPRC;
UNSIGNED PRR;
UNSIGNED BRtoDR_Score;
UNSIGNED PADScore;
UNSIGNED AcciScore;
UNSIGNED DeathScore;
UNSIGNED TempScore;
UNSIGNED LiteracyScore;
UNSIGNED primaryPTR;
UNSIGNED secondaryPTR;
UNSIGNED StudPerSchool;
UNSIGNED ParadiseScore;
END;
 EXPORT File    := DATASET('~class::RDT::INTRO::ParadiseScores',Layout,thor);
 EXPORT IDX     := INDEX(File,{ParadiseScore},{File},'~class::RDT::INTRO::ParadiseScores');
 EXPORT BLD_IDX := BUILD(IDX,OVERWRITE);
 end;