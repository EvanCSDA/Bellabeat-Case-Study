--The daily activities table is an agregated table. We can explore this data first to make some statitical observations
SELECT DISTINCT Id
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;
--There are 33 distinct users

--Lets get a picture of the time frame
SELECT Distinct ActivityDate
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`
ORDER BY ActivityDate ASC;
--The data was logged from 4/12/16 to 5/12/16

--Lets calculate some averages and alias the calculated fields
SELECT 
(AVG(TotalDistance)) AS AV_Total_Distance,
(AVG(TotalSteps)) AS Av_Total_Steps,
(AVG(TrackerDistance)) AS Av_Tracker_Distance, 
(AVG(LoggedActivitiesDistance)) AS Av_Logged_Act_Dist,
(AVG(VeryActiveDistance)) AS Av_Very_Act_Dist, 
(AVG(ModeratelyActiveDistance)) AS Av_Moderate_act_distance, 
(AVG(LightActiveDistance)) AS Av_Light_Act_Dist,
(AVG(SedentaryActiveDistance)) AS AV_Sed_Act_Distance, 
(AVG(VeryActiveMinutes)) AS AV_Very_Act_Mins,
(AVG(FairlyActiveMinutes)) AS Av_Fair_Act_Mins,
(AVG(LightlyActiveMinutes)) AS Av_Light_Act_Mins,
(AVG(SedentaryMinutes)) AS Av_Sed_Act_Mins,
(AVG(Calories)) AS Av_Cals
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;


--Lets calulate some MAX figures
SELECT 
(MAX(TotalDistance)) AS Max_Total_Distance,
(MAX(TotalSteps)) AS Max_Total_Steps,
(MAX(TrackerDistance)) AS Max_Tracker_Distance, 
(MAX(LoggedActivitiesDistance)) AS Max_Logged_Act_Dist,
(MAX(VeryActiveDistance)) AS Max_Very_Act_Dist, 
(MAX(ModeratelyActiveDistance)) AS Max_Moderate_act_distance, 
(MAX(LightActiveDistance)) AS Max_Light_Act_Dist,
(MAX(SedentaryActiveDistance)) AS Max_Sed_Act_Distance, 
(MAX(VeryActiveMinutes)) AS Max_Very_Act_Mins,
(MAX(FairlyActiveMinutes)) AS Max_Fair_Act_Mins,
(MAX(LightlyActiveMinutes)) AS Max_Light_Act_Mins,
(MAX(SedentaryMinutes)) AS Max_Sed_Act_Mins, 
(MAX(Calories)) AS Max_Cals
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;

--Lets calcualte some SUM figures
SELECT 
(SUM(TotalDistance)) AS SUM_Total_Distance,
(SUM(TotalSteps)) AS SUM_Total_Steps,
(SUM(TrackerDistance)) AS SUM_Tracker_Distance, 
(SUM(LoggedActivitiesDistance)) AS SUM_Logged_Act_Dist,
(SUM(VeryActiveDistance)) AS SUM_Very_Act_Dist,
(SUM(ModeratelyActiveDistance)) AS SUM_Moderate_act_distance, 
(SUM(LightActiveDistance)) AS SUM_Light_Act_Dist,
(SUM(SedentaryActiveDistance)) AS SUM_Sed_Act_Distance,
(SUM(VeryActiveMinutes)) AS Sum_Very_Act_Mins,
(SUM(FairlyActiveMinutes)) AS SUM_Fair_Act_Mins,
(SUM(LightlyActiveMinutes)) AS SUM_Light_Act_Mins,
(SUM(SedentaryMinutes)) AS Sum_Sed_Act_Mins, 
(SUM(Calories)) AS SUM_Cals
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;

--Calculting percentages of activity
SELECT
(SUM(VeryActiveMinutes)) / (SUM(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes)) * 100 AS Percent_Very_Act_Mins,
(SUM(FairlyActiveMinutes)) / (SUM(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes)) * 100 AS Percent_Fair_Act_Mins,
(SUM(LightlyActiveMinutes)) / (SUM(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes)) * 100 AS Percent_Light_Act_Mins,
(SUM(SedentaryMinutes))/ (SUM(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes)) * 100 AS Percent_Sed_Act_Mins,
SUM(VeryActiveMinutes + FairlyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes) AS Total_Mins
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;

--Calculating percentages of distance
SELECT 
(SUM(VeryActiveDistance)) /(SUM(TotalDistance)) * 100 AS Percent_Very_Act_Dist,
(SUM(ModeratelyActiveDistance)) /(SUM(TotalDistance))* 100 AS Percent_Mod_Act_Dist, 
(SUM(LightActiveDistance)) /(SUM(TotalDistance)) * 100 AS Percent_Light_Act_Dist,
(SUM(SedentaryActiveDistance)) /(SUM(TotalDistance)) * 100 AS Percent_Sed_Act_Distance,
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`;

--SUM the data by month, by user
SELECT 
Id,
SUM(Calories) AS Thirty_Day_Total_Cal,
SUM(ROUND(TotalDistance)) AS Thirty_Day_Total_Dist,
SUM(ROUND(VeryActiveDistance)) AS Thirty_Day_Very_Act_Dist,
SUM(ROUND(ModeratelyActiveDistance)) AS Thirty_Day_Moderate_act_distance, 
SUM(ROUND(LightActiveDistance)) AS Thirty_Day_Light_Act_Dist,
SUM(ROUND(SedentaryActiveDistance)) AS Thirty_Day_Sed_Act_Distance,
SUM(ROUND(VeryActiveMinutes)) AS Thirty_Day_Very_Act_Mins,
SUM(ROUND(FairlyActiveMinutes)) AS Thirty_Day_Fair_Act_Mins,
SUM(ROUND(LightlyActiveMinutes)) AS Thirty_Day_Light_Act_Mins,
SUM(ROUND(SedentaryMinutes)) AS Thirty_Day_Sed_Act_Mins
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity`
WHERE Calories >= 0
GROUP BY Id
ORDER BY Thirty_Day_Total_Cal DESC;

--We are now going to join a few tables to check for correlations

SELECT`bellabeatcasestudy-373021.Bellabeat.daily_activity`.ActivityDate,`bellabeatcasestudy-373021.Bellabeat.sleep_day`.id, `bellabeatcasestudy-373021.Bellabeat.daily_activity` .Calories,`bellabeatcasestudy-373021.Bellabeat.daily_activity` .TotalSteps,`bellabeatcasestudy-373021.Bellabeat.sleep_day`.TotalMinutesAsleep
FROM `bellabeatcasestudy-373021.Bellabeat.daily_activity` 
INNER JOIN `bellabeatcasestudy-373021.Bellabeat.sleep_day`
ON `bellabeatcasestudy-373021.Bellabeat.sleep_day`.id=`bellabeatcasestudy-373021.Bellabeat.daily_activity`.id AND CAST(`bellabeatcasestudy-373021.Bellabeat.sleep_day`.SleepDay AS DATE)=`bellabeatcasestudy-373021.Bellabeat.daily_activity`.ActivityDate
ORDER BY `bellabeatcasestudy-373021.Bellabeat.sleep_day`.id,ActivityDate;
--Lets Summarize the sleep data
SELECT id,COUNT(TotalSleepRecords) AS Days_Sleep_Tracked
FROM `bellabeatcasestudy-373021.Bellabeat.sleep_day`
GROUP BY Id
ORDER BY Days_Sleep_Tracked
--24 of 33 participants tracked their sleep for at least one day
