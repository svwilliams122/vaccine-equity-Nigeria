*Housekeeping
cd C:\Useras\willi\Documents\Masters\Project\DHS Nigeria 2018 stata
use "C:\Users\willi\Documents\Masters\Project\DHS Nigeria 2018 stata\NGKR7AFL.DTA"
log using ses2.log, replace
*Make weight variable and strata
gen weight=v005/1000000
gen strata=v024
replace strata=v024*100 if v025==2
svyset v021 [pweight=weight], strata(strata)single(cen)
*rename variables characteristics
rename b4 childsex
rename b19 childagemth
rename v714 employed
rename v130 religion
rename v170 bankaccount
rename v151 sexhh
rename v190 wealthindex
rename v190a wealthindexur
rename v481 healthinsur
rename b5 childdead
rename v140 urbrurdj
rename v139 regiondj
rename v101 regiondf
rename v102 urbrurdf
rename v717 occupation

*Generate binary variables and smaller number of categories
gen ethnicity=v131
recode ethnicity 1 = 1 2 = 2 3 = 3 4 = 4 5 = 5 6 = 6 7 = 7 8 = 8 9 = 9 10 = 10 96/98 = 11
label var ethnicity "Ethnicity"
label define ethnicitycodes 1 "Ekoi" 2 "Fulani" 3 "Hausa" 4 "Ibibio" 5 "Igala" 6 "Igbo" 7 "Ijaw/Izon" 8 "Kanuri/Beriberi" 9 "Tiv" 10 "Yoruba" 11 "Other/Don't know"
label values ethnicity ethnicitycodes

gen bthorder=bord
recode bthorder 1 = 1 2/3 = 2 4/5 = 3 6/max = 4
label var bthorder "Birthorder"
label define bthordercodes 1 "1st born" 2 "2nd - 3rd born" 3 "4th - 5th born" 4 "6th born or higher"
label values bthorder bthordercodes

gen totchild=v201
recode totchild 1/2 = 1 3/5 = 2 6/9 = 3 10/max = 4
label var totchild "Total number of children"
label define totchildcodes 1 "1 - 2" 2 "3 - 5" 3 "6 - 9" 4 "10 or more"
label values totchild totchildcodes

gen lit=v155
recode lit 1/2 = 1 0 = 0 3/4 = 0
label var lit "Able to read"
label define litcodes 0 "No" 1 "Yes"
label values lit litcodes

gen matage=v012
recode matage 15/19 = 1 20/34 = 2 35/49 = 3
label var matage "Maternal age now"
label define matagecodes 1 "15 - 19 years" 2 "20 - 34 years" 3 "35 - 49 years"
label values matage matagecodes

gen age1stb=v212
recode age1stb min/14 = 1 15/19 = 2 20/34 = 3 35/49 = 4
label var age1stb "Age at 1st birth"
label define age1stbcodes 1 "Under 15 years" 2 "15 - 19 years" 3 "20 - 34 years" 4 "35 - 49 years"
label values age1stb age1stbcodes

gen ownshouse=v745a
recode ownshouse 0 = 0 1/3 = 1
label var ownshouse "Owns house"
label define ownshousecodes 0 "No" 1 "Yes, alone or jointly"
label values ownshouse ownshousecodes

gen ownsland=v745b
recode ownsland 0 = 0 1/3 = 1
label var ownsland "Owns land"
label define ownslandcodes 0 "No" 1 "Yes, alone or jointly"
label values ownsland ownslandcodes

gen agehh=v152
recode agehh min/19 = 1 20/49 = 2 50/65 = 3 66/max = 4
label var agehh "Age of head of household"
label define agehhcodes 1 "Under 20 years" 2 "20 - 49 years" 3 "50 - 65 years" 4 "Aged over 65 years"
label values agehh agehhcodes

gen delivery=m15
recode delivery 11/12 = 1 21/36 = 2 96 = 3
label var delivery "Birth setting"
label define deliverycodes 1 "Home setting" 2 "Public or private facility" 3 "Other"
label values delivery deliverycodes

gen anc=m14
recode anc 0 = 1 98 = 1 1/3 = 2 4/20 = 3
label var anc "Antenatal care"
label define anccodes 1 "None/Don't know" 2 "1 - 3 visits" 3 "4 or more visits"
label values anc anccodes

gen edulevel = v106
recode edulevel 0 = 1 1 = 2 2/3 = 3
label var edulevel "Education level"
label define edulevelcodes 1 "No education" 2 "Primary education" 3 "Secondary or higher"
label values edulevel edulevelcodes

