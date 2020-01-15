
*Generation of log of GDP per capita*
generate loggdpcap= log(gdppercapitaconstant2005uswb)

*Generation of number of parties*

*Existence of 2. government party*
generate egovparty2=0
replace egovparty2=1 if gov2seat !=.

*Existence of 3. government party*
generate egovparty3=0
replace egovparty3=1 if gov3seat !=.


*Existence of 1. opposition party*
generate eoppparty1=0
replace eoppparty1=1 if opp1seat !=.

*Existence of 2. opposition party*
generate eoppparty2=0
replace eoppparty2=1 if opp2seat !=.

*Existence of 1. opposition party*
generate eoppparty3=0
replace eoppparty3=1 if opp3seat !=.



*Total number of parties (treats independent legislators as parties)*
generate totalnumberofparties= 1+egovparty2 + egovparty3 + eoppparty1 + eoppparty2 + eoppparty3 + govoth + oppoth + ulprty



*Generation of chiefexecutiveelection dummy*
generate chiefexecutiveelection=0
replace chiefexecutiveelection=1 if presidentialsystem==0 & legelec==1
replace chiefexecutiveelection=1 if presidentialsystem==1 & exelec==1
replace chiefexecutiveelection=. if legelec==. | exelec==. 

*Generation of dummy for expenditure rule with statuary or constitutional basis*
generate statconER=0
replace statconER=1 if er== 1 & legal_n_er==3 |er== 1 & legal_n_er==5
replace statconER=. if er==.

*Generation of dummy for revenue rule with statuary or constitutional basis*
generate statconRR=0
replace statconRR=1 if rr== 1 & legal_n_rr==3 |rr== 1 & legal_n_rr==5
replace statconRR=. if rr==.

*Generation of dummy for balanced budget rule with statuary or constitutional basis*
generate statconBBR=0
replace statconBBR=1 if bbr== 1 & legal_n_bbr==3 |bbr== 1 & legal_n_bbr==5
replace statconBBR=. if bbr==.



*Generation of dummy for debt rule with statuary or constitutional basis*
generate statconDR=0
replace statconDR=1 if dr== 1 & legal_n_dr==3 |dr== 1 & legal_n_dr==5
replace statconDR=. if dr==.

xtset countrycode year

*Generation of reform expenditure rule*
generate reformER=0
replace reformER=1 if statconER==1 & l1.statconER==0
replace reformER=. if statconER==.

*Generation of reform revenue rule*
generate reformRR=0
replace reformRR=1 if statconRR==1 & l1.statconRR==0
replace reformRR=. if statconRR==.

*Generation of reform balance budget rule*
generate reformBBR=0
replace reformBBR=1 if statconBBR==1 & l1.statconBBR==0
replace reformBBR=. if statconBBR==.

*Generation of reform debt rule*
generate reformDR=0
replace reformDR=1 if statconDR==1 & l1.statconDR==0
replace reformDR=. if statconDR==.


*Generation of non-expenditure rule years. Some countries with problems*
generate nonERyears=.
replace nonERyears= year-1984 if statconER==0
replace nonERyears= 0 if statconER==1
replace nonERyears= year-1984 if statconER==1 & l.statconER==0





*Generation of IMF national expenditure rules index* 
*Rescale cover of expenditure rule*
generate cover_n_er2= cover_n_er/2

*Rescale legal scope of expenditure rule*
generate legal_n_er2= legal_n_er/5

*generation of Expenditure rules strenght index* 
generate ER_n_strengh = cover_n_er2 + legal_n_er2 + enforce_n_er + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n


*Rescale cover of revenue rule*
generate cover_n_rr2= cover_n_rr/2

*Rescale legal scope of revenue rule*
generate legal_n_rr2= legal_n_rr/5

*generation of revenue rules strenght index*
generate RR_n_strengh= cover_n_rr2 + legal_n_rr2 + enforce_n_rr + frl + suport_budg_n + suport_impl_n

*Rescale cover of balanced budget rule*
generate cover_n_bbr2=cover_n_bbr/2

*Rescale legal scope of balanced budget rule*
generate legal_n_bbr2= legal_n_bbr/5

*generation of balanced budget rules strenght index*
generate BBR_n_strengh= cover_n_bbr2 + legal_n_bbr2 + enforce_n_bbr + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n

