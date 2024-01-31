select *
from HealthCare.[dbo].[patient_satisfaction_2018$];

select *
from HealthCare.[dbo].[patient_satisfaction_2019$];

select *
from HealthCare.[dbo].[patient_satisfaction_2020$];
--lets look at the data in the tables first 

select distinct state
from HealthCare.[dbo].[patient_satisfaction_2018$];

select distinct hospitaltype, HospitalOwnership, avg(hospitaloverallrating) as hospitalrating
from HealthCare.[dbo].[patient_satisfaction_2018$]
group by hospitaltype, HospitalOwnership
order by avg(hospitaloverallrating) desc;

--lets see if avg rating went down from 2018 to 2020
select distinct hospitaltype, HospitalOwnership, avg(hospitaloverallrating) as hospitalrating
from HealthCare.[dbo].[patient_satisfaction_2020$]
group by hospitaltype, HospitalOwnership
order by avg(hospitaloverallrating) desc;

select hospitaltype, hospitaloverallrating 
from HealthCare.[dbo].[patient_satisfaction_2018$]
where hospitaltype = 'Childrens' or hospitaltype = 'Critical Access Hospitals';

--lets take a further look at the hcahps section
select distinct hcahpsmeasureid
from HealthCare.[dbo].[patient_satisfaction_2018$];

select distinct hcahpsquestion
from HealthCare.[dbo].[patient_satisfaction_2018$];

select distinct hcahpsanswerdescription
from HealthCare.[dbo].[patient_satisfaction_2018$];

--lets look at some different average ratings 
--first query does not work ,column is of type nvarchar so we cannot 
--aggreagte it 
select distinct hospitaltype, HospitalOwnership, 
 AVG(CAST(patientsurveystarrating AS FLOAT)) as patientrating
from HealthCare.[dbo].[patient_satisfaction_2020$]
group by hospitaltype, HospitalOwnership;

select (Mortalitynationalcomparison),
count(*) as Mcount
from HealthCare.[dbo].[patient_satisfaction_2020$]
group by Mortalitynationalcomparison;

--lets look at mortality by hospital type 
select distinct hospitaltype, HospitalOwnership, avg(hospitaloverallrating) as hospitalrating,
Mortalitynationalcomparison, count(*) as Mcount
from HealthCare.[dbo].[patient_satisfaction_2018$]
group by hospitaltype, HospitalOwnership, Mortalitynationalcomparison
order by avg(hospitaloverallrating) desc;

--union trial
select HCAHPSAnswerPercent
from HealthCare.[dbo].[patient_satisfaction_2019$]
union all
select HCAHPSAnswerPercent
from HealthCare.[dbo].[patient_satisfaction_2020$]
-- brings just the answer percent field with something to join it on

--compare rating from year to year 
select distinct hospitaltype, HospitalOwnership, 
avg(hospitaloverallrating) as hospitalrating,
year
from HealthCare.[dbo].[patient_satisfaction_2018$]
group by hospitaltype, HospitalOwnership, year
union all
select distinct hospitaltype, HospitalOwnership, 
avg(hospitaloverallrating) as hospitalrating,
year
from HealthCare.[dbo].[patient_satisfaction_2019$]
group by hospitaltype, HospitalOwnership, year
order by avg(hospitaloverallrating) desc;

--see avg rating by state
select distinct state, avg(hospitaloverallrating)
from HealthCare.[dbo].[patient_satisfaction_2018$]
group by state
order by avg(hospitaloverallrating) desc;

--fixed the uanble to join thing, nvarchar type of hcahpspercent from 2018 and before
--float type of same column in 2019 and 2020 data
select cast(HCAHPSAnswerPercent as nvarchar(max)) as perccent
from HealthCare.[dbo].[patient_satisfaction_2020$]
union all
select cast(HCAHPSAnswerPercent as nvarchar(max)) as perccent
from HealthCare.[dbo].[patient_satisfaction_2019$]
union all
select HCAHPSAnswerPercent
from HealthCare.[dbo].[patient_satisfaction_2018$]

--complete query

select FacilityID, FacilityName, Address, 
City, State, ZipCode, CountyName,
HCAHPSMeasureID, HCAHPSQuestion, 
HCAHPSAnswerDescription as HCAHPSAnswer, 
PatientSurveyStarRating as SurveyRating, 
HCAHPSAnswerPercent,
HCAHPSLinearmeanvalue as HCAHPSMean, 
numberofcompletedsurveys as NumberCompletedSurvey,
surveyresponseratepercent as SurveyResponseRate, 
StartDate, EndDate,
Year, HospitalType, 
HospitalOwnership, EmergencyServices, 
meetscriteriaforpromotinginteroperabilityofehrs as EHRCriteriaMet,
HospitalOverallRating, hospitaloverallratingfootnote as HospitalOverallFootnotes,
Mortalitynationalcomparison as Mortality_v_National,
safetyofcarenationalcomparison as Safety_v_National, 
readmissionnationalcomparison as Readmission_v_National,
patientexperiencenationalcomparison as PatientExperience,
effectivenessofcarenationalcomparison as CareEffectiveness,
timelinessofcarenationalcomparison as CareTimeliness, 
efficientuseofmedicalimagingnationalcomparison as MedicalImagingUse
from HealthCare.[dbo].[patient_satisfaction_2018$]
where HCAHPSLinearmeanvalue  <> 'Not Applicable'
and HCAHPSLinearmeanvalue <> 'Not available'



