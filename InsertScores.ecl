IMPORT $;
WeatherDS  := $.File_Composite.WeatherScoreDS;
CrimeDS    := $.File_Composite.CrimeScoreDS;
EdDS       := $.File_Composite.EducationScoreDS;
HealthDS   := $.File_Composite.HealthScoreDS;
CombLayout := $.File_Composite.Layout;


OUTPUT(MergeWeather,NAMED('AddStateToWeather'));