*Make vaccination age category
gen agevac = childagemth
recode agevac min/11 = 1 12/23 = 2 24/max = 3
label var agevac "Grouped child ages, months"
label define agevaccodes 1 "<12 months" 2 "12-23 months" 3 "24-59 months"
label values agevac agevaccodes

*Generate vaccination variables
gen healthcard = h1
recode healthcard 1/2 = 1 0 = 0 3 = 0
label var healthcard "Has healthcard"
label define healthcardcodes 1 "Yes" 0 "No"
label values healthcard healthcardcodes

gen bcg = h2
recode bcg 1/3 = 1 0 = 0 8 = 0
label var bcg "Received BCG"
label define bcgcodes 1 "Yes" 0 "No/Don't know"
label values bcg bcgcodes

gen dpt1 = h3
recode dpt1 1/3 = 1 0 =0 8 =0
label var dpt1 "Received DPT1"
label define dpt1codes 1 "Yes" 0 "No/Don't know"
label values dpt1 dpt1codes

gen polio1=h4
recode polio1 1/3 = 1 0 = 0 8 = 0
label var polio1 "Received polio1"
label define polio1codes 1 "Yes" 0 "No/Don't know"
label values polio1 polio1codes

gen dpt2=h5
recode dpt2 1/3 = 1 0 =0 8 = 0
label var dpt2 "Received DPT2"
label define dpt2codes 1 "Yes" 0 "No/Don't know"
label values dpt2 dpt2codes

gen polio2=h6
recode polio2 1/3 = 1 0 = 0 8 = 0
label var polio2 "Received polio 2"
label define polio2codes 1 "Yes" 0 "No/Don't know"
label values polio2 polio2codes

gen dpt3=h7
recode dpt3 1/3 = 1 0 = 0 8 = 0
label var dpt3 "Received DPT 3"
label define dpt3codes 1 "Yes" 0 "No/Don't know"
label values dpt3 dpt3codes

gen polio3=h8
recode polio3 1/3 = 1 0 = 0 8 = 0
label var polio3 "Received polio 3"
label define polio3codes 1 "Yes" 0 "No/Don't know"
label values polio3 polio3codes
 
gen measles1=h9
recode measles1 1/3 =1 0 = 0 8 = 0
label var measles1 "Received measles 1"
label define measles1codes 1 "Yes" 0 "No/Don't know"
label values measles1 measles1codes

gen measles2=h9a
recode measles2 1/3 = 1 0 = 0 8 = 0
label var measles2 "Received measles 2" 
label define measles2codes 1 "Yes" 0 "No/Don't know"
label values measles2 measles2codes

gen poliobirth=h0
recode poliobirth 1/3 =1 0 = 0 8 = 0
label var poliobirth "Received polio at birth"
label define poliobirthcodes 1 "Yes" 0 "No/Don't know"
label values poliobirth poliobirthcodes

gen evervac=h10
recode evervac 0 = 0 1 = 1 8 = 0
label var evervac "Ever had any vaccination if no healthcard"
label define evervaccodes 1 "Yes" 0 "No/Don't know"
label values evervac evervaccodes
 
gen hepbbirth=h50
recode hepbbirth 1/3 = 1 0 =0 8 = 0
label var hepbbirth "Received Hep B at birth"
label define hepbbirthcodes 1 "Yes" 0 "No/Don't know"
label values hepbbirth hepbbirthcodes

gen penta1=h51
recode penta1 1/3 = 1 0 = 0 8 = 0
label var penta1 "Received pentavalent 1"
label define penta1codes 1 "Yes" 0 "No/Don't know"
label values penta1 penta1codes

gen penta2=h52
recode penta2 1/3 = 1 0 = 0 8 = 0
label var penta2 "Received pentavalent 2"
label define penta2codes 1 "Yes" 0 "No/Don't know"
label values penta1 penta2codes

gen penta3=h53
recode penta3 1/3 = 1 0 = 0 8 = 0
label var penta3 "Received pentavalent 3"
label define penta3codes 1 "Yes" 0 "No/Don't know"
label values penta3 penta3codes

gen pneumo1=h54
recode pneumo1 1/3 = 1 0 = 0 8 = 0
label var pneumo1 "Received Pneumococcal 1"
label define pneumo1codes 1 "Yes" 0 "No/Don't know"
label values pneumo1 pneumo1codes

