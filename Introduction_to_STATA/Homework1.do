
***********************************
* Homework 1
***********************************
* Instructions: 
* To create this document, first copy and paste the full text here into a .Do document (a STATA Do-File).
* Below each question, write the code you used to answer the question
* Next, write your actual answer to the question by commenting out your writing (by starting the line with a *)
* Next, copy and paste the entire document (my writing and yours) into a Word document. This will allow me to see your code on Canvas without downloading every homework.
* The goal is that I should be able to copy and paste your entire text into a .Do File and run the code without any errors.
* Finally, submit file as Homework 1 on Canvas



***********************************
* Topic 1: Using STATA
***********************************

* 1. Import the AssetReuturns file

clear
cd "C:\Users\haniu\OneDrive\Desktop\Deepa\Deepa\Fall second seven week\Business Appliation in ML\Homework 1"

import excel "AssetReturns.xlsx", sheet("Sheet1") firstrow


* (7 vars, 94 obs)



* 2. Save File as Homework1
save "C:\Users\haniu\OneDrive\Desktop\Deepa\Deepa\Fall second seven week\Business Appliation in ML\Homework 1.dta"
* file C:\Users\haniu\OneDrive\Desktop\Deepa\Deepa\Fall second seven week\Business Appliation in ML\Homework 1.dta saved



* 3. Estimate the Mean, Minimum, and Maximum of Annual S&P500 Returns
summarize AnnualReturnSP500

*    Variable |        Obs        Mean    Std. dev.       Min        Max
*-------------+---------------------------------------------------------
* AnnualRe~500 |         94    .1182064    .1946077     -.4384      .5256

tabstat AnnualReturnSP500, statistics( mean min max )


*    Variable |      Mean       Min       Max
*-------------+------------------------------
*AnnualRe~500 |  .1182064    -.4384     .5256
*--------------------------------------------



* 4. Estimate the 25th and 75th percentile of Annual S&P 500 Returns
sum AnnualReturnSP500, detail

*                      AnnualReturnSP500
*-------------------------------------------------------------
*      Percentiles      Smallest
* 1%       -.4384         -.4384
* 5%       -.2512         -.3655
*10%       -.1067         -.3534       Obs                  94
*25%       -.0119          -.259       Sum of wgt.          94

*50%        .1452                      Mean           .1182064
*                        Largest       Std. dev.      .1946077
*75%        .2594          .4381
*90%         .326          .4674       Variance       .0378722
*95%        .4372          .4998       Skewness      -.4376344
*99%        .5256          .5256       Kurtosis       3.055353

tabstat AnnualReturnSP500, statistics( p25 p75 )


*    Variable |       p25       p75
*-------------+--------------------
*AnnualRe~500 |    -.0119     .2594
*----------------------------------




* 5. Estimate the variance of Annual Return in Treasury Bonds in 1992-2002 (including 1992 and 2002)
tabstat AnnualReturnTBonds if Year>=1992 & Year<=2002, statistics( var )


*    Variable |  Variance
*-------------+----------
*Annua~TBonds |  .0102407
*------------------------


* 6. Estimate the median of Annual Returns on Real Estate when Annual S&P500 Returns are positive
tabstat AnnualReturnRealEstate if AnnualReturnSP500>0, statistics( median )
 
 
*    Variable |       p50
*-------------+----------
*AnnualRetu~e |     .0413
*------------------------




* 7. Estimate mean Annual Corporte Bonds Returns when years are less than 1945 or year are between 2008 and 2012 (including 2008 and 2012)
tabstat AnnualReturnCorporateBonds if Year<1945 | (Year>=2008 & Year<=2012), statistics( mean )


*    Variable |      Mean
*-------------+----------
*Annua~eBonds |  .0757864
*------------------------



* 8. How many times is inflation exactly 0 (Hint: use tabulate)
tabulate InflationRate


*  Inflation |
*       Rate |      Freq.     Percent        Cum.
*------------+-----------------------------------
*          0 |          1        1.06        8.51


. count if InflationRate==0

* 1

***********************************
* Topic 2: Graphing in STATA
***********************************

* 9. Create a histogram of Inflation with a 2% bar width

twoway (histogram InflationRate, width(0.02)), name(Q9)
graph display Q9

*(bin=1, start=-.1027, width=2)


* 10. Create a box plot of Returns for all Assets
* Based on the graph, which asset has the greatest highs? The greatest lows?

graph box AnnualReturnSP500 AnnualReturnTBills AnnualReturnTBonds AnnualReturnCorporateBonds AnnualReturnRealEstate , name(Q10)
graph display Q10

* The greatest high is Annual Return S&P 500
* The greatest low is Annual Return T-Bills 

* 11. Create a Scatter plot with inflation as the x-variable and annual real estate returns as the y-variable.
*Does Real Estate pay well when inflation is high or low? Why?

twoway (scatter AnnualReturnRealEstate InflationRate) (lfit AnnualReturnRealEstate InflationRate), name(Q11)
graph display Q11

* Trend line shows Annual Real Estate Returns and Inflation has a positive correlation which indicates whenever the Inflation is high the Annual Real Estate Returns is high.


* 12. Create a two-way layered graphic with both a scatter plot and a linear fit. The y-variable is Corporate Bond Returns and the x-variable is Treasury Bonds Returns

twoway (scatter AnnualReturnCorporateBonds AnnualReturnTBonds) (lfit AnnualReturnCorporateBonds AnnualReturnTBonds), name(Q12)
graph display Q12

