###############################################
###############################################
#########         CHAPTER 6             #######
###############################################
###############################################


# install.packages("survival"    , dependencies=TRUE)
# install.packages("sas7bdat"    , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)
# install.packages("jtools"      , dependencies=TRUE)
# install.packages("epiDisplay"  , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)


#### https://cran.r-project.org/web/packages/jtools/jtools.pdf
#### https://cran.r-project.org/web/packages/jtools/

library(learnr)
library(sas7bdat)
library(jtools)
library(survival)

library(vars)
library(caret)
library(corrplot)
library(MASS)
library(pROC)
library(optiRum)
library(dplyr)
library(smbinning)


###############################################
#####   Step 1  -- Read in the SAS data  ######
###############################################

k401 <- read.sas7bdat("k401.sas7bdat")


ls(k401)
# "Age"   "Age2" "Id_number" "Logemp"    "Logemp2"   "Mrate"    
# "Prate" "Sole" "Totemp"   


############################################################
############################################################
############################################################
####### Chapter 6 - Program 2 - Page 105 - Model 1   #######
############################################################
############################################################
############################################################


options(show.signif.stars = FALSE)

# Model Fitting

model_1 <- lm(formula=Prate ~ Mrate +Logemp +Logemp2 +
                    Age +Age2 +Sole, data=k401)


### or using summ from jtools package

summ(model_1, digits = 5)
summary(model_1)

rm("model_1") ## remove model


# 
# MODEL INFO:
#         Observations: 4734
# Dependent Variable: Prate
# Type: OLS linear regression 
# 
# MODEL FIT:
#         F(6,4727) = 132.76268, p = 0.00000
# R² = 0.14421
# Adj. R² = 0.14313 
# 
# Standard errors: OLS
# -----------------------------------------------------------
#                      Est.      S.E.     t val.         p
# ----------------- ---------- --------- ---------- ---------
# (Intercept)          1.21335   0.04513   26.88404   0.00000
# Mrate                0.03407   0.00275   12.38882   0.00000
# Logemp              -0.10124   0.01197   -8.45714   0.00000
# Logemp2              0.00514   0.00078    6.60398   0.00000
# Age                  0.00644   0.00082    7.85861   0.00000
# Age2                -0.00008   0.00002   -4.20262   0.00003
# Sole                 0.01406   0.00499    2.81644   0.00488
# -----------------------------------------------------------



############################################################
############################################################
####### Chapter 6 - Program 3 - Page 106 - Model 2   #######
############################################################
############################################################
############################################################

# https://m-clark.github.io/posts/2019-08-20-fractional-regression/

library(lme4)


model_2 = glm(
  Prate ~ Mrate +Logemp +Logemp2 +  Age +Age2 +Sole,
  data = k401,
  family = binomial)

summ(model_2, digits = 5)
rm("model_2") 

# MODEL INFO:
#   Observations: 4734
# Dependent Variable: Prate
# Type: Generalized linear model
# Family: binomial 
# Link function: logit 
# 
# MODEL FIT:
#   ??²(6) = 195.02826, p = 0.00000
# Pseudo-R² (Cragg-Uhler) = 0.06964
# Pseudo-R² (McFadden) = 0.05727
# AIC = 1937.53836, BIC = 1982.77604 
# 
# Standard errors: MLE
# -----------------------------------------------------------
#   Est.      S.E.     z val.         p
# ----------------- ---------- --------- ---------- ---------
# (Intercept)          5.42933   0.93042    5.83538   0.00000
# Mrate                0.54209   0.08983    6.03497   0.00000
# Logemp              -1.03841   0.24211   -4.28907   0.00002
# Logemp2              0.05401   0.01544    3.49759   0.00047
# Age                  0.06211   0.01763    3.52217   0.00043
# Age2                -0.00071   0.00041   -1.71372   0.08658
# Sole                 0.11897   0.10152    1.17184   0.24126
# -----------------------------------------------------------
#   Warning message:
#   In eval(family$initialize) : non-integer #successes in a binomial glm!







