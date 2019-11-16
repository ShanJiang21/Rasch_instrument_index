set more off
import excel "/Users/shan/Projects/EFA_binary_48.xlsx", sheet("EFA_binary_48") firstrow clear
gen female = 1 if Gender  == "Female"
replace female = 0 if Gender  == "Male"
replace female = 1 if Gender  == "0"
 drop if female == .


** Confirmatory Factor analysis 

* Rename variables: by default the capitalized one is the Latent construct 
foreach v of varlist _all {
      capture rename `v' `=lower("`v'")'
   }
   
 * Construct the model 
sem (Energu_burden -> eb2a eb7a eb8a), stand
sem (Housing_costs -> hec1r1a hec1r1b hec1r1c hec1r1d ), stand
sem (Efficiency -> hec2r1 hec2r2 hec2r3 hec2r4 hec2r5 hec2r6 hec2r7 hec2r8 hec2r9 hec2r10 ), stand
sem (Repair -> hec3r3a hec3r3b hec3r3c hec3r3d hec3r3e hec3r3f  hec3r3g hec3r3h), stand
sem (Comfort -> hec4a hec4b hec5 hec5a hec6 hec6a ), stand
sem (Subjective_feel ->  hec5a  hec6a ), stand
sem (Subjective_feel ->  hec5 hec5a hec6 hec6a ), stand
sem (Coping ->  cep1  cep2  cep3  cep4  cep5  cep6  cep7 cep8r1  cep8r2  cep8r3  cep8r4 ), stand
sem (Coping_2 ->     cep8r2  cep8r3 ), stand
sem (Energu_burden -> eb2a eb7a eb8a), stand

* This output gives us :
* standardized factor loading values for each of the observed variables as
* well as their standard error, significance, and confidence intervals.


 *3. Added error term cov.
 
 sem (Housing_costs -> hec1r1a hec1r1b hec1r1c hec1r1d ), cov(e.hec1r1a*e.hec1r1b)stand

 
 * The second-order factor:
  factor  cep1 cep2 cep3 cep4 cep5 cep6 cep7   , ml 
  factor  hec1r1a hec1r1b hec1r1c hec1r1d, ml
  
  factor   hec2r2  hec2r3  hec2r4  hec2r5  hec2r6  hec2r7  hec2r8  , ml
 
  factor  hec2r2 hec2r4  hec2r5  hec2r6  hec2r7   , ml
  factor  hec2r2 hec2r4  hec2r8  hec2r6  hec2r7   , ml
   rotate, oblique quartimin normalize 
 
 * others be proved as heywood cases, while the 4-7 items are actually 
 
 * 4. most precise item structure 
 alpha  eb2a eb7a hec1r1b  hec3r3f  hec5a  cep7 cep8r2, item
 factor  eb2a eb7a hec1r1b  hec3r3f  hec5a cep7 cep8r2 , ml
 
 * Hec5a alpha value is higher than that of HEC6a

 * 5. Multiple cep values
  alpha  eb2a eb7a hec1r1b  hec2r3 hec3r3f  hec5a cep7 cep6 cep2 cep8r2
  factor eb2a eb7a hec1r1b  hec2r3 hec3r3f  hec5a cep7 cep2 cep8r2, ml
  estat kmo
  
  
  *Kaiser-Meyer-Olkin measure of sampling adequacy
  *KMO = 0.8069 
   
  * sufficient factor loading as of 0.3 when n > 300 
   
   * test a complete model 
   sem (Energu_burden -> eb2a eb7a eb8a)(Housing_costs -> hec1r1a hec1r1b hec1r1c hec1r1d ) (Efficiency -> hec2r1 hec2r2 hec2r3 hec2r4 hec2r5 hec2r6 hec2r7 hec2r8 hec2r9) (Repair -> hec3r3a hec3r3b hec3r3c hec3r3d hec3r3e hec3r3f hec3r3g hec3r3h)(Comfort -> hec4a hec4b  hec5a  hec6a )(Subjective_feel ->  hec5a  hec6a )(Subjective_feel ->  hec5 hec5a hec6 hec6a )(Coping ->  cep1  cep2  cep3  cep4  cep5  cep6  cep7) sem (Coping_2 -> cep8r1 cep8r2  cep8r3 cep8r4), stand
  
  * 6. indices 
  