*Rescale cover of debt rule*
generate cover_n_dr2= cover_n_dr/2

*Rescale legal scope of debt rule*
generate legal_n_dr2= legal_n_dr/5

*generation of debt rule strenght index*
generate DR_n_strengh= cover_n_dr2 + legal_n_dr2 + enforce_n_dr + suport_ceil_n_a + frl + suport_budg_n + suport_impl_n


*Generation of overal fiscal rules index*
generate nationalfiscalrulesindex=((DR_n_strengh*5/7) + (BBR_n_strengh*5/7) + (RR_n_strengh*5/6) + (ER_n_strengh*5/7))/4


*Generation of majority government dummy*
generate majoritygov=0
replace majoritygov=1 if maj>0.5
replace majoritygov=. if maj==.

*Generation of singlepartygovernment dummy*
generate singlepartygov=0
replace singlepartygov= 1 if herfgov==1
replace singlepartygov=. if herfgov==.

*generation of "strong government" dummy*
generate stronggov=0
replace stronggov= 1 if singlepartygov==1 & majoritygov==1
replace stronggov=. if singlepartygov==. | majoritygov==. 

* Generation of supranational fiscal rules*
generate supranationaler=0
replace supranationaler=1 if er_supra==2 | er_supra==3
replace supranationaler=. if er_supra==.


generate supranationalrr=0
replace supranationalrr=1 if rr_supra==2 | rr_supra==3
replace supranationalrr=. if rr_supra==.


generate supranationalbbr=0
replace supranationalbbr=1 if bbr_supra==2 | bbr_supra==3
replace supranationalbbr=. if bbr_supra==.


generate supranationaldr=0
replace supranationaldr=1 if dr_supra==2 | dr_supra==3
replace supranationaldr=. if dr_supra==.

generate supranationalrules=0
replace supranationalrules=1 if supranationaler==1 | supranationalrr==1 | supranationalbbr==1 | supranationaldr==1
replace supranationalrules=. if dr_supra==.

*Listing of countries with supranational fiscla rules in the OECD (Stability and Growth Pact)*
list country if supranationalrules==1 & oecd==1

*Figure 1: Generate figure with types of fiscal rules**

bysort year : egen year_meanfiscalrules = mean(nationalfiscalrule)
bysort year : egen year_meanerule = mean(statconER) if oecd==1
bysort year : egen year_meanrrrule = mean(statconRR) if oecd==1
bysort year : egen year_meanbbrule = mean(statconBBR) if oecd==1
bysort year : egen year_meandrule = mean(statconD) if oecd==1

twoway (line year_meanbbrule year, lpattern(solid) lcolor(black))(line year_meanerule year,lpattern(shortdash)  lcolor(black) ) (line year_meandrule year, lpattern(longdash)  lcolor(black)) (line year_meanrrrule year, lpattern("..-..")  lcolor(black)),graphregion(color(white))legend (label(1 "Balanced budget rule") label(2 "Expenditure rule") label(3 "Debt rule") label(4 "Revenue rule"))  ytitle(Share of countries with national fiscal rules) ylabel(, format(%9.1f)) ylabel( 0.0 0.1 0.2 0.3 0.4 0.5 0.6)  xlabel(1985 1990 1995 2000 2005 2010 2014), if year >= 1985 & oecd==1



*Figure 2: Trends in polarization*
bysort year : egen year_mean = mean(daltonrile) if oecd==1
bysort year : egen year_mean1 = mean(daltonwelfare) if oecd==1
twoway (line year_mean year, lcolor(gs0)) (line year_mean1 year, lcolor(gs0) lpattern(dash)),graphregion(color(white))ytitle(Average level of polarization in OECD countries) ylabel(, format(%9.1f)) legend(label(1 "Rile indicator") label(2 "Welfare indicator")) xlabel(1985 1990 1995 2000 2005 2010 2014), if year >= 1985 & oecd==1

*Generate log of mean distric magnitude*
generate logmdmh= log(mdmh)

xtset countrycode year


*Appendix: Polarization for each country*
xtline daltonrile  , t(year) i(country)  ytitle("Level of polarization Rile indicator")  xtitle("Year") xlabel(1985  1993 2002 2012) graphregion(color(white)) legend(off), if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 

