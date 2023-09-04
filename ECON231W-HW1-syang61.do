clear

cd "C:\Users\syang61\Downloads"

use "C:\Users\syang61\Downloads\NSCG15_version13.dta"

* part c
gen hrswk0 = hrswk
replace hrswk0 = . if hrswk == 98

gen wkslyr0 = .
replace wkslyr0 = 52 if wksyr == "1"
replace wkslyr0 = wkslyr if wksyr == "2"

gen earn0 = earn
replace earn0 = . if earn == 9999998

tabstat hrswk0, statistics(mean sd) by (gender)
tabstat wkslyr0, statistics(mean sd) by (gender)
tabstat earn0, statistics(mean sd) by (gender)

* part d
histogram hrswk0, width(10) by (gender)

* part e
gen lnhourwage = ln(earn0/(hrswk0*wkslyr0))
drop if lnhourwage < 0
tabstat lnhourwage, statistics(mean sd p10 p90) by (gender)

* part g
by gender, sort: tabstat lnhourwage, statistics(mean) by (nbamemg)

* part h
reg lnhourwage educ if gender == "F"
reg lnhourwage educ if gender == "M"

* part i
gen ptlexper = age-educ-6
gen ptlexperS = ptlexper^2
reg lnhourwage educ ptlexper ptlexperS if gender == "F"
reg lnhourwage educ ptlexper ptlexperS if gender == "M"
