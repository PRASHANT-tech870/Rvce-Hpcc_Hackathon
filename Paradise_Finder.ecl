IMPORT $;
ParaIDX := $.File_Composite.IDX;

EXPORT Paradise_Finder() := FUNCTION
Parms := STORED($.Paradise_Interface);
RECORDOF(ParaIDX) CalcScore(ParaIDX Le) := TRANSFORM
 Asc  := IF(Parms.AcciScore,Le.AcciScore,0);
 DSCE  := IF(Parms.DeathScore,Le.DeathScore,0);
 TPS := IF(Parms.TempScore,Le.TempScore,0);
 VPRC   := IF(Parms.VPRC,Le.VPRC,0);
 PRR   := IF(Parms.PRR,Le.PRR,0);
 BRDR  := IF(Parms.BRtoDR_SCORE,Le.BRtoDR_SCORE,0);
 PAD   := IF(Parms.PADScore,Le.PADScore,0);
 LS   := IF(Parms.LiteracyScore,Le.LiteracyScore,0);
 PPTR   := IF(Parms.PrimaryPTR,Le.PrimaryPTR,0);
 SPTR:= IF(Parms.SecondaryPTR,Le.SecondaryPTR,0);
 SPS:=IF(Parms.StudPerSchool,Le.StudPerSchool,0);
 SELF.ParadiseScore := ASC + DSCE + TPS + VPRC + PRR + BRDR + LS + PPTR + SPTR+SPS;
 SELF := Le                       
END;

ParaCustom := PROJECT(ParaIDX,CalcScore(LEFT));

Res := IF(Parms.IWANT_ALL = TRUE,
          SORT(ParaIDX,-ParadiseScore),
          SORT(ParaCustom,-ParadiseScore));
   
RETURN Res;   
   
END;   