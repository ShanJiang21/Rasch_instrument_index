** Rasch model 

import excel "/Users/shan/Projects/EFA_binary_48.xlsx", sheet("EFA_binary_48") firstrow clear
gen female = 1 if Gender  == "Female"
replace female = 0 if Gender  == "Male"
replace female = 1 if Gender  == "0"
 drop if female == .
 
*** 1. Fit the model 
 irt 1pl ESC1ar1-CEP8r4
 
 irt 1pl  EB2a EB8a HEC1r1a HEC1r1c HEC1r1b HEC1r1d HEC2r6 HEC2r8 HEC3r3a HEC3r3b HEC3r3d HEC5a CEP8r2






*** 3. Test for model fit

* (1) LR test
quietly irt 1pl EB2a EB8a HEC1r1a HEC1r1c HEC1r1b HEC1r1d HEC2r6 HEC2r7 HEC2r8 HEC3r3a HEC3r3b HEC3r3d HEC5a CEP8r2
estimates store onepl

quietly irt 2pl EB2a EB8a HEC1r1a HEC1r1c HEC1r1b HEC1r1d HEC2r6 HEC2r7 HEC2r8 HEC3r3a HEC3r3b HEC3r3d HEC5a CEP8r2
estimates store twopls

lrtest onepl twopls

* (2) DIF
* 2.1 Testing for uniform DIF
difmh EB2a EB8a HEC1r1a HEC1r1c HEC1r1b HEC1r1d HEC2r6 HEC2r7 HEC2r8 HEC3r3a HEC3r3b HEC3r3d HEC5a CEP8r2, gr(female)