* \\ Assessing Model Goodness of Fit
*     Likelihood Ratio Chi-squared Test (𝜒𝑚𝑠)
* 	  AIC and BIC 
*     Coefficient of Determination (𝑅2)
*     Root Mean Square Error of Approximation (RMSEA): Good Fit (RMSEA < 0.05) 
*     Comparative Fit Index (CFI): CFI > 0.95 (sometimes 0.90) 
*     Tucker-Lewis Index (TLI): TLI > 0.95 
*     Standardized Root Mean Square Residual (SRMR)
*     SRMR < 0.08,  0.056 
  estat gof, stat(all)
  estat mindices
  
* Cannot exist together:
  * hec1r1c  and hec3r3b ;
  * e.hec1r1b,e.hec3r3b;
  *  cov(e.hec6a,e.cep1)
  
  * a. Final model 1:
  sem (Energu_burden -> eb2a@1 eb7a) ///
  (Efficiency ->  hec1r1b hec2r7  hec3r3c)(Comfort ->  hec5a hec6a )(Coping ->  cep6  cep7 cep8r2 ), cov(Energu_burden*Coping)  cov(e.eb2a*e.cep7)  ///
  cov(Energu_burden*Comfort) cov(e.hec3r3c*e.hec5a)  cov(e.cep6*e.cep8r2)  cov(e.eb7a*e.hec3r3c)  cov(e.eb2a*e.cep6)  cov(e.hec1r1b*e.cep6)  cov(e.eb2a*e.cep8r2) cov(e.hec2r7*e.cep8r2) cov(e.hec3r3c*e.hec6a) stand 
  
  alpha eb2a eb7a hec1r1b hec2r7  hec3r3c  hec5a hec6a   cep6  cep7 cep8r2
  
   * b. Final model 2: (add hec3r3f)
   sem (Energu_burden -> eb2a@1 eb7a  ) (Efficiency ->  hec1r1b hec2r7  hec3r3c  hec3r3f)(Comfort ->  hec5a hec6a )(Coping ->  cep6  cep7 cep8r2 ), cov(Energu_burden*Coping) ///
   cov(e.eb2a*e.cep7) cov(Energu_burden*Comfort)  cov(e.hec3r3c*e.hec5a)  cov(e.cep6*e.cep8r2)  cov(e.eb7a*e.hec3r3c)  cov(e.eb2a*e.cep6)  cov(e.hec1r1b*e.cep6)  cov(e.eb2a*e.cep8r2) cov(e.hec2r7*e.cep8r2) cov(e.hec3r3c*e.hec6a)stand
   *0.7705
   
   *  c. Final model 3: 
   sem (Energu_burden -> eb2a@1 eb7a) (Efficiency ->  hec1r1b hec1r1c hec2r7  hec3r3c  hec3r3f)(Comfort ->  hec5a hec6a )(Coping ->  cep6  cep7 cep8r2 ),///
   cov(Energu_burden*Coping)  cov(e.eb2a*e.cep7) cov(Energu_burden*Comfort)  cov(e.hec3r3c*e.hec5a)  cov(e.cep6*e.cep8r2)  cov(e.eb7a*e.hec3r3c)  cov(e.eb2a*e.cep6)  cov(e.hec1r1b*e.cep6)  cov(e.eb2a*e.cep8r2) cov(e.hec2r7*e.cep8r2) cov(e.hec3r3c*e.hec6a) cov(e.hec1r1b*e.hec1r1c) cov(e.hec1r1c*e.hec3r3f) cov(e.hec1r1c*e.cep6)stand
   alpha eb2a eb7a hec1r1b hec1r1c hec2r7  hec3r3c  hec3r3f hec5a hec6a   cep6  cep7 cep8r2
   *0.7855 
 
 
 * https://psu-psychology.github.io/psy-597-SEM/08_fit/sem_fit_modification.html 
 
