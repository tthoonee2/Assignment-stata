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

gen pltrtnps = G1 + G2 + G3


/*2.Additive index --> prlvloppcn
questions from G4 to G7, that can be used to obtain an additive index as a measure of the respondent’sperceived level of opportunities offered by the own countr
*/

gen prlvloppcn = G4 + G5 + G6 + G7

*facciamo vedere che cosa c'è dentro:

tab prlvloppcn
tab pltrtnps

*vediamo se vi è distinzione tra i paesi:





