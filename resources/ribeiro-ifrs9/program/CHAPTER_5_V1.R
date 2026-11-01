###############################################
###############################################
#########         CHAPTER 5             #######
###############################################
###############################################

# install.packages("survival"    , dependencies=TRUE)
# install.packages("sas7bdat"    , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)
# install.packages("jtools"      , dependencies=TRUE)
# install.packages("epiDisplay"      , dependencies=TRUE)

# Activate the 'sas7bdat' and 'jtools' library
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
######    import data set               #######
###############################################

# Read in the SAS data
recurrent <- read.sas7bdat("recurrent.sas7bdat")

###############################################
##########    Step 1  -- Factor  ##############
###############################################
recurrent$Vintage_segment <- factor(recurrent$Vintage_segment)
contrasts(recurrent$Vintage_segment) 

#              1996-2003 2004-2006
# >=2007            0         0
# 1996-2003         1         0
# 2004-2006         0         1


### change the base - level Segment to 1
contrasts(recurrent$Vintage_segment) = contr.treatment(3, base = 1)
contrasts(recurrent$Vintage_segment) 


#           2 3
# >=2007    0 0
# 1996-2003 1 0
# 2004-2006 0 1

############################################################
############################################################
####### Chapter 5 - Program 1 - Page 89 - Model 1    #######
############################################################
############################################################
############################################################

options(show.signif.stars = FALSE)

# Model Fitting
model <- glm(Default~ Scorecard  + Time_to_Default + Vintage_segment + 
               PGDP + Unemployment_lag_4 + Log_Houseprice, 
             family=binomial(link = "logit"), data = recurrent)

options(digits=12)
summary(model )

print(summary(model))

# Coefficients:
#                           Estimate      Std. Error   z value   Pr(>|z|)
# (Intercept)        -26.74125008531   5.64470992196  -4.73740 2.1648e-06
# Scorecard           -0.00370533704   0.00033754147 -10.97743 < 2.22e-16
# Time_to_Default     -0.02011973181   0.00160419622 -12.54194 < 2.22e-16
# Vintage_segment2    -0.77222172155   0.07296609438 -10.58330 < 2.22e-16
# Vintage_segment3    -0.19627831032   0.04226979178  -4.64347 3.4261e-06
# PGDP                -0.11327635308   0.02586528333  -4.37947 1.1897e-05
# Unemployment_lag_4   0.19384927947   0.03019779878   6.41932 1.3689e-10
# Log_Houseprice       2.09813664319   0.44714698903   4.69228 2.7018e-06

# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 24058.47706  on 64282  degrees of freedom
# Residual deviance: 23384.91586  on 64275  degrees of freedom
# AIC: 23400.91586



############################################################
############################################################
####### Chapter 5 - Program 2 - Page 93 - Model 2    #######
############################################################
############################################################



# https://www.statology.org/factor-to-numeric-in-r/
recurrent$Default_Intensity <- as.numeric(as.character(recurrent$Default_Intensity))

options(show.signif.stars = FALSE)

# Model Fitting

model2  <- glm(Default ~  Scorecard     + Default_Intensity       
                 + Log_lag_1_GDP        + Unemployment_lag_4 
                 + Interest_rate_lag_1  + Log_lag_3_Houseprice, 
                 family=binomial(link = "logit"), data = recurrent)

options(digits=4)
summary(model2 )

print(summary(model2))

# Coefficients:
#                              Estimate       Std. Error   z value   Pr(>|z|)
# (Intercept)          65.5550427007689 14.7588729968140   4.44174 8.9235e-06
# Scorecard            -0.0038330551045  0.0003361246155 -11.40367 < 2.22e-16
# Default_Intensity     0.0340525524015  0.0124379301669   2.73780  0.0061852
# Log_lag_1_GDP        -4.0143347129036  0.8567912906389  -4.68531 2.7953e-06
# Unemployment_lag_4    0.0911246273895  0.0392408807730   2.32219  0.0202229
# Interest_rate_lag_1   0.1289904890571  0.0213486337083   6.04210 1.5213e-09
# Log_lag_3_Houseprice -1.2067501464242  0.5285719622397  -2.28304  0.0224281
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 24058.477055  on 64282  degrees of freedom
# Residual deviance: 23730.391948  on 64276  degrees of freedom


############################################################
############################################################
############################################################
####### Chapter 5 - Program 3 - Page 96 - Model 3    #######
############################################################
############################################################
############################################################

# https://www.rdocumentation.org/packages/survival/versions/3.2-13/topics/coxph

options(digits=6)
coxph(Surv(TStart , TStop , Default) ~ Scorecard + Vintage_segment + PGDP  +
        Unemployment_lag_4 + Log_Houseprice,  data= recurrent, ties="breslow")


# Call:
#   coxph(formula = Surv(TStart, TStop, Default) ~ Scorecard + Vintage_segment + 
#           PGDP + Unemployment_lag_4 + Log_Houseprice, data = recurrent, 
#         ties = "breslow")
# 
#                         coef  exp(coef)  se(coef)    z      p
# Scorecard          -0.003528  0.996479  0.000327 -10.79 < 2e-16
# Vintage_segment2   -0.728149  0.482802  0.071491 -10.19 < 2e-16
# Vintage_segment3   -0.180924  0.834499  0.040936  -4.42 9.9e-06
# PGDP               -0.107480  0.898094  0.025127  -4.28 1.9e-05
# Unemployment_lag_4  0.185655  1.204007  0.029469   6.30 3.0e-10
# Log_Houseprice      2.039185  7.684343  0.435763   4.68 2.9e-06
# 
# Likelihood ratio test=246  on 6 df, p=<2e-16
# n= 64283, number of events= 2969 


