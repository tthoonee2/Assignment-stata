/*first thing we do is to rename the variables of our interest to the specified
name of the question */
rename frprtpl G1
rename gvintcz G2
rename poltran G3
rename ifredu G4
rename ifrjob G5
rename evfredu G6
rename evfrjob G7



/*1.additive index --> indep_pl
questions G1, G2 and G3, that can be used to obtain an additive index as a
measure of respondent’sperceived level of functioning of the national political
system

to do so I create the additive index indep_pl
*/



gen indep_pl = G1 + G2 + G3 
*indep value

/*2.Additive index --> dep_pr
questions from G4 to G7, that can be used to obtain an additive index as a measure of the respondent’sperceived level of opportunities offered by the own countr
*/

gen dep_pr = G4 + G5 + G6 + G7   
*dep value

*facciamo vedere che cosa c'è dentro:

tab dep_pr
tab indep_pl

*vediamo se vi è distinzione tra i paesi:

*recoding di country:
recode country (12=0 "Hungary") (1/11 = 1 "Rest of Europe")  (13/19 = 1 "Rest of Europe") , gen (ducountry)


/*should we substitute the missing values with 0 ???### NO!!!

*mean comparison deve venire, prima id fare qualsiasi altra operazione 
*/
ttest dep_pr, by(ducountry) unequal

*variables are ought to be analyzed
*totale pagine: 5

*control for eduyrs agea gndr
*fixing gndr:

recode gndr (2=0), gen(gndr_r)
tab gndr_r
label define for_gndr 0 "female" 1 "male"
label values gndr_r for_gndr
tab gndr_r



*da fare box plot: FOLLOW



*compute the mean at the level of the sample:
mean indep_pl, over(ducountry)
bysort ducountry : pwcorr dep_pr indep_pl, sig
bysort ducountry gndr_r: pwcorr dep_pr indep_pl, sig
/*la donna e allineata a livello europeo*/





regress dep_pr indep_pl ducountry agea gndr_r  eduyrs
regress dep_pr indep_pl agea gndr_r eduyrs

/*
regress dep_pr indep_pl
predict prediction
(option xb assumed; fitted values)
*/




/*ALL ADDITIONAL ANALYSIS  - EXPLAINED IN DETAIL IN THE REPORT*/
hist eduyrs
mean G1 G2 G3 G4 G5 G6 G7
sum  G1 G2 G3 G4 G5 G6 G7
sum indep_pl, d
codebook indep_pl
Graph box indep_pl
sum indep_pl, d
codebook indep_pl
mean indep_pl, level(##)
ssc install ciplot
ciplot indep_pl, level(##) horizontal  
mean indep_pl, over(ducountry)
ttest indep_pl, by(ducountry) unequal
mean dep_pr, over(ducountry)
tab gndr_r,  sum (dep_pr)
ttest dep_pr, by (gndr_r) unequal
tab ducountry , sum (dep_pr)
ttest dep_pr, by (ducountry) unequal
pwcorr dep_pr agea, sig
pwcorr dep_pr eduyrs, sig
pwcorr dep_pr indep_pl, sig

bysort ducountry gndr_r: pwcorr dep_pr indep_pl, sig
regress dep_pr indep_pl eduyrs agea gndr_r ducountry