############################################################
############################################################
####### Chapter 6 - Program 4 - Page 107 - Model 3   #######
############################################################
############################################################
############################################################


model_3 = glm(
  Prate ~ Mrate +Logemp +Logemp2 + Age +Age2 +Sole,
  data = k401,
  family=quasibinomial(link=logit)
)
summary(model_3)
 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)
# (Intercept)  5.4293327  0.4668910  11.629  < 2e-16
# Mrate        0.5420939  0.0450752  12.026  < 2e-16
# Logemp      -1.0384143  0.1214914  -8.547  < 2e-16
# Logemp2      0.0540150  0.0077497   6.970 3.61e-12
# Age          0.0621111  0.0088491   7.019 2.55e-12
# Age2        -0.0007078  0.0002073  -3.415 0.000643
# Sole         0.1189706  0.0509460   2.335 0.019573
# 
# (Dispersion parameter for quasibinomial family taken to be 0.251812)
# 
# Null deviance: 1166.6  on 4733  degrees of freedom
# Residual deviance:  971.6  on 4727  degrees of freedom
# AIC: NA

# Number of Fisher Scoring iterations: 6


summ(model_3, digits = 5)

# Note: Pseudo-R2 for quasibinomial/quasipoisson families is
# calculated by refitting the fitted and null models as
# binomial/poisson.
# MODEL INFO:
#   Observations: 4734
# Dependent Variable: Prate
# Type: Generalized linear model
# Family: quasibinomial 
# Link function: logit 
# 
# MODEL FIT:
#   ??²(6) = 195.02826, p = 0.00000
# Pseudo-R² (Cragg-Uhler) = 0.06964
# Pseudo-R² (McFadden) = 0.05727
# AIC =     NA, BIC =     NA 
# 
# Standard errors: MLE
# -----------------------------------------------------------
#   Est.      S.E.     t val.         p
# ----------------- ---------- --------- ---------- ---------
# (Intercept)          5.42933   0.46689   11.62869   0.00000
# Mrate                0.54209   0.04508   12.02644   0.00000
# Logemp              -1.03841   0.12149   -8.54722   0.00000
# Logemp2              0.05401   0.00775    6.96996   0.00000
# Age                  0.06211   0.00885    7.01895   0.00000
# Age2                -0.00071   0.00021   -3.41508   0.00064
# Sole                 0.11897   0.05095    2.33523   0.01957
# -----------------------------------------------------------
#   
#   Estimated dispersion parameter = 0.25181 


rm("model_3") 


############################################################
############  OPTION 2 PACKAGE frm      ####################
############################################################


# lOOK WEB PAGE BELOW 

# https://m-clark.github.io/posts/2019-08-20-fractional-regression/

# In addition, we can see what the frm package, which is specifically 
# for fractional regression, would produce. Unless you really need this
# tool for the more complicated scenarios it has some functionality
# for (e.g. panel data), this isn't as user friendly. 
# it is equivalent to using the quasibinomial
# family with robust standard errors.


install.packages("frm", dependencies=TRUE)

library(frm)

x_mat = model.matrix( Prate ~ Mrate +Logemp +Logemp2 +  Age +Age2 +Sole, k401)
y = k401$Prate


model_frm = frm(
  y,
  x_mat,
  linkfrac = 'logit',
  intercept = FALSE ) # included in model matrix
          
rm("model_frm") 
rm("x_mat") 
rm("y") 
rm("x_mat") 
rm("k401") 


# *** Fractional logit regression model ***
#   
#                Estimate Std. Error t value    Pr(>|t|)    
# (Intercept)    5.429333   0.422047  12.864    0.000 ***
#   Mrate        0.542094   0.078656   6.892    0.000 ***
#   Logemp      -1.038414   0.110477  -9.399    0.000 ***
#   Logemp2      0.054015   0.007101   7.606    0.000 ***
#   Age          0.062111   0.007819   7.944    0.000 ***
#   Age2        -0.000708   0.000179  -3.945    0.000 ***
#   Sole         0.118971   0.050254   2.367    0.018 ** 
#   
#   Note: robust standard errors
# 
# Number of observations: 4734 
# R-squared: 0.169 