############################################################
############################################################
############################################################
####### Chapter 5 - Program 4 - Page 97 - Model 4    #######
############################################################
############################################################
############################################################
options(digits=7)
 coxph(formula = Surv(TStart, TStop, Default) ~ Scorecard + Vintage_segment + 
         PGDP + Unemployment_lag_4 + Log_Houseprice, data = recurrent, 
       ties = "breslow", id = ID)

 # Call:
 #   coxph(formula = Surv(TStart, TStop, Default) ~ Scorecard + Vintage_segment + 
 #           PGDP + Unemployment_lag_4 + Log_Houseprice, data = recurrent, 
 #         ties = "breslow", id = ID)
 # 
 #                          coef  exp(coef)   se(coef)  robust se       z        p
 # Scorecard          -0.0035276  0.9964786  0.0003269  0.0003266 -10.802  < 2e-16
 # Vintage_segment2   -0.7281493  0.4828017  0.0714914  0.0663545 -10.974  < 2e-16
 # Vintage_segment3   -0.1809237  0.8344990  0.0409360  0.0403911  -4.479 7.49e-06
 # PGDP               -0.1074803  0.8980942  0.0251273  0.0243116  -4.421 9.83e-06
 # Unemployment_lag_4  0.1856554  1.2040073  0.0294694  0.0280441   6.620 3.59e-11
 # Log_Houseprice      2.0391849  7.6843432  0.4357626  0.4208823   4.845 1.27e-06
 # 
 # Likelihood ratio test=246.2  on 6 df, p=< 2.2e-16
 # n= 64283, number of events= 2969 



 ############################################################
 ############################################################
 ############################################################
 ####### Chapter 5 - Program 5 - Page 99 - Model 5    #######
 ############################################################
 ############################################################
 ############################################################
 
 recurrent_2 <- read.sas7bdat("recurrent_2.sas7bdat")
 recurrent_2$Vintage_segment <- factor(recurrent_2$Vintage_segment)
 contrasts(recurrent_2$Vintage_segment)
 
 #              1996-2003 2004-2006
 # >=2007            0         0
 # 1996-2003         1         0
 # 2004-2006         0         1
 
 ### change the base - level Segment to 1
 contrasts(recurrent_2$Vintage_segment) = contr.treatment(3, base = 1)
 contrasts(recurrent_2$Vintage_segment) 
 
 #           2 3
 # >=2007    0 0
 # 1996-2003 1 0
 # 2004-2006 0 1
 
 
 levels(strata(recurrent_2$Default_Intensity))
 # [1] "recurrent_2$Default_Intensity=0"
 # [2] "recurrent_2$Default_Intensity=1"
 # [3] "recurrent_2$Default_Intensity=2"
 # [4] "recurrent_2$Default_Intensity=3"
 # [5] "recurrent_2$Default_Intensity=4"
 
 levels(strata(recurrent_2$Default_Intensity,shortlabel=TRUE))
 
 # "0" "1" "2" "3" "4"
 
 
 library('plyr')
 count(recurrent_2, 'Default_Intensity') 
 
 # Default_Intensity  freq
 # 1                 0 23152
 # 2                 1 15487
 # 3                 2 11845
 # 4                 3  7237
 # 5                 4  6562
 
 # how to make frequency table in r (nicer version)

 library(epiDisplay)
 tab1(recurrent_2$Default_Intensity, sort.group = "decreasing", cum.percent = TRUE)
 
 # recurrent_2$Default_Intensity : 
 #   Frequency Percent Cum. percent
 # 0           23152    36.0         36.0
 # 1           15487    24.1         60.1
 # 2           11845    18.4         78.5
 # 3            7237    11.3         89.8
 # 4            6562    10.2        100.0
 # Total       64283   100.0        100.0
 
 
 # The tab1() function also prints a bar chart to 
 # ow relative frequencies by default. Look the Plot
 
 ###############################################
 ##########           Model 5     ##############
 ###############################################

options(digits=7)
coxph(formula = Surv(TStart, TStop, Default) ~ Scorecard + Vintage_segment + 
         PGDP + Unemployment_lag_4 + Log_Houseprice + strata(Default_Intensity), 
data = recurrent_2,  ties = "breslow")

 #                          coef  exp(coef)   se(coef)       z        p
 # Scorecard          -0.0034969  0.9965092  0.0003322 -10.525  < 2e-16
 # Vintage_segment2   -0.7495898  0.4725604  0.0718796 -10.428  < 2e-16
 # Vintage_segment3   -0.1622259  0.8502491  0.0413703  -3.921 8.81e-05
 # PGDP               -0.0855137  0.9180405  0.0256996  -3.327 0.000876
 # Unemployment_lag_4  0.1621644  1.1760536  0.0311396   5.208 1.91e-07
 # Log_Houseprice      1.8564187  6.4007725  0.4649107   3.993 6.52e-05
 # 
 # Likelihood ratio test=235.5  on 6 df, p=< 2.2e-16
 # n= 64283, number of events= 2969 



# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************









