IMPORT $;
WeatherDS  := $.File_Composite.WeatherScoreDS;//weatherset
CrimeDS    := $.File_Composite.CrimeScoreDS;//crimeset
EdDS       := $.File_Composite.EducationScoreDS;
HealthDS   := $.File_Composite.HealthScoreDS;
myRec1:=RECORD
STRING30 State;
UNSIGNED AcciScore;
UNSIGNED DeathScore;
UNSIGNED TempScore;
UNSIGNED VPRC;
UNSIGNED PRR;
END;
myRec1 x1(WeatherDS l, CrimeDS r):=TRANSFORM
SELF.State:=l.State;
SELF.AcciScore:=l.AcciScore;
SELF.DeathScore:=l.DeaScore;
SELF.TempScore:=l.TempScore;
self.VPRC:=r.VPRC_SCORE;
self.prr:=r.prr_score;
END;
J1:=JOIN(WeatherDS, CrimeDS, LEFT.State=RIGHT.State, x1(LEFT, RIGHT));
J1;


myRec2:=RECORD
STRING30 State;
UNSIGNED AcciScore;
UNSIGNED DeathScore;
UNSIGNED TempScore;
UNSIGNED VPRC;
UNSIGNED PRR;
UNSIGNED BRtoDR_SCORE;
UNSIGNED PADScore;
end;

myRec2 x2(j1 l, HealthDS r):=TRANSFORM
SELF.State:=l.State;
SELF.AcciScore:=l.AcciScore;
SELF.DeathScore:=l.DeathScore;
SELF.TempScore:=l.TempScore;
self.VPRC:=l.VPRC;
self.prr:=l.prr;
SELF.BRtoDR_SCORE:=R.BRtoDR_SCORE;
SELF.PADScore:=R.PADScore
END;

J2:=JOIN(j1, HealthDS, LEFT.State=RIGHT.State, x2(LEFT, RIGHT));
j2;
//EDUCATION
myRec3:=RECORD
STRING30 State;
UNSIGNED AcciScore;
UNSIGNED DeathScore;
UNSIGNED TempScore;
UNSIGNED VPRC;
UNSIGNED PRR;
UNSIGNED BRtoDR_SCORE;
UNSIGNED PADScore;
UNSIGNED LiteracyScore;
UNSIGNED PrimaryPTR;
UNSIGNED SecondaryPTR;
UNSIGNED StudPerSchool;
end;

myRec3 x3(j2 l, EdDS r):=TRANSFORM
SELF.State:=l.State;
SELF.AcciScore:=l.AcciScore;
SELF.DeathScore:=l.DeathScore;
SELF.TempScore:=l.TempScore;
self.VPRC:=l.VPRC;
self.prr:=l.prr;
SELF.BRtoDR_SCORE:=L.BRtoDR_SCORE;
SELF.PADScore:=L.PADScore;
SELF.LiteracyScore:=R.LiteracyScore;
SELF.PrimaryPTR:=R.PrimPTRScore;
SELF.SECONDARYPTR:=R.SecPTRScore;
SELF.StudPerSchool:=R.StudentPerSchoolScore;
END;

J3:=JOIN(j2, EdDS, LEFT.STATE=RIGHT.STATE, x3(LEFT, RIGHT));
J3;

myRec4:=RECORD
STRING30 State;
UNSIGNED AcciScore;
UNSIGNED DeathScore;
UNSIGNED TempScore;
UNSIGNED VPRC;
UNSIGNED PRR;
UNSIGNED BRtoDR_SCORE;
UNSIGNED PADScore;
UNSIGNED LiteracyScore;
UNSIGNED PrimaryPTR;
UNSIGNED SecondaryPTR;
UNSIGNED StudPerSchool;
UNSIGNED ParadiseScore;
end;

myRec4 trans(j3 l):=transform
SELF.ParadiseScore:=L.AcciScore+L.DeathScore+L.TempScore+L.VPRC+L.PRR+L.BRtoDR_SCORE+L.PADScore+L.LiteracyScore+L.PrimaryPTR+L.SecondaryPTR+L.StudPerSchool;
SELF:=L;
END;

Paradise:=PROJECT(J3, TRANS(LEFT));
ParadiseSort:=SORT(Paradise,-ParadiseScore);
ParadiseSort;
/*
OUTPUT(ParadiseSort,,'~class::RDT::INTRO::ParadiseScores',NAMED('Output'),OVERWRITE);
 */