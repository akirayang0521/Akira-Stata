cls
clear all
// set the working directory
cd "C:\Users\syang61\Downloads"
// import excel spreadsheet and access first row as variable names
import excel "WVdata.xls", sheet("Sheet1") firstrow clear
// save the imported data as a .dta file
save WVdata.dta, replace

// generate a new WPV variable that combines "high" and "intermediate" observations in the original WPV variable (WPV_cat3)
gen WPV = WPV_cat3
replace WPV = "intermediate & high" if WPV_cat3 == "intermediate" & WPV_cat3 == "high"
// encode all the variables into factor variables (Stata's treatment of categorical variables)
// generate corresponding new variables to be used in the regression
// reference: "https://www.reed.edu/psychology/stata/gs/tutorials/destring.html"
encode WPV, generate(wpv)
encode Age_cat, generate(age)
encode Residence, generate(residence)
encode Geographical_division_workplace, generate(geographic)
encode Educational_degree, generate(education)
encode Marital_status, generate(marital)
encode Type_of_job, generate(jobtype)
encode Hospital_level, generate(hospitallevel)
encode Monthly_salary_BDT, generate(monthlysalary)
encode Working_experience, generate(workingexperience)
encode Weekly_working_hours, generate(weeklyworkinghours)
encode Department, generate(department)
encode Timely_salary, generate(timelysalary)
encode Had_sufficient_equipment, generate(equipment)
encode Had_rewards, generate(rewards)
encode Got_time_taking_rest, generate(takerest)
encode Average_daily_sleeping_hours, generate(dailysleephours)
encode Had_training_against_WPV, generate(training)

// TABLE 3
// get unadjusted estimate (run a regression of X on Y with no other covariates)
// set the reference level by using "ib#." (# = number for the category) under factor notation
// reference: 25.2.2 Specifying base levels, "https://www.stata.com/manuals13/u25.pdf"
reg TIS_total_scores ib3.wpv
reg TIS_total_scores ib2.age
reg TIS_total_scores i.residence
reg TIS_total_scores ib2.geographic
reg TIS_total_scores ib2.education
reg TIS_total_scores i.marital
reg TIS_total_scores i.jobtype
reg TIS_total_scores i.hospitallevel
reg TIS_total_scores ib2.monthlysalary
reg TIS_total_scores ib3.workingexperience
reg TIS_total_scores ib2.weeklyworkinghours
reg TIS_total_scores ib6.department
reg TIS_total_scores ib2.timelysalary
reg TIS_total_scores ib2.equipment
reg TIS_total_scores ib2.rewards
reg TIS_total_scores ib2.takerest
reg TIS_total_scores ib2.dailysleephours
reg TIS_total_scores ib2.training
// get adjusted estimate (run a regression of X on Y with other covariates)
reg TIS_total_scores ib3.wpv ib2.age i.residence ib2.geographic ib2.education i.marital i.jobtype i.hospitallevel ib2.monthlysalary ib3.workingexperience ib2.weeklyworkinghours ib6.department ib2.timelysalary ib2.equipment ib2.rewards ib2.takerest ib2.dailysleephours ib2.training

// TABLE 4
// mostly the same as the process of TABLE 3, just run all the regression models sort by type of job
// get unadjusted estimate (run a regression of X on Y with no other covariates)
// set the reference level by using "ib#." (# = number for the category) under factor notation
bysort jobtype: reg TIS_total_scores ib3.wpv
bysort jobtype: reg TIS_total_scores ib2.age
bysort jobtype: reg TIS_total_scores i.residence
bysort jobtype: reg TIS_total_scores ib2.geographic
bysort jobtype: reg TIS_total_scores ib2.education
bysort jobtype: reg TIS_total_scores i.marital
bysort jobtype: reg TIS_total_scores i.hospitallevel
bysort jobtype: reg TIS_total_scores ib2.monthlysalary
bysort jobtype: reg TIS_total_scores ib3.workingexperience
bysort jobtype: reg TIS_total_scores ib2.weeklyworkinghours
bysort jobtype: reg TIS_total_scores ib6.department
bysort jobtype: reg TIS_total_scores ib2.timelysalary
bysort jobtype: reg TIS_total_scores ib2.equipment
bysort jobtype: reg TIS_total_scores ib2.rewards
bysort jobtype: reg TIS_total_scores ib2.takerest
bysort jobtype: reg TIS_total_scores ib2.dailysleephours
bysort jobtype: reg TIS_total_scores ib2.training
// get adjusted estimate (run a regression of X on Y with other covariates)
bysort jobtype: reg TIS_total_scores ib3.wpv ib2.age i.residence ib2.geographic ib2.education i.marital i.hospitallevel ib2.monthlysalary ib3.workingexperience ib2.weeklyworkinghours ib6.department ib2.timelysalary ib2.equipment ib2.rewards ib2.takerest ib2.dailysleephours ib2.training