gen pneumo2=h55
recode pneumo2 1/3 = 1 0 = 0 8 = 0
label var pneumo2 "Received Pneumococcal 2"
label define pneumo2codes 1 "Yes" 0 "No/Don't know"
label values pneumo2 pneumo2codes

gen pneumo3=h56
recode pneumo3 1/3 = 1 0 = 0 8 = 0
label var pneumo3 "Received Pneumococcal 3"
label define pneumo3codes 1 "Yes" 0 "No/Don't know"
label values pneumo3 pneumo3codes
 
gen polioinactive=h60
recode polioinactive 1/3 = 1 0 = 0 8 = 0
label var polioinactive "Received polio inactive"
label define polioinactivecodes 1 "Yes" 0 "No/Don't know"
label values polioinactive polioinactivecodes

gen hepb1=h61
recode hepb1 1/3 = 1 0 = 0 8 = 0
label var hepb1 "Received Hep B 1"
label define hepb1codes 1 "Yes" 0 "No/Don't know"
label values hepb1 hepb1codes

gen hepb2=h62
recode hepb2 1/3 = 1 0 = 0 8 = 0
label var hepb2 "Received Hep B 2"
label define hepb2codes 1 "Yes" 0 "No/Don't know"
label values hepb2 hepb2codes

gen hepb3=h63
recode hepb3 1/3 = 1 0 = 0 8 = 0 
label var hepb3 "Received Hep B 3" 
label define hepb3codes 1 "Yes" 0 "No/Don't know"
label values hepb3 hepb3codes 
 
gen hib1=h64
recode hib1 1/3 = 1 0 = 0 8 = 0
label var hib1 "Received Hib 1"
label define hib1codes 1 "Yes" 0 "No/Don't know"
label values hib1 hib1codes
 
gen hib2=h65 
recode hib2 1/3 = 1 0 = 0 8 = 0
label var hib2 "Received Hib 2"
label define hib2codes 1 "Yes" 0 "No/Don't know"
label values hib2 hib2codes

gen hib3=h66 
recode hib3 1/3 = 1 0 = 0 8 = 0
label var hib3 "Received Hib 3"
label define hib3codes 1 "Yes" 0 "No/Don't know"
label values hib3 hib3codes
*Generate combined vaccination variables
gen dptall = dpt1 + dpt2 + dpt3
recode dptall 3 = 1 min/2 = 0
label var dptall "Received all three DPT"
label define dptallcodes 1 "Yes" 0 "No/Don't know"
label values dptall dptallcodes

gen nodpt = dpt1 + dpt2 + dpt3
recode nodpt 0 = 0 1/3 = 1
label var nodpt "Received no DPT vaccines"
label define nodptcodes 0 "None" 1 "At least one dose"
label values nodpt nodptcodes

gen hiball = hib1 + hib2 + hib3
recode hiball 3 = 1 min/2 = 0
label var hiball "Received all three hib"
label define hiballcodes 1 "Yes" 0 "No/Don't know"
label values hiball hiballcodes

gen polioall = polio1 + polio2 + polio3
recode polioall 3 = 1 min/2 = 0
label var polioall "Received all three polio"
label define polioallcodes 1 "Yes" 0 "No/Don't know"
label values polioall polioallcodes

gen nopolio = polio1 + polio2 + polio3
recode nopolio 0 = 0 1/3 = 1
label var nopolio "Received no polio"
label define nopoliocodes 0 "None" 1 "At least one dose"
label values nopolio nopoliocodes

gen pentaall = penta1 + penta2 + penta3
recode pentaall 3 = 1 min/2 = 0
label var pentaall "Received all three pentavalent"
label define pentaallcodes 1 "Yes" 0 "No/Don't know"
label values pentaall pentallcodes

gen pneumoall = pneumo1 + pneumo2 + pneumo3
recode pneumoall 3 = 1 min/2 = 0
label var pneumoall "Received all three pneumococcal"
label define pneumoallcodes 1 "Yes" 0 "No/Don't know"
label values pneumoall pneumoallcodes

gen hepball = hepb1 + hepb2 + hepb3
recode hepball 3 = 1 min/2 = 0
label var hepball "Received all three hep b"
label define hepballcodes 1 "Yes" 0 "No/Don't know"
label values hepball hepballcodes

gen measlesall = measles1 + measles2
recode measlesall 2 = 1 min/1 = 0
label var measlesall "Received both doses of measles"
label define measlesallcodes 1 "Yes" 0 "No/Don't know"
label values measlesall measlesallcodes

