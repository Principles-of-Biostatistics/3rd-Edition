* Principles of Biostatistics, 3rd Edition, Stata Code
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

* Chapter 2 Further Applications

*** Table 2.18
summarize heart_rate, detail

*------------------------------------------------------------------------------*

* Chapter 9 Further Applications

*** Table 9.2
* Note that we did not have a dataset for this table and used the following 
* code:
cii mean 20 10.8 2.9

* If we did have the dataset, we would have used something similar to this code:
ci mean score_methyl

*** Table 9.3
* Note that we did not have a dataset for this table and used the following 
* code:
cii mean 20 14.0 4.8

* If we did have the dataset, we would have used something similar to this code:
ci mean score_placebo

*------------------------------------------------------------------------------*

* Chapter 10 Further Applications

*** Table 10.2
* Note that the paper only reports a mean and sd and we did not have a dataset
* for this table. The code we used is:
ttesti 7 151 9 81

* If we did have the dataset, we would have used something similar to this code:
ttest benzene = 81

*** Table 10.4
power onemean 12.29 11.79, sd(0.85) power(.8) onesided

*------------------------------------------------------------------------------*

* Chapter 11 Further Applications

*** Table 11.1
ttest air_percd == co_percd

*** Table 11.3
* Note that we did not have a dataset for this table and used the following 
* code:
ttesti 8 87.38 4.56 10 90.14 4.58

* If we did have the dataset, we would have used something similar to this code:
ttest absorption, by(group)

*** Table 11.5
* Note that we did not have a dataset for this table and used the following 
* code:
ttesti 8 87.38 4.56 10 90.14 4.58, unequal

* If we did have the dataset, we would have used something similar to this code:
ttest absorption, by(group) unequal

*** Table 11.7
power twomeans 87 90, sd1(4.6) sd2(4.6) power(.9)

*------------------------------------------------------------------------------*

* Chapter 12 Further Applications

*** Table 12.2
oneway wt_change group, tabulate bonferroni


*------------------------------------------------------------------------------*

* Chapter 13 Further Applications

*** Table 13.6
signrank before = during

*** Table 13.9
ranksum capacity, by(group)

*** Table 13.11
kwallis opstay_tbsa, by(cause)

*------------------------------------------------------------------------------*

* Chapter 14 Further Applications

*** Table 14.1
cii proportions 33 8, wilson
cii proportions 33 8

*** Table 14.3
bitesti 33 8 .023

*** Table 14.5
power oneproportion .023 .1, power(.9)

*** Table 14.8
* Note that we did not have a dataset for this table and used the following 
* code:
csi 74 70 76 80

* If we did have the dataset, we would have used something similar to this code:
cs asthma drug

*** Table 14.10
power twoproportion .49 .39, power(.8)

*------------------------------------------------------------------------------*

* Chapter 15 Further Applications

*** Table 15.1
* Note that we did not have a dataset for this table and used the following 
* code:
tabi 109 4 \ 116 34, chi2 exact

* If we did have the dataset, we would have used something similar to this code:
tabulate health sandwich

*** Table 15.3
* Note that we did not have a dataset for this table and used the following 
* code:
mcci 620 97 76 1317

* If we did have the dataset, we would have used something similar to this code:
mcc smoke1 smoke2

*------------------------------------------------------------------------------*

* Chapter 16 Further Applications

*** Table 16.5
pwcorr fvc fev, sig obs

*** Table 16.7
spearman fvc fev

*------------------------------------------------------------------------------*

* Chapter 17 Further Applications

*** Table 17.1
regress length gestage

*------------------------------------------------------------------------------*

* Chapter 18 Further Applications

*** Table 18.2
regress length gestage momage

*** Table 18.4
regress length gestage preeclamp

*** Table 18.6
gen gesttox = gestage*preeclamp

regress length gestage preeclamp gesttox

*** Table 18.8
regress length ga_28_29 ga_30_31 ga_ge32

*------------------------------------------------------------------------------*

* Chapter 19 Further Applications

*** Table 19.6
logit gmh headcirc

*** Table 19.9
logit gmh sex
logistic gmh headcirc

*------------------------------------------------------------------------------*

* Chapter 20 Further Applications

*** Table 20.14
sts test treatment, logrank

*** Table 20.16
stcox treatment