xtline daltonwelfare  , t(year) i(country)  ytitle("Level of polarization Welfare indicator")  xtitle("Year") xlabel(1985  1993 2002 2012) graphregion(color(white)) legend(off), if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 

xtline dis2partiesrile  , t(year) i(country)  ytitle("Distance two largest parties, Rile indicator")  xtitle("Year") xlabel(1985  1993 2002 2012) graphregion(color(white)) legend(off), if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 




*Stationarity of key variables*



xtunitroot fisher statconER, dfuller   lag(1)
xtunitroot fisher statconRR, dfuller   lag(1)
xtunitroot fisher statconDR, dfuller   lag(1)
xtunitroot fisher statconBBR, dfuller   lag(1)


*Test fiscal rules and polarization, only OECD*

*Histogram of polarization*
hist daltonrile if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 
hist daltonwelfare   if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 


*Descriptive statistics*
xtsum daltonrile daltonwelfare  statconER statconRR statconBBR statconDR gini_market loggdpcap logmdmh gggrossdebtpctgdpimf if oecd==1 & daltonrile!=. & daltonwelfare!=. &  statconER!=. & statconRR!=. & statconBBR!=. & statconDR!=. & gini_market!=. & loggdpcap!=. & logmdmh!=. & gggrossdebtpctgdpimf!=. 


*Statuary and constitutional rules*

*Rile indicator* 


*Table 2*
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1
coefplot, keep( statconER statconRR statconBBR statconDR)  xtitle (Effect on Political polarization) xline(0) graphregion(color(white)) coeflabels(statconER = " Expenditure rule" statconRR= "Revenue rule" statconBBR= "Balanced budget rule" statconDR= "Debt rule" ) levels(99 95 90)

*Table 3 welfare with Dalton*
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1



*Footnote: Fiscal rules lagged 1 & 2 years*

xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconER l.statconRR l.statconBBR l.statconDR i.year, fe cluster (countrycode), if oecd==1
coefplot, keep( l.statconER l.statconRR l.statconBBR l.statconDR)  xtitle (Effect on Political polarization) xline(0) graphregion(color(white)) coeflabels(l.statconER = " Expenditure rule" l.statconRR= "Revenue rule" l.statconBBR= "Balanced budget rule" ll.statconDR= "Debt rule" ) levels(99 95 90)


xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l.statconER l.statconRR l.statconBBR l.statconDR i.year, fe cluster (countrycode), if oecd==1



xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconER l2.statconRR l2.statconBBR l2.statconDR i.year, fe cluster (countrycode), if oecd==1
coefplot, keep( statconER statconRR statconBBR statconDR)  xtitle (Effect on Political polarization) xline(0) graphregion(color(white)) coeflabels(statconER = " Expenditure rule" statconRR= "Revenue rule" statconBBR= "Balanced budget rule" statconDR= "Debt rule" ) levels(99 95 90)


xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf l2.statconER l.statconRR l.statconBBR l.statconDR i.year, fe cluster (countrycode), if oecd==1



*Footnote:Size of public sector control*
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ggexpenditurepctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

*Removal of Australia and France (only with revenue rules)*
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1 & countrycode!=7
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1 & countrycode!=57


*Table B1: International sources 
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR tradepctofgdpwdi i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR  tradepctofgdpwdi i.year, fe cluster (countrycode), if oecd==1

xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR economicglobalizationkof i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR economicglobalizationkof i.year, fe cluster (countrycode), if oecd==1

xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR underimfprogramme i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR underimfprogramme i.year, fe cluster (countrycode), if oecd==1


xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf supranationalrules statconER statconRR statconBBR statconDR  i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf supranationalrules statconER statconRR statconBBR statconDR   i.year, fe cluster (countrycode), if oecd==1



*Table B2 Distance two largest parties*
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1


*Distance two largest parties welfare*
xtreg dis2partieswelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR  statconDR i.year, fe cluster (countrycode), if oecd==1


* Table B3 Country specific time trends* 
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
coefplot, keep( statconER statconRR statconBBR statconDR)  xtitle (Effect on Political polarization) xline(0) graphregion(color(white)) coeflabels(statconER = " Expenditure rule" statconRR= "Revenue rule" statconBBR= "Balanced budget rule" statconDR= "Debt rule" ) levels(99 95 90)

xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1



xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.countrycode#c.year i.year, fe cluster (countrycode), if oecd==1


* Foot note : Control of effective number of legislative parties and partisan fragmentation* 
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf effpar_leg statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf frac statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf effpar_leg statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf frac statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1



*Appendix C*

* Other economic dimensions: Planned economy*
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1



*Other economic dimensions market economy*
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1



*Non economic dimensions: International peace*
xtreg daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1


*Appendix D: voter polarization*
xtreg voter_left_right_sd  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg voter_left_right_sd gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg voter_left_right_sd gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg voter_left_right_sd   gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg voter_left_right_sd gini_market  loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1




*Extra analysis (footnote): Interaction analysis*

*Dalton expenditure*
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconER##c.ggexpenditurepctgdpimf i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconER##c.ggexpenditurepctgdpimf i.year, fe cluster (countrycode), if oecd==1

xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconER##c.ggexpenditurepctgdpimf i.year, fe cluster (countrycode), if oecd==1
margins, dydx (ggexpenditurepctgdpimf ) over (statconER)
marginsplot, level(90)  graphregion(color(white))legend (off)

xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconER##c.ggexpenditurepctgdpimf i.year, fe cluster (countrycode), if oecd==1
margins, dydx (ggexpenditurepctgdpimf ) over (statconER)
marginsplot, level(90)  graphregion(color(white))legend (off)


*Dalton revenue*
xtreg daltonrile  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconRR##c.ggrevenuepctgdpimf i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.statconRR##c.ggrevenuepctgdpimf i.year, fe cluster (countrycode), if oecd==1

*Dalton net lending*
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.ggnetlendingborrowingpctgdpimf##c.statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.ggnetlendingborrowingpctgdpimf##c.statconBBR i.year, fe cluster (countrycode), if oecd==1

*Dalton debt*
xtreg daltonrile  gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1

* Marginsplot for debt. Excluding extreme cases* 
xtreg daltonrile  gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1 & gggrossdebtpctgdpimf<100.1
margins, dydx (statconDR)at (gggrossdebtpctgdpimf=(0 20 40 60 80 100 )) 
marginsplot, level(90) ytitle(Effect of  debt rule on polarization) xtitle(Gross government debt pct. of GDP) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))addplot(hist gggrossdebtpctgdpimf if gggrossdebtpctgdpimf<101, below  percent  lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2))) yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))  graphregion(color(white))legend (off)    scheme(s1mono)  recastci(rline) recast(line)


xtreg daltonwelfare gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1 & gggrossdebtpctgdpimf<100.1
margins, dydx (statconDR)at (gggrossdebtpctgdpimf=(0 20 40 60 80 100)) 
marginsplot, level(90) ytitle(Effect of  debt rule on polarization) xtitle(Gross government debt pct. of GDP) addplot(hist gggrossdebtpctgdpimf if gggrossdebtpctgdpimf<101, below  percent  lcolor(black*0.5) fcolor(white) yaxis(2)ylabel(0 60, axis(2)) yscale(off axis(2)))yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))graphregion(color(white))legend (off) scheme(s1mono) recastci (rline) recast(line)



*Plotting the elements of the interaction*
twoway scatter ( daltonrile gggrossdebtpctgdpimf ) if oecd==1 & statconDR==0
twoway scatter ( daltonrile gggrossdebtpctgdpimf ) if oecd==1 & statconDR==1

twoway scatter ( daltonwelfare gggrossdebtpctgdpimf ) if oecd==1 & statconDR==0
twoway scatter ( daltonwelfare gggrossdebtpctgdpimf ) if oecd==1 & statconDR==1




*Extra analyses (not in paper): 


*Strenght of fiscal rules as independent variables* 



*Dalton*
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1

*Removal of Australia and France (only with revenue rules)*
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh  i.year, fe cluster (countrycode), if oecd==1 & countrycode!=7
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh  i.year, fe cluster (countrycode), if oecd==1 & countrycode!=57


xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.ER_n_strengh##c.ggexpenditurepctgdpimf i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.RR_n_strengh##c.ggrevenuepctgdpimf i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf c.ggnetlendingborrowingpctgdpimf##c.BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.DR_n_strengh i.year, fe cluster (countrycode), if oecd==1