gen basicvac = bcg + dptall + polioall + measles1
recode basicvac 4 = 1 min/3 = 0
label var basicvac "Received all basic vaccinations"
label define basicvaccodes 1 "Yes" 0 "No/Don't know"
label values basicvac basicvaccodes

gen nobasicv = bcg + nodpt + nopolio + measles1
recode nobasicv 0 = 0 1/max = 1
label var nobasicv "Received no basic vaccinations"
label define nobasicvcodes 0 "No doses" 1 "At least one dose"
label values nobasicv nobasicvcodes

*basic vaccination coverage and confidence intervals
svy: tab healthcard agevac, col
/*tab bcg if agevac==2 is also an option*/

svy, subpop(if agevac==2): tab healthcard, ci col
svy, subpop(if agevac==2): tab bcg, ci col
svy, subpop(if agevac==2): tab polio1, ci col
svy, subpop(if agevac==2): tab polio2, ci col
svy, subpop(if agevac==2): tab polio3, ci col
svy, subpop(if agevac==2): tab polioall, ci col
svy, subpop(if agevac==2): tab dpt1, ci col
svy, subpop(if agevac==2): tab dpt2, ci col
svy, subpop(if agevac==2): tab dpt3, ci col
svy, subpop(if agevac==2): tab dptall, ci col
svy, subpop(if agevac==2): tab measles1, ci col
svy, subpop(if agevac==2): tab basicvac, ci col

*missing data
misstable summarize agevac

*children alive in vaccination data
tab childdead basicvac

*basic vaccination coverage, ci, and observations for rural/urban
/*adding in se after comma gives standard error, and don't need to do section above*/
svy, subpop(if agevac==2): tab healthcard v025, ci col obs
svy, subpop(if agevac==2): tab bcg v025, ci col obs
svy, subpop(if agevac==2): tab polio1 v025, ci col obs
svy, subpop(if agevac==2): tab polio2 v025, ci col obs
svy, subpop(if agevac==2): tab polio3 v025, ci col obs
svy, subpop(if agevac==2): tab polioall v025, ci col obs
svy, subpop(if agevac==2): tab dpt1 v025, ci col obs
svy, subpop(if agevac==2): tab dpt2 v025, ci col obs
svy, subpop(if agevac==2): tab dpt3 v025, ci col obs
svy, subpop(if agevac==2): tab dptall v025, ci col obs
svy, subpop(if agevac==2): tab measles1 v025, ci col obs
svy, subpop(if agevac==2): tab basicvac v025, ci col obs
svy, subpop(if agevac==2): tab nopolio v025, ci col obs
svy, subpop(if agevac==2): tab nodpt v025, ci col obs
svy, subpop(if agevac==2): tab nobasicv v025, ci col obs

*calculating inequities in coverage and crude OR
svy, subpop(if agevac==2): tab basicvac childsex, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.childsex, base

svy, subpop(if agevac==2): tab basicvac edulevel, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.edulevel, base
test 2.edulevel 3.edulevel

svy, subpop(if agevac==2): tab basicvac ethnicity, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.ethnicity, base
test 1.ethnicity 2.ethnicity 3.ethnicity 4.ethnicity 5.ethnicity 7.ethnicity 8.ethnicity 9.ethnicity 10.ethnicity 11.ethnicity

svy, subpop(if agevac==2): tab basicvac employed, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.employed, base

svy, subpop(if agevac==2): tab basicvac occupation, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.occupation, base
test 2.occupation 3.occupation 7.occupation 8.occupation 9.occupation 10.occupation 11.occupation

svy, subpop(if agevac==2): tab basicvac sexhh, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.sexhh, base

svy, subpop(if agevac==2): tab basicvac wealthindexur, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.wealthindexur, base
test 2.wealthindexur 3.wealthindexur 4.wealthindexur 5.wealthindexur

svy, subpop(if agevac==2): tab basicvac healthinsur, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.healthinsur, base

svy, subpop(if agevac==2): tab basicvac regiondf, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.regiondf, base
test 2.regiondf 3.regiondf 4.regiondf 5.regiondf 6.regiondf

svy, subpop(if agevac==2): tab basicvac urbrurdf, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.urbrurdf, base

svy, subpop(if agevac==2): tab basicvac v701, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.v701, base
test 1.v701 2.v701 3.v701 8.v701

svy, subpop(if agevac==2): tab basicvac v705, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.v705, base
test 1.v705 2.v705 3.v705 4.v705 7.v705 8.v705 9.v705 96.v705 98.v705

