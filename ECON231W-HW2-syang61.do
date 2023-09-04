cls
clear all

* Question 1
use "C:\Users\syang61\Downloads\HW2a_old.dta"
* part a
gen race = 0
replace race = 1 if black == 0 & hispan == 0
tabstat narr86 qemp86 inc86 tottime, by (race) stat(mean sd)
* part b
reg narr86 pcnv avgsen tottime ptime86 qemp86
* part c
predict avgsen_hat, residuals
sum avgsen_hat, detail
return list
local sigma2 = r(Var)
local n = r(N)
***
sum avgsen, detail
return list
local varofavgsen = r(Var)
***
reg avgsen pcnv tottime ptime86 qemp86
ereturn list
local Rsquare = e(r2)
***
local beta_variance = sqrt(`sigma2'/`n'/`varofavgsen'/(1-`Rsquare'))
di `beta_variance'
* part e - plot the residuals of the regression
reg avgsen pcnv tottime ptime86 qemp86
rvfplot
* part f
gen avgsen2 = avgsen^2
reg narr86 pcnv avgsen tottime ptime86 qemp86 avgsen2
* part g
reg narr86 pcnv avgsen avgsen2 ptime86 qemp86 inc86 race tottime, robust

cls
clear all

* Question 2
use "C:\Users\syang61\Downloads\HW2b_old.dta"
* part a
tabstat age educ black married lre74 lre75 lre78, by (train) stat(mean sd)
* part b - Run a simple regression of lre78 on train
reg lre78 train
* part c
predict train_hat, residuals
sum train_hat, detail
return list
local Nsigma2 = r(Var)
local Nn = r(N)
***
sum train, detail
return list
local varoftrain = r(Var)
***
local Nbeta_variance = sqrt(`Nsigma2'/`Nn'/`varoftrain'/(1-0.0114))
di `Nbeta_variance'
* part d - add re74, re75, educ, age, black, and hisp 
reg lre78 train re74 re75 educ age black hisp
* part e - incorporate an interaction of minor and train in the regression
gen minor = 0
replace minor = 1 if black == 1 | hisp == 1
reg lre78 train train#minor re74 re75 educ age black hisp 
* part f - include controls for unemployment in 1974 and 1975
reg lre78 train re74 re75 educ age black hisp unem74 unem75
* part g - include unem78 as the dependent variable
reg unem78 train re74 re75 educ age black hisp unem74 unem75
