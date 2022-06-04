# Principles of Biostatistics, 3rd Edition, R Code
#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#

# Chapter 2 Further Applications Code

### Table 2.19
install.packages("readstata13")
library(readstata13)
data <- read.dta13(file = "heart_rate.dta")
summary(data$heart_rate)

#------------------------------------------------------------------------------#
# Chapter 9 Further Applications Code

### Table 9.1: CI calculation
n <- 31
m <- 147.4
s <- 6

ci <- cbind(n = rep(n,1),
            x.bar = rep(m,1),
            std = rep(s,1),
            se = rep(s/sqrt(31),1),
            upper = rep(m + 1.96*s/sqrt(31),1),
            lower = rep(m - 1.96*s/sqrt(31),1))
ci

#------------------------------------------------------------------------------#
# Chapter 10 Further Applications Code

### Table 10.1: Z-test
n <- 31
m <- 147.4
s <- 6
mu <- 160

ci <- cbind(n = rep(n,1),
            x.bar = rep(m,1),
            std = rep(s,1),
            null = "H_0: mu = 160",
            alt = "H_1: mu != 160",
            z = rep((m-mu)/(s/sqrt(31)),1),
            p_value = rep(pnorm((m-mu)/(s/sqrt(31))),1),
            se = rep(s/sqrt(31),1),
            upper = rep(m + 1.96*s/sqrt(31),1),
            lower = rep(m - 1.96*s/sqrt(31),1)
)
ci

### Table 10.3: t-test

n <- 7
m <- 151
s <- 9
mu <- 81

ci <- cbind(n = rep(n,1),
            x.bar = rep(m,1),
            std = rep(s,1),
            null = "H_0: mu = 81",
            alt = "H_1: mu != 81",
            z = rep((m-mu)/(s/sqrt(7)),1),
            p_value = rep(1 - pt((m-mu)/(s/sqrt(7)), 6),1),
            se = rep(s/sqrt(7),1),
            df = rep(6, 1),
            upper = rep(m + 2.447*s/sqrt(7),1),
            lower = rep(m - 2.447*s/sqrt(7),1)
)
ci

### Table 10.5: Sample size calculation

library(pwr)
d = -0.5/0.85 # effect size divided by sigma
pwr.norm.test(d = d, sig.level = .05, power = .80, alternative = "less")

#------------------------------------------------------------------------------#
# Chapter 11 Further Applications Code

### Table 11.2
library(foreign)
library(dplyr)
library(readstata13)

data <- read.dta13(file = "cad.dta")
t.test(data$air_percd, data$co_percd, paired = TRUE, var.equal = TRUE, 
       alternative = "two.sided")


### Tables 11.4 and 11.6
# Don't have actual data for these tests - use summary stats instead.
# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE.

