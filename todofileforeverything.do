/*first thing we do is to rename the variables of our interest to the specified
name of the question */
rename frprtpl G1
rename gvintcz G2
rename poltran G3
rename ifredu G4
rename ifrjob G5
rename evfredu G6
rename evfrjob G7
/*PRIMO peso tolto, ora creiamo un addictive index*/


/*1.additive index --> pltrtnps
questions G1, G2 and G3, that can be used to obtain an additive index as a
measure of respondent’sperceived level of functioning of the national political
system

to do so I create the additive index pltrtnps
*/


recode 
gen pltrtnps = G1 + G2 + G3 
*indep value

/*2.Additive index --> prlvloppcn
questions from G4 to G7, that can be used to obtain an additive index as a measure of the respondent’sperceived level of opportunities offered by the own countr
*/

gen prlvloppcn = G4 + G5 + G6 + G7   
*dep value

*facciamo vedere che cosa c'è dentro:

tab prlvloppcn
tab pltrtnps

*vediamo se vi è distinzione tra i paesi:

*recoding di country:
recode country (12=0 "Hungary") (1/11 = 1 "Rest of Europe")  (13/19 = 1 "Rest of Europe") , gen (ducountry)


/*should we substute the missing values with 0 ???### NO!!!

*mean comparison deve venire, prima id fare qualsiasi altra operazione 

ttest prlvloppcn, by(ducountry) unequal

*variables are ought to be analyzed
*totale pagine: 5

*control for eduyrs agea gndr
*fixing gndr:

recode gndr (2=0), gen(gndr_r)
tab gndr_r
label define for_gndr 0 "female" 1 "male"
label values gndr_r for_gndr
tab gndr_r



*da fare box plot:



*compute the mean at the level of the sample:
mean pltrtnps, over(ducountry)
bysort(ducountry) : pwcorr depindex independix, sig
bysort ducountry gndr_r: pwcorr depindex independix, sig
/*la donna e allineata a livello europeo*/





regress prlvloppcn pltrtnps ducountry agea du_gndr  eduyrs
regress prlvloppcn pltrtnps agea du_gndr eduyrs

/*
regress prlvloppcn pltrtnps
predict prediction
(option xb assumed; fitted values)
*/