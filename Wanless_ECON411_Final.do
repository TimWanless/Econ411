*imports data from my computer
import excel "C:\Users\Timothy\Downloads\finaldata.xlsx", sheet("Sheet1") firstrow

regress stcoll d1

*Creating a time variable the easy way for use
gen time = tm(2000m1) + _n-1
format time %tm

*sets time
tsset time

*tsline lstcoll
generate lstcoll = ln(stcoll)

*generates 1 lag stcoll variable
generate stcolll1 = L1.stcoll

*generates 1 lead stcoll variable
generate stcollf1 = F1.stcoll

*generates difference stcoll variable
generate stcolld = D1.stcoll

*generates log of stcolld
generate lstcolld = D1.lstcoll

*generates summary stats
summarize stcoll

*generates Dickey-Fuller Test results
dfuller stcoll, regress


*These are the necessary steps to create the month dummy variables when we want to remove seasonality.
gen sdate = d1
format sdate %td
gen month = month(sdate)
*Recall that 'qui' tells Stata to run the program quietly and not pull up a result
*on the result window
qui tabulate month, gen(m)

*This generates the time trend
gen trend = _n

*We generate two regression runs that are the same in terms of effects.
regress stcoll trend m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12
regress stcoll trend b12.month

*This command saves the output
estimate store fit1

*This runs the information criteria test.
estat ic

tsset time
twoway (tsline stcolld), ytitle(Difference in Sales Tax Collections) ttitle(Time) title(Difference in Sales Tax Collections: Grand Forks) subtitle(in $ millions)
*creates time-series graph of sales tax collections
twoway (tsline stcoll), ytitle(Sales Tax Collections) ttitle(Time) title(Sales Tax Collections: Grand Forks) subtitle(in $ millions)

twoway (line stcoll time) (lfit stcoll time), ytitle(Sales Tax Collections) ttitle(Time) title(Sales Tax Collections: Grand Forks) subtitle(in $ millions)

predict fitted_values
tsline stcoll fitted_values
regress stcoll trend b12.month if tin(2000m1, )
estimates store sub1_ts
predict sub1_fitted_values

twoway (tsline stcoll) (tsline fitted_values ), ytitle(Sales Tax Collections) ttitle(Time) title(Sales Tax Collections with Fitted Values: Grand Forks) subtitle(in $ millions)

twoway (tsline fitted_values), ytitle(Sales Tax Collections) ttitle(Time) title(Fitted Values of Sales Tax Collections: Grand Forks) subtitle(in $ millions)

*generates data for single exponential smoothing model for year 2019
tssmooth exponential esm1=stcoll, forecast(10)
*generates data for double exponential smoothing model for year 2019
tssmooth dexponential esm2=stcoll, forecast(10)

*generates single and double exponential smoothing models for year 2019
twoway (line stcoll time) (line esm1 time)(line esm2 time), ytitle(Sales Tax Collections) ttitle(Time) title(Exponential Smoothing Forecasts: Grand Forks)

*generates single exponential smoothing model for latest 3 years
twoway (line stcoll time) (line esm1 time)(line esm2 time) in 204/242, ytitle(Sales Tax Collections) ttitle(Time) title(Exponential Smoothing Forecasts: Grand Forks)

*Looks at data distribution
ac stcoll
pac stcoll

*Looks at differenced data
*gen dstcoll=D1.stcoll
ac stcoll
pac stcoll

*Looks at different arima models
*arima stcoll, arima(1,1,1)
*estat ic

arima stcoll, arima(1,1,3)
estat ic

*arima stcoll, arima(3,1,3)
*estat ic

*arima stcoll, arima(2,1,3)
*estat ic

*arima stcoll, arima(2,1,1)
*estat ic

*arima stcoll, arima(1,2,3)
*estat ic


*arima stcoll, arima(1,1,3)

*predict dstcollres, resid

*ac dstcollres
*pac dstcollres


arima stcoll, arima(1,1,3)

arima stcoll, ar(1) ma(1 3)

predict xhat, y

predict xhatdy, dynamic(tm(2000m1)) y

tsline stcoll xhat xhatdy, ytitle(Sales Tax Collections) ttitle(Time) title(ARIMA Forecast Sales Tax Collections: Grand Forks) subtitle(in $ millions)

clear

import fred NDSLGRTAX SDSLGRTAX WYSLGRTAX NESLGRTAX IASLGRTAX, daterange(2000 2019)


rename NDSLGRTAX  ND
rename SDSLGRTAX  SD
rename WYSLGRTAX  WY
rename NESLGRTAX  NE
rename IASLGRTAX  IA

*IA not used

gen time = 2000 + _n-1
format time %ty

tsset time

dfuller ND, lags(5)
dfuller SD, lags(5)
dfuller WY, lags(5)
dfuller NE, lags(5)


dfuller d.ND, lags(5)
dfuller d.SD, lags(5)
dfuller d.WY, lags(5)
dfuller d.NE, lags(5)


varsoc ND SD WY NE, maxlag(5)

var ND SD WY NE, lags(1/5)


vecrank ND SD WY NE, trend(constant)
vecrank ND SD WY NE, trend(constant) max

var ND SD WY NE, lags(1/2)

vec ND SD WY NE, trend(constant)



tsline ND SD WY NE

predict ce1 if e(sample), ce equ(#1)

tsline ce1 if e(sample)

fcast compute f_ , step(2)

fcast graph f_ND, scheme(s2mono) legend(rows(1))

