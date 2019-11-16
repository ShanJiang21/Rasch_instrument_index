*** Rasch 

import excel "/Users/shan/Projects/Energy Insecurity/Analysis_June/EFA_coded_0624.xlsx", sheet("EFA_coded_0624") firstrow clear

tab EB2a, m 
tab EB8a, m 
dis 821/2404
dis 821/(2404-30)
tab Race, m 
214 + 88 +32
dis 214 + 88 +32
dis 214 + 88 +32 +35
dis 369/2404
dis 81/2404
 dis 833  /34.64   
dis 81/2404
dis 81/3.37
tab HispanicOrigin , m 
dis  1,492 +  859  
dis  1492 +  859  
dis 2404 - 2351
tab Education  , m 
dis 44 +22
dis  377 +  149    
dis 526/2404
dis 21.88 + 36.9 + 24.1 + 14.4 + 2.8
tab Children  , m 
dis 11/2404
 dis 1245  + 32
 dis 1277/2404
rename HH9 bedroom
tab bedroom, m 
summarize bedroom
tab HH11, m 

tab HH12r1, m 
sum HH12r1
tab HH12r1, m 
tab HH13r1, m 
sum HH13r1, m 
sum HH13r1
his  HH13r1
histogram  HH13r1
tab HH12r1, m 
tab HH12r1 if HH12r1 ==8
tab HH12r1, m 
tab HH7, m 
tab HomeOwnership, m 
tab HH23r1, m 
tab Children HH23r1, m 
tab Children , m 
tab HH23r1, m 
dis 1245 +  32
1661 - 1277
dis 1661 - 1277
dis 2404 - 1661
dis 743/2404
tab HH23r3, m
dis 2404 -1540 
dis 864/2404
tab bedroom, m
sum bedroom
tab HH10, m 
sum HH10
tab HH8, m 
sum bedroom
tab bedroom, m 
sum HH1
gen bedpeople = HH1 / bedroom
tab bedpeople,m 
sum bedpeople
tab EmploymentStatus, m 
sum HH13r1 if Children == 1
sum HH13r1 if child == 1
sum HH13r1 if HH23r1 == 1
sum HH13r1 if HH23r1 == 0
sum HH13r1 if HH23r1 >= 1

gen hhchild = 0 if Children =="None"
replace hhchild = 1 if Children =="1" | Children =="2" | Children =="3" | Children =="4" | Children =="5 or more"
tab Children
replace hhchild = 0 if Children =="0" 
tab hhchild, m 

sum HH13r1 if hhchild == 1
tab hhchild Rent

** generate Low-income indicator 
tab HouseholdIncome

gen lowincome = 1 if HouseholdIncome == "Less than 15,000" 
replace lowincome = 1 if HouseholdIncome == "15,000 to 24,999" & HH1 != 1
replace lowincome = 1 if HouseholdIncome == "25,000 to 49,999" &  HH1 != 1 &2
replace lowincome = 1 if HouseholdIncome == "50,000 to 74,999" &  HH1 != 1 &2 &3 &4 &5
replace lowincome = 1 if HouseholdIncome == "75,000 to 99,999" &  HH1 != 1 &2 &3 &4 &5 &6 &7 &8 
replace lowincome = 0 if ! missing(HouseholdIncome) & lowincome != 1


tab HouseholdIncome HH1
tab lowincome, m 
tab lowincome HH1


**** Generate Age group 

recode Age (18/24=1 "18-24") (25/40=2 "25-40") (41/59=3 "41-59") (60/70=4 "60-70") (71/84 =5 "71-84") (85/150 =6 "85+"), gen(agegroup)

** Ratio2:  
tab lowincome hhchild, m 


** Internal Consistency 
alpha ESC1ar1-CEP8r4

** PCA 
pca  EB7a EB8a 
pca HEC1r1a HEC1r1b HEC1r1c HEC1r1d 
pca  HEC2r1 HEC2r2  HEC2r5 HEC2r6 HEC2r7 HEC2r8 HEC2r10 
pca  HEC2r1 HEC2r2  HEC2r5 HEC2r6 HEC2r7 HEC2r8 HEC2r10 
pca  CEP1-CEP4 CEP6 CEP7 CEP8r2
pca  HEC3r3a-HEC3r3h

**7-dimension model 
mmsrm EB2a EB6r1 EB7a EB8a HEC1r1a HEC1r1b HEC1r1c HEC1r1d HEC2r1 HEC2r2 HEC2r5 HEC2r6 HEC2r7 HEC2r8 HEC2r10 HEC3r3a-HEC3r3h HEC5a HEC6a CEP1-CEP4 CEP6 CEP7 CEP8r2, part(2 2 4 7 8 2 7) nodetails adapt iterate(10)  id(rnid)


**3-dimension model 