############################################################
############################################################
####### Chapter 6 - Program 5 - Page 110 - Model 4   #######
############################################################
############################################################


mortgage_lgd <- read.sas7bdat("D:/1-COMPUTADOR/2- MEU BOOKS/2-SURVIVAL BOOK 2- ADVANCED/3-AMAZON LIVE/ZZ-CODE ONLINE/6_CHAPTER_6/mortgage_lgd.sas7bdat")


ls(mortgage_lgd)

# [1] "Accounts"             "Basel_LGD"           
# [3] "CPI"                  "CPI_lag_1"           
# [5] "CPI_lag_2"            "CPI_lag_3"           
# [7] "CPI_lag_4"            "GDP"                 
# [9] "Houseprice"           "Interest_rate"       
# [11] "Interest_rate_lag_1"  "Interest_rate_lag_2" 
# [13] "Interest_rate_lag_3"  "Interest_rate_lag_4" 
# [15] "LGD"                  "Log_Houseprice"      
# [17] "Log_Lag_1_GDP"        "Log_Lag_1_Houseprice"
# [19] "Log_Lag_2_GDP"        "Log_Lag_2_Houseprice"
# [21] "Log_Lag_3_GDP"        "Log_Lag_3_Houseprice"
# [23] "Log_Lag_4_GDP"        "Log_Lag_4_Houseprice"
# [25] "LTV_Segment"          "PGDP"                
# [27] "Reference"            "SASDATE"             
# [29] "Unemployment"         "Unemployment_lag_1"  
# [31] "Unemployment_lag_2"   "Unemployment_lag_3"  
# [33] "Unemployment_lag_4"  




# proc glimmix data = Mortgage_lgd plots=pearsonpanel order = data;
# class ltv_segment   ;
# model lgd = LTV_segment 
# Basel_LGD 	 
# pgdp 
# cpi_lag_3  
# unemployment_lag_4 
# interest_rate_lag_3  
# log_lag_2_houseprice / dist = binomial link = logit solution ; 
# random _residual_;
# weight  accounts ; 


###############################################
##########    Step 1  -- Factor  ##############
###############################################

mortgage_lgd$LTV_Segment <- factor(mortgage_lgd$LTV_Segment)
contrasts(mortgage_lgd$LTV_Segment) 

### change the base - level Segment to 1
contrasts(mortgage_lgd$LTV_Segment) = contr.treatment(3, base = 2)
contrasts(mortgage_lgd$LTV_Segment) 

###############################################
##########    Step 2  -- Model 4 ##############
###############################################

# https://stackoverflow.com/questions/19893133/fractional-logit-model-in-r


model_4 = glm(
  LGD ~ LTV_Segment +Basel_LGD + PGDP+CPI_lag_3+Unemployment_lag_4+
    Interest_rate_lag_3+Log_Lag_2_Houseprice  ,
  data = mortgage_lgd,
  weight=  Accounts ,
  family =  quasibinomial(link=logit))

summary(model_4)
rm("model_4") 

################# OUTPUT 16 - PAGE 118 #############

# Coefficients:
#                        Estimate Std. Error t value Pr(>|t|)
# (Intercept)          -15.992744   1.790073  -8.934 6.37e-16
# LTV_Segment1          -0.721519   0.071236 -10.129  < 2e-16
# LTV_Segment3          -2.166585   0.111497 -19.432  < 2e-16
# Basel_LGD             11.200632   2.392466   4.682 5.77e-06
# PGDP                  -0.028840   0.012559  -2.296 0.022868
# CPI_lag_3             -0.016222   0.007067  -2.295 0.022928
# Unemployment_lag_4     0.208999   0.057791   3.616 0.000393
# Interest_rate_lag_3    0.099885   0.021103   4.733 4.61e-06
# Log_Lag_2_Houseprice   1.159701   0.165054   7.026 4.82e-11
# 
# (Dispersion parameter for quasibinomial family taken to be 0.7733275)
# 
# Null deviance: 2313.41  on 179  degrees of freedom
# Residual deviance:  127.57  on 171  degrees of freedom
# (39 observations deleted due to missingness)
# AIC: NA

