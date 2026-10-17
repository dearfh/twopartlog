*------------------------------------------------------------------------------
* Master Replication & Testing Script (Clean Do-File)
* Paper: Lien, Hu, & Liu (2025)
* Author: Dereje Fedasa Hordofa, Dire Dawa University
*------------------------------------------------------------------------------

version 16.0
clear all
set more off

* 1. Set working directory to where your twopartlog.ado file is saved
cd "C:\Users\user\Desktop\Learn\stata\2"

* 2. Clear memory and load the built-in dataset
program drop _all
capture mata: mata clear
sysuse auto, clear

* 3. Prepare variables matching Lien, Hu, & Liu (2025) framework:
gen y = ln(price)
gen x = weight * 0.5
replace x = 0 if foreign == 0  // Generates 52 exact zeros

di as text _n "=== 1. PRE-TEST: CHECKING ZERO MASS POINT IN X ==="
count if x == 0
di as text "Number of zero values in x: " r(N)

* 4. Run replication models using our separate twopartlog command
di as text _n "=== MODEL A: GSLT with Fixed c = 1 ==="
twopartlog y x, generate(trans_gslt_c1) method(gslt) c_fixed(1)
estimates store Model_A

di as text _n "=== MODEL B: GSLT with Estimated Optimal c ==="
twopartlog y x, generate(trans_gslt_opt) method(gslt) grid(50)
estimates store Model_B

di as text _n "=== MODEL C: GIHST with Estimated Optimal c ==="
twopartlog y x, generate(trans_gihst_opt) method(gihst) grid(50)
estimates store Model_C

* 5. Print Publication Comparison Table
di as text _n "=== PUBLICATION ESTIMATION COMPARISON TABLE ==="
estimates table Model_A Model_B Model_C, b(%9.4f) se(%9.4f) stats(N r2 c_opt elasticity test_continuity)

di as text _n "=== MASTER REPLICATION COMPLETED SUCCESSFULLY! ==="
