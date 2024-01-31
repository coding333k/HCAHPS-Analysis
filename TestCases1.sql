--things to check while doing the visualization 
select NumberofCompletedSurveys, state, facilityname
from HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'CA' and facilityname = 'alameda hospital'
order by NumberofCompletedSurveys

-- check the count of surveys for this one hospital 
select distinct facilityname, sum( NumberofCompletedSurveys)/ count(NumberofCompletedSurveys) as SurveyCount, 
state
from HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'CA' and facilityname = 'alameda hospital'
group by facilityname, state

--try to get total survey count for each state 
--can probably be replicated for district or county 
select  distinct state, 
count( NumberofCompletedSurveys)as SurveyCount
from HealthCare.[dbo].[patient_satisfaction_2019$]
--where state = 'CA' and facilityname = 'alameda hospital'
group by  state


select facilityname, numberofcompletedsurveys, state
from HealthCare.[dbo].[patient_satisfaction_2019$]

select distinct facilityname, sum( NumberofCompletedSurveys)/ count(NumberofCompletedSurveys) as SurveyCount, 
state
from HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'DC'
group by facilityname, state

--see if each hospital reports info multiple times a year 
select facilityname, startdate, enddate, numberofcompletedsurveys,
state
from HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'DC' and FacilityName = 'united medical center'

--this works to get total survey count by state
SELECT state, sum(distinct_survey_count) AS total_surveys
FROM (
    SELECT state, facilityname,
        avg( NumberofCompletedSurveys) AS distinct_survey_count
    FROM HealthCare.[dbo].[patient_satisfaction_2019$]
    GROUP BY state, facilityname
) AS subquery
GROUP By state;

--lets make a query to aggregate survey completion rate by state
--we can further use this for drilldown
select distinct facilityname, state, surveyresponseratepercent as responserate
from HealthCare.[dbo].[patient_satisfaction_2019$]
group by facilityname, state, SurveyResponseRatePercent;

--to accurately get surveyresponse rates lets take out the distinct 

select avg( SurveyResponseRatePercent)
FROM HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'WI'

SELECT state, AVG(SurveyResponseRatePercent) AS average_response_rate,
avg(Hospitaloverallrating) as overallrating
FROM HealthCare.[dbo].[patient_satisfaction_2019$]
GROUP BY state
order by AVG( SurveyResponseRatePercent) desc;

--grab all the states for making map in power bi 
select distinct state
FROM HealthCare.[dbo].[patient_satisfaction_2019$]
group by state;

--check overall rating for physician ownened hospitals
select surveyresponseratepercent, hospitaloverallrating, state
from HealthCare.[dbo].[patient_satisfaction_2019$]
where HospitalOwnership = 'physician';

--get percentages within each hcahps question result
select distinct FacilityID, Mortalitynationalcomparison
from HealthCare.[dbo].[patient_satisfaction_2019$]
group by FacilityID, Mortalitynationalcomparison

SELECT Mortalitynationalcomparison,
    COUNT(*) AS count,
    100 * COUNT(*) / SUM(COUNT(*)) OVER () AS percentage
FROM HealthCare.[dbo].[patient_satisfaction_2019$]
where state = 'TX'
GROUP BY Mortalitynationalcomparison;

-- this field is nvarchar for 2018 and earlier and float for 2019,2018, 
--therefore causing earlier union issue
select hcahpsanswerpercent
FROM HealthCare.[dbo].[patient_satisfaction_2019$]