############################################################
############################################################
###### Chapter 6 - Program 5 - Page 117 - Model 5    #######
############################################################
############################################################


# The model 5 is specific to SAS PROC GLIMMIX and it is not 
# replicated yet in R or Python.






############################################################
############################################################
####### Chapter 6 - Program 8 - Page 119 - Model 6   #######
############################################################
############################################################

mortgage_lgd <- subset(mortgage_lgd, LTV_Segment=="0<=LTV<=0.7")



model_6 = glm(
  LGD ~ Basel_LGD + PGDP+Unemployment_lag_4 +
  Interest_rate_lag_1 + Log_Houseprice  ,
  data   = mortgage_lgd,
  weight =  Accounts ,
  family =  quasibinomial(link=logit))

summary(model_6)
rm("model_6") 


################# OUTPUT 17 - PAGE 119 #############


# Coefficients:
#                       Estimate Std. Error t value Pr(>|t|)
# (Intercept)          -25.03987    3.13671  -7.983 1.05e-10
# Basel_LGD           1198.13600  347.19757   3.451  0.00109
# PGDP                  -0.04606    0.01916  -2.404  0.01970
# Unemployment_lag_4     0.20401    0.05944   3.432  0.00116
# Interest_rate_lag_1    0.23981    0.03498   6.855 7.09e-09
# Log_Houseprice         1.48940    0.24048   6.193 8.34e-08
# 
# (Dispersion parameter for quasibinomial family taken to be 0.3379276)
# 
# Null deviance: 57.424  on 59  degrees of freedom
# Residual deviance: 18.555  on 54  degrees of freedom
# (13 observations deleted due to missingness)
# AIC: NA
# 
# Number of Fisher Scoring iterations: 4

############################################################
############################################################
####### Chapter 6 - Program 9 - Page 120 - Model 7   #######
############################################################
############################################################


# The model 7 is specific to SAS PROC GLIMMIX and it is not 
# replicated yet in R or Python.







############################################################
############################################################
####### Chapter 6 - Program 10 - Page 121 - Model 8   ######
############################################################
############################################################


mortgage_lgd_model_8 <- read.sas7bdat("D:/1-COMPUTADOR/2- MEU BOOKS/2-SURVIVAL BOOK 2- ADVANCED/3-AMAZON LIVE/ZZ-CODE ONLINE/6_CHAPTER_6/mortgage_lgd_model_8.sas7bdat")

model_8 = glm(
  LGD ~  lgd_lag_1+ CPI_lag_4+Unemployment_lag_2 + Log_Houseprice,
  data   = mortgage_lgd_model_8,
  weight =  Accounts ,
  family =  quasibinomial(link=logit))

summary(model_8)
rm("model_8") 


################# OUTPUT 19 - PAGE 121 #############

# Coefficients:
#                     Estimate Std. Error  t value Pr(>|t|)
# (Intercept)        -14.254452   2.702194  -5.275 2.31e-06
# lgd_lag_1           41.276137   3.364921  12.267  < 2e-16
# CPI_lag_4           -0.028168   0.008514  -3.308  0.00166
# Unemployment_lag_2   0.148748   0.063299   2.350  0.02239
# Log_Houseprice       0.937210   0.242770   3.860  0.00030
# 
# (Dispersion parameter for quasibinomial family taken to be 0.2235188)
# 
# Null deviance: 57.424  on 59  degrees of freedom
# Residual deviance: 12.709  on 55  degrees of freedom


############################################################
############################################################
####### Chapter 6 - Program 11 - Page 122 - Model 9   #######
############################################################
############################################################


# The model 7 is specific to SAS PROC GLIMMIX and it is not 
# replicated yet in R or Python.





# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************