t.test2 <- function(m1, m2, s1, s2, n1, n2, m0=0, equal.variance=FALSE)
{
  if( equal.variance == FALSE ) 
  {
    se <- sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df <- ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- (m1-m2-m0)/se 
  dat <- c(m1-m2, se, t, 2*pt(-abs(t),df))    
  names(dat) <- c("Difference of means", "Std Error", "t", "p-value")
  return(dat) 
}

n1 = 8
m1 = 87.38
s1 = 4.56
n2 = 10
m2 = 90.14
s2 = 4.58

# Table 11.4: Assuming equal variance
t.test2(m1, m2, s1, s2, n1, n2, equal.variance = TRUE)

# Table 11.6: Assuming unequal variance
t.test2(m1, m2, s1, s2, n1, n2)


### Table 11.8: Power calculation
library(stats)

power.t.test(n=NULL, delta=3.0, sd=4.6, sig.level=0.05, power=0.9, 
             type="two.sample", alternative="two.sided")

#------------------------------------------------------------------------------#
# Chapter 12 Further Applications Code

### Table 12.3: ANOVA with Bonferroni multiple comparisons procedure
library(readstata13)

data <- read.dta13(file = "weight_change.dta")
results <- aov(wt_change ~ as.factor(group), data = data)
summary(results)

pairwise.t.test(data$wt_change, as.factor(data$group), p.adj = "bonf")

#------------------------------------------------------------------------------#
# Chapter 13 Further Applications Code

### Table 13.7: Wilcoxon signed-rank test
library(readstata13)
library(coin)

data <- read.dta13(file = "neonatal_rep_failure_lvd.dta")

wilcoxsign_test(before~during, data=data)
wilcoxsign_test(before~during, data=data, zero.method = "Wilcoxon")

### Table 13.10: Wilcoxon rank sum test
data <- read.dta13(file = "carbon_monoxide_emphysema.dta")

wilcox.test(capacity ~ group, data=data) 

### Table 13.12: Kruskal-Wallis test
data <- read.dta13(file = "burn.dta")

kruskal.test(opstay_tbsa ~ cause, data = data) 

#------------------------------------------------------------------------------#
# Chapter 14 Further Applications Code

### Table 14.2: Wilson and exact CIs for a proportion

library(DescTools)

BinomCI(8, 33, conf.level = 0.95, method = "wilson")
BinomCI(8, 33, conf.level = 0.95, method = "clopper-pearson")


### Table 14.4: Exact binomial test

binom.test(8, 33, p = 0.023, alternative = "two.sided")


### Table 14.6: Sample size calculation for one proportion

library(EnvStats)

propTestN(.1, .023, alpha = 0.05, power = 0.9, sample.type = "one.sample")

### Table 14.7: Sample size calculation for one proportion

library(pps)
library(sampling)
library(samplingbook)

sample.size.prop(.05, P = 0.2, level = 0.95)

### Table 14.9: CIs for difference and ratio of proportions

library(epibasix)

data <- cbind(c(74, 70), c(76, 80));
summary(epi2x2(data))


### Table 14.11: Sample size calculation for two proportions

power.prop.test(p1 = 0.49, p2 = 0.39, sig.level = 0.05, power = 0.8, 
                alternative = "two.sided")

#------------------------------------------------------------------------------#
# Chapter 15 Further Applications Code

### Table 15.2: Chi-square and Fisher exact tests

ill <- matrix(c(109, 4, 116, 34), ncol = 2,byrow = TRUE)
colnames(ill) <- c("Ate sandwich","Did not each sandwich")
rownames(ill) <- c("Ill","Not ill")
ill <- as.table(ill)
ill

summary(ill)

### Table 15.4: McNemar's test

smoke <- matrix(c(620, 97, 76, 1317), ncol = 2, byrow = TRUE)
colnames(smoke) <- c("Exposed","Unexposed")
rownames(smoke) <- c("Exposed","Unexposed")
smoke <- as.table(smoke)

mcnemar.test(smoke, y = NULL, correct = FALSE)

mcnemar.test(smoke, y = NULL, correct = TRUE)

#------------------------------------------------------------------------------#
# Chapter 16 Further Applications Code

### Table 16.6: Pearson correlation coefficient
library(readstata13)
library(foreign)
library(ggplot2)
library(dplyr)

data <- read.dta13(file = "fvc_fev.dta")
cor.test(data$fev, data$fvc, method = "pearson")

### Table 16.8: Spearman correlation coefficient

cor.test(data$fev, data$fvc, method = "spearman")

#------------------------------------------------------------------------------#
# Chapter 17 Further Applications Code

### Table 17.2: Simple linear regression
library(readstata13)
library(foreign)
library(ggplot2)
library(dplyr)

data <- read.dta13(file = "lowbwt_hc.dta")

m <- lm(length ~ gestage, data = data)
summary(m)

#------------------------------------------------------------------------------#
# Chapter 18 Further Applications Code

### Table 18.3: Multiple linear regression

library(readstata13)
library(foreign)

data <- read.dta13(file = "lowbwt_hc.dta")
m <- lm(length ~ gestage + momage, data = data)
summary(m)

### Table 18.5: Multiple linear regression

m <- lm(length ~ gestage + preeclamp, data = data)
summary(m)

### Table 18.7: Multiple linear regression with interaction term

m <- lm(length ~ gestage + preeclamp + gestage*preeclamp, data = data)
summary(m)

### Table 18.9: Multiple linear regression with indicator variable

m <- lm(length ~ ga_28_29 + ga_30_31 + ga_ge32, data = data)
summary(m)


#------------------------------------------------------------------------------#
# Chapter 19 Further Applications Code

### Table 19.7: Logistic regression

library(readstata13)
library(foreign)

data <- read.dta13(file = "gmh.dta")

m <- glm(gmh ~ headcirc, data = data, family = "binomial")
summary(m)

### Table 19.10: Logistic regression

m <- glm(gmh ~ sex, data = data, family = "binomial")
summary(m)

#------------------------------------------------------------------------------#
# Chapter 20 Further Applications Code

### Table 20.15:
library(readstata13)
library(foreign)
library(survival)
library(survminer)

data <- read.dta13(file = "brain_metastasis.dta")

surv_diff <- survdiff(Surv(survival, censor) ~ treatment, data = data)
surv_diff

### Table 20.17:

coxph(Surv(survival, censor) ~ treatment, data = data)