--union attempt - final
--this works
select facilityid, facilityname,address,
City, State, ZipCode, CountyName,
HCAHPSMeasureID, HCAHPSQuestion, 
HCAHPSAnswerDescription as HCAHPSAnswer, 
PatientSurveyStarRating as SurveyRating,
HCAHPSLinearmeanvalue as HCAHPSMean, 
numberofcompletedsurveys as NumberCompletedSurvey,
surveyresponseratepercent as SurveyResponseRate,
StartDate, EndDate,
Year, HospitalType, 
HospitalOwnership, EmergencyServices, 
meetscriteriaforpromotinginteroperabilityofehrs as EHRCriteriaMet,
HospitalOverallRating, hospitaloverallratingfootnote as HospitalOverallFootnotes,
Mortalitynationalcomparison as Mortality_v_National,
safetyofcarenationalcomparison as Safety_v_National, 
readmissionnationalcomparison as Readmission_v_National,
patientexperiencenationalcomparison as PatientExperience,
effectivenessofcarenationalcomparison as CareEffectiveness,
timelinessofcarenationalcomparison as CareTimeliness, 
efficientuseofmedicalimagingnationalcomparison as MedicalImagingUse,
HCAHPSAnswerPercent
from HealthCare.[dbo].[patient_satisfaction_2017$]
union all
select facilityid, facilityname,address,
City, State, ZipCode, CountyName,
HCAHPSMeasureID, HCAHPSQuestion, 
HCAHPSAnswerDescription as HCAHPSAnswer, 
PatientSurveyStarRating as SurveyRating,
HCAHPSLinearmeanvalue as HCAHPSMean, 
numberofcompletedsurveys as NumberCompletedSurvey,
surveyresponseratepercent as SurveyResponseRate,
StartDate, EndDate,
Year, HospitalType, 
HospitalOwnership, EmergencyServices, 
meetscriteriaforpromotinginteroperabilityofehrs as EHRCriteriaMet,
HospitalOverallRating, hospitaloverallratingfootnote as HospitalOverallFootnotes,
Mortalitynationalcomparison as Mortality_v_National,
safetyofcarenationalcomparison as Safety_v_National, 
readmissionnationalcomparison as Readmission_v_National,
patientexperiencenationalcomparison as PatientExperience,
effectivenessofcarenationalcomparison as CareEffectiveness,
timelinessofcarenationalcomparison as CareTimeliness, 
efficientuseofmedicalimagingnationalcomparison as MedicalImagingUse,
HCAHPSAnswerPercent
from HealthCare.[dbo].[patient_satisfaction_2018$]
union all
select facilityid, facilityname,address,
City, State, ZipCode, CountyName,
HCAHPSMeasureID, HCAHPSQuestion, 
HCAHPSAnswerDescription as HCAHPSAnswer, 
PatientSurveyStarRating as SurveyRating,
HCAHPSLinearmeanvalue as HCAHPSMean, 
numberofcompletedsurveys as NumberCompletedSurvey,
surveyresponseratepercent as SurveyResponseRate,
StartDate, EndDate,
Year, HospitalType, 
HospitalOwnership, EmergencyServices, 
meetscriteriaforpromotinginteroperabilityofehrs as EHRCriteriaMet,
HospitalOverallRating, hospitaloverallratingfootnote as HospitalOverallFootnotes,
Mortalitynationalcomparison as Mortality_v_National,
safetyofcarenationalcomparison as Safety_v_National, 
readmissionnationalcomparison as Readmission_v_National,
patientexperiencenationalcomparison as PatientExperience,
effectivenessofcarenationalcomparison as CareEffectiveness,
timelinessofcarenationalcomparison as CareTimeliness, 
efficientuseofmedicalimagingnationalcomparison as MedicalImagingUse,
cast(HCAHPSAnswerPercent as nvarchar(max)) as perccent
from HealthCare.[dbo].[patient_satisfaction_2019$]
union all
select facilityid, facilityname,address,
City, State, ZipCode, CountyName,
HCAHPSMeasureID, HCAHPSQuestion, 
HCAHPSAnswerDescription as HCAHPSAnswer, 
PatientSurveyStarRating as SurveyRating,
HCAHPSLinearmeanvalue as HCAHPSMean, 
numberofcompletedsurveys as NumberCompletedSurvey,
surveyresponseratepercent as SurveyResponseRate,
StartDate, EndDate,
Year, HospitalType, 
HospitalOwnership, EmergencyServices, 
meetscriteriaforpromotinginteroperabilityofehrs as EHRCriteriaMet,
HospitalOverallRating, hospitaloverallratingfootnote as HospitalOverallFootnotes,
Mortalitynationalcomparison as Mortality_v_National,
safetyofcarenationalcomparison as Safety_v_National, 
readmissionnationalcomparison as Readmission_v_National,
patientexperiencenationalcomparison as PatientExperience,
effectivenessofcarenationalcomparison as CareEffectiveness,
timelinessofcarenationalcomparison as CareTimeliness, 
efficientuseofmedicalimagingnationalcomparison as MedicalImagingUse,
cast(HCAHPSAnswerPercent as nvarchar(max)) as perccent
from HealthCare.[dbo].[patient_satisfaction_2020$];