*Distance two largest parties*
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partiesrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1


*Welfare (Dalton)* 
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1




*Polarization in other dimensions* 
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1


xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1


xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1



*Core results eu*
xtreg daltonrile  gini_market loggdpcap logmdmh eu gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh eu gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh eu gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh eu gggrossdebtpctgdpimf  statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh eu gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

xtreg daltonrile  gini_market loggdpcap logmdmh eu c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh eu c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1

*Core results under IMF programme*
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER underimfprogramme i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR  underimfprogramme i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR underimfprogramme i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf  statconDR underimfprogramme i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR underimfprogramme i.year, fe cluster (countrycode), if oecd==1

*Core standard deviation*
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf  statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

xtreg sdrile  gini_market loggdpcap logmdmh effpar_leg c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh effpar_leg c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1



*Core results effective number of parties*
xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg gggrossdebtpctgdpimf  statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

xtreg daltonrile  gini_market loggdpcap logmdmh effpar_leg c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh effpar_leg c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1



*Welfare*
*SD *
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1



*Dalton*
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1



*Distance two largest parties*
xtreg dis2partieswelfare gini_market loggdpcap gggrossdebtpctgdpimf logmdmh ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap gggrossdebtpctgdpimf logmdmh RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap gggrossdebtpctgdpimf logmdmh BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap gggrossdebtpctgdpimf logmdmh DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg dis2partieswelfare gini_market loggdpcap gggrossdebtpctgdpimf logmdmh nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1




*Other dimensions*  
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonplaneco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1


xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco  gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg daltonmarkeco gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1


xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg  daltonintpeace gini_market loggdpcap logmdmh gggrossdebtpctgdpimf nationalfiscalrulesindex  i.year, fe cluster (countrycode), if oecd==1




*Standard deviation*

*SD rile*
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf  statconDR i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER statconRR statconBBR statconDR i.year, fe cluster (countrycode), if oecd==1

*SD welfare *
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconER i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconRR i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconBBR i.year, fe cluster (countrycode), if oecd==1
xtreg sdwelfare gini_market loggdpcap logmdmh gggrossdebtpctgdpimf statconDR i.year, fe cluster (countrycode), if oecd==1


*SD rile strenght of fiscal rules *
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf ER_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf RR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh gggrossdebtpctgdpimf BBR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf DR_n_strengh i.year, fe cluster (countrycode), if oecd==1
xtreg sdrile gini_market loggdpcap logmdmh  gggrossdebtpctgdpimf nationalfiscalrulesindex i.year, fe cluster (countrycode), if oecd==1


*Alternative marginsplot*
xtreg daltonrile  gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
margins, dydx (gggrossdebtpctgdpimf) over (statconDR)
marginsplot, level(90) ytitle(Effect of government debt on polarization) xtitle(Debt rule status)xlabel(0 "No Rule" 1 "Rule")yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) scheme(s1mono)

xtreg daltonwelfare gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
margins, dydx (gggrossdebtpctgdpimf) over (statconDR)
marginsplot, level(90)  ytitle(Effect of government debt on polarization) xtitle(Debt rule status)xlabel(0 "No Rule" 1 "Rule") yline(0, lstyle(grid) lcolor(gs8) lpattern(dash))graphregion(color(white))legend (off) scheme(s1mono)

xtreg daltonrile  gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
margins, dydx (gggrossdebtpctgdpimf) over (statconDR)
marginsplot, level(95) ytitle(Effect of government debt on polarization) xtitle(Debt rule status)xlabel(0 "No Rule" 1 "Rule")yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) scheme(s1mono)

xtreg daltonwelfare gini_market loggdpcap logmdmh c.gggrossdebtpctgdpimf##c.statconDR i.year, fe cluster (countrycode), if oecd==1
margins, dydx (gggrossdebtpctgdpimf) over (statconDR)
marginsplot, level(95)  ytitle(Effect of government debt on polarization) xtitle(Debt rule status)xlabel(0 "No Rule" 1 "Rule")yline(0, lstyle(grid) lcolor(gs8) lpattern(dash)) graphregion(color(white))legend (off) scheme(s1mono)