svy, subpop(if agevac==2): tab basicvac v502, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.v502, base
test 1.v502 2.v502 

svy, subpop(if agevac==2): tab basicvac bthorder, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.bthorder, base
test 2.bthorder 3.bthorder 4.bthorder 

svy, subpop(if agevac==2): tab basicvac totchild, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.totchild, base
test 2.totchild 3.totchild 4.totchild

svy, subpop(if agevac==2): tab basicvac lit, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.lit, base

svy, subpop(if agevac==2): tab basicvac matage, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.matage, base
test 2.matage 3.matage 

svy, subpop(if agevac==2): tab basicvac age1stb, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.age1stb, base
test 2.age1stb 3.age1stb 4.age1stb

svy, subpop(if agevac==2): tab basicvac ownshouse, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.ownshouse, base

svy, subpop(if agevac==2): tab basicvac ownsland, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.ownsland, base

svy, subpop(if agevac==2): tab basicvac agehh, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.agehh, base
test 2.agehh 3.agehh 4.agehh

svy, subpop(if agevac==2): tab basicvac anc, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.anc, base
test 2.anc 3.anc

svy, subpop(if agevac==2): tab basicvac delivery, ci col obs
svy, subpop(if agevac==2): logistic basicvac i.delivery, base
test 2.delivery 3.delivery

*multiple regression
svy, subpop(if agevac==2): logistic basicvac i.urbrurdf i.wealthindexur i.regiondf i.edulevel i.sexhh i.childsex i.bthorder i.matage i.religion i.v502 i.ethnicity i.agehh i.age1stb i.lit i.employed i.occupation i.healthinsur i.totchild i.ownshouse i.ownsland i.v701 i.v705

svy, subpop(if agevac==2): logistic basicvac i.urbrurdf i.regiondf i.wealthindexur i.sexhh i.edulevel i.matage ib6.ethnicity i.childsex i.religion i.anc i.delivery

svy, subpop(if agevac==2): logistic basicvac i.wealthindexur i.religion ib6.ethnicity i.regiondf i.urbrurdf i.matage i.edulevel i.sexhh i.childsex i.bthorder i.anc i.delivery

*concentration index
*install conindex 
gen basicvac2 = basicvac if agevac==2
gen polioall2 = polioall if agevac==2
gen dptall2 = dptall if agevac==2
gen measles1age = measles1 if agevac==2
gen bcg2 = bcg if agevac==2
gen healthcard2 = healthcard if agevac==2
gen nobasicv2 = nobasicv if agevac==2
gen nopolio2 = nopolio if agevac==2
gen nodpt2 = nodpt if agevac==2

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(matage) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(matage) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(matage) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(matage) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(matage) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(wealthindexur) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(matage) limits(0 1) bounded wagstaff svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(edulevel) limits(0 1) bounded wagstaff svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(wealthindexur) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(matage) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex polioall2, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex dptall2, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex measles1age, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex bcg2, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex healthcard2, rankvar(edulevel) limits(0 1) bounded erreyger svy

svyset v021 [pweight=weight], strata(strata)single(cen)
conindex nobasicv2 rankvar(wealthindexur) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex nobasicv2, rankvar(matage) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex nobasicv2, rankvar(edulevel) limits(0 1) bounded erreyger svy
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex nobasicv2, rankvar(anc) limits(0 1) bounded erreyger svy

*draw concentration index curve
svyset v021 [pweight=weight], strata(strata)single(cen)
conindex basicvac2, rankvar(wealthindexur) truezero svy graph ytitle(Cumulative percentage of children with basic vaccination) xtitle(Cumulative percentage of children by household wealth)

*investigate collinearity
svy, subpop(if agevac==2): regress bthorder wealthindexur anc delivery urbrurdf regiondf ethnicity religion matage edulevel
display "tolerance = " 1-e(r2) " VIF = " 1/(1-e(r2))

*investigate interaction
svy, subpop(if agevac==2): logistic basicvac i.urbrurdf i.regiondf i.matage##i.edulevel i.wealthindexur i.sexhh i.childsex i.bthorder i.delivery i.anc i.ethnicity i.religion

contrast matage#edulevel
 
*do for all interactions
*final model
svy, subpop(if agevac==2): logistic basicvac i.regiondf i.matage i.edulevel i.urbrurdf##i.wealthindexur i.sexhh i.childsex i.bthorder i.delivery i.anc i.ethnicity i.religion
