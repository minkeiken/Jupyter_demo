###############################################
###############################################
#########         CHAPTER 7             #######
###############################################
###############################################


# install.packages("survival"    , dependencies=TRUE)
# install.packages("sas7bdat"    , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)
# install.packages("jtools"      , dependencies=TRUE)
# install.packages("epiDisplay"  , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)
# install.packages("crr"         , dependencies=TRUE)
# install.packages("nnet"        , dependencies=TRUE)

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
library(cmprsk)
library(survminer)
library(lubridate)
library(crrSC)
library(nnet)

###############################################
#####   Step 1  -- Read in the SAS data  ######
###############################################

btl <- read.sas7bdat("btl.sas7bdat")


ls(btl)

# [1] "Censor"              "CPI"                
# [3] "Date"                "End"                
# [5] "GDP"                 "HPI"                
# [7] "Id"                  "Interest_rate"      
# [9] "Interest_rate_lag_1" "Interest_rate_lag_2"
# [11] "Interest_rate_lag_3" "Interest_rate_lag_4"
# [13] "Log_GDP"             "Log_lag_1_GDP"      
# [15] "Log_lag_1_HPI"       "Log_lag_2_GDP"      
# [17] "Log_lag_2_HPI"       "Log_lag_3_GDP"      
# [19] "Log_lag_3_HPI"       "Log_lag_4_GDP"      
# [21] "Log_lag_4_HPI"       "P_CPI_1"            
# [23] "P_CPI_2"             "P_CPI_3"            
# [25] "P_CPI_4"             "PGDP"               
# [27] "Scorecard"           "Start"              
# [29] "Unemployment"        "Unemployment_lag_1" 
# [31] "Unemployment_lag_2"  "Unemployment_lag_3" 
# [33] "Unemployment_lag_4" 


############################################################
############################################################
############################################################
####### Chapter 7 - Program 2 - Page 137 - COX Model #######
############################################################
############################################################
############################################################

# https://www.rdocumentation.org/packages/survival/versions/3.2-13/topics/coxph

#######################################
#######       Censor = 1        #######
#######################################

COX_Model_1 <- 
  coxph(
    Surv(End, ifelse(Censor == 1, 1, 0)) ~ Scorecard + PGDP + 
                                           P_CPI_4 + Unemployment_lag_1, 
    id=Id, cluster = Id,
    data = btl)


#######################################
#######  Summary  Censor = 1      #####
#######################################

options(show.signif.stars = FALSE)
summary(COX_Model_1)


# n= 224228, number of events= 1591 
# 
# coef  exp(coef)   se(coef)  robust se       z
# Scorecard          -0.0074292  0.9925983  0.0004009  0.0004491 -16.541
# PGDP               -0.0777782  0.9251696  0.0097735  0.0098846  -7.869
# P_CPI_4            -0.0551569  0.9463366  0.0311315  0.0330199  -1.670
# Unemployment_lag_1  0.1004250  1.1056407  0.0260606  0.0260000   3.863
# Pr(>|z|)
# Scorecard           < 2e-16
# PGDP               3.59e-15
# P_CPI_4            0.094838
# Unemployment_lag_1 0.000112
# 
# exp(coef) exp(-coef) lower .95 upper .95
# Scorecard             0.9926     1.0075    0.9917    0.9935
# PGDP                  0.9252     1.0809    0.9074    0.9433
# P_CPI_4               0.9463     1.0567    0.8870    1.0096
# Unemployment_lag_1    1.1056     0.9045    1.0507    1.1634
# 
# Concordance= 0.635  (se = 0.008 )
# Likelihood ratio test= 474.7  on 4 df,   p=<2e-16
# Wald test            = 419.1  on 4 df,   p=<2e-16
# Score (logrank) test = 478.8  on 4 df,   p=<2e-16,   Robust = 327.5  p=<2e-16
# 
# (Note: the likelihood ratio and score tests assume independence of
  # observations within a cluster, the Wald and robust score tests do not).




### look the viewer
gtsummary::tbl_regression(COX_Model_1, exp = FALSE)



#######################################
#######       Censor = 2        #######
#######################################

COX_Model_2 <- 
  coxph(
    Surv(End, ifelse(Censor == 2, 1, 0)) ~ Scorecard + PGDP+P_CPI_4+
                                           Unemployment_lag_1, 
    id=Id, cluster = Id,
    data = btl  )



#######################################
#######  Summary  Censor = 2      #####
#######################################
summary(COX_Model_2)



# n= 224228, number of events= 89 
# 
#                         coef  exp(coef)  se(coef)    z   Pr(>|z|)
# Scorecard           0.002613  1.002616  0.001547  1.689   0.0913
# PGDP                0.105443  1.111203  0.130648  0.807   0.4196
# P_CPI_4            -2.351440  0.095232  0.339856 -6.919 4.55e-12
# Unemployment_lag_1 -2.683121  0.068349  0.503021 -5.334 9.61e-08
# 
# exp(coef) exp(-coef) lower .95 upper .95
# Scorecard            1.00262     0.9974   0.99958    1.0057
# PGDP                 1.11120     0.8999   0.86017    1.4355
# P_CPI_4              0.09523    10.5007   0.04892    0.1854
# Unemployment_lag_1   0.06835    14.6307   0.02550    0.1832
# 
# Concordance= 0.811  (se = 0.019 )
# Likelihood ratio test= 170.8  on 4 df,   p=<2e-16
# Wald test            = 60.97  on 4 df,   p=2e-12
# Score (logrank) test = 98.7  on 4 df,    p=<2e-16


### look the viewer
gtsummary::tbl_regression(COX_Model_2, exp = FALSE)





############################################################
############################################################
############################################################
###### Chapter 7 - Program 2 - Page 141 - FINE Model #######
############################################################
############################################################
############################################################


#######################################
#######  Summary  Censor = 1      #####
#######################################

FINE_Model_1 <- crr(btl$End, btl$Censor, btl[,c("Scorecard", "PGDP", "P_CPI_4", "Unemployment_lag_1" )],
          failcode=1, cencode=0,
          gtol=1e-06, maxiter=10,  variance=TRUE)

summary(FINE_Model_1)

# coef exp(coef) se(coef)      z p-value
# Scorecard          -0.00742     0.993 0.000439 -16.91 0.0e+00
# PGDP               -0.07771     0.925 0.009885  -7.86 3.8e-15
# P_CPI_4            -0.05496     0.947 0.033008  -1.67 9.6e-02
# Unemployment_lag_1  0.10048     1.106 0.026012   3.86 1.1e-04
# 
# exp(coef) exp(-coef)  2.5% 97.5%
#   Scorecard              0.993      1.007 0.992 0.993
# PGDP                   0.925      1.081 0.907 0.943
# P_CPI_4                0.947      1.056 0.887 1.010
# Unemployment_lag_1     1.106      0.904 1.051 1.164
# 
# Num. cases = 224228
# Pseudo Log-likelihood = -18246 
# Pseudo likelihood ratio test = 474  on 4 df,



### look the viewer
gtsummary::tbl_regression(FINE_Model_1, exp = FALSE)



#######################################
#######  Summary  Censor = 2      #####
#######################################

###  CRR does not accept the ID and cluster options.

FINE_Model_2 <- crr(btl$End, btl$Censor, 
            btl[,c("Scorecard", "PGDP","P_CPI_4","Unemployment_lag_1")],
failcode=2, cencode=0, gtol=1e-06, maxiter=100,  variance=TRUE)

summary(FINE_Model_2)

#                         coef exp(coef) se(coef)    z  p-value
# Scorecard           0.00374     1.004  0.00143  2.617 8.9e-03
# PGDP                0.07467     1.078  0.07479  0.998 3.2e-01
# P_CPI_4            -1.29316     0.274  0.29067 -4.449 8.6e-06
# Unemployment_lag_1 -0.58244     0.559  0.23311 -2.499 1.2e-02
# 
#                    exp(coef) exp(-coef)  2.5% 97.5%
# Scorecard              1.004      0.996 1.001 1.007
# PGDP                   1.078      0.928 0.931 1.248
# P_CPI_4                0.274      3.644 0.155 0.485
# Unemployment_lag_1     0.559      1.790 0.354 0.882
# 
# Num. cases = 224228
# Pseudo Log-likelihood = -808 
# Pseudo likelihood ratio test = 117  on 4 df,

### look the viewer
gtsummary::tbl_regression(FINE_Model_2, exp = FALSE)





############################################################
############################################################
############################################################
###### Chapter 7 - Program 4 - Page 144 - GLOGIT Model  ####
############################################################
############################################################
############################################################


# https://stats.oarc.ucla.edu/r/dae/multinomial-logistic-regression/
# https://bookdown.org/chua/ber642_advanced_regression/multinomial-logistic-regression.html



library(nnet)

#######################################
#####  Model using nnet package     ###
#######################################

model = multinom(Censor ~ Scorecard , data = btl)

summary(model)

# Coefficients:
#   (Intercept)    Scorecard
# 1   -1.141037 -0.005521615
# 2  -12.517297  0.006552560
# 
# Std. Errors:
#   (Intercept)    Scorecard
# 1 2.738509e-01 0.0004028418
# 2 9.159449e-05 0.0001439001
# 
# Residual Deviance: 20268.2 
# AIC: 20276.2 


############################################################
############################################################
############################################################
###### Chapter 7 - Program 5 - Page 146 - GLOGIT Model  ####
############################################################
############################################################
############################################################


model = multinom(Censor ~ Scorecard + PGDP + P_CPI_4 + Unemployment_lag_1 , data = btl)

summary(model)

# Coefficients:


#   (Intercept)    Scorecard        PGDP     P_CPI_4 Unemployment_lag_1
# 1   -2.217402 -0.005791621 -0.08022628  0.08770053          0.2043200
# 2  -13.804424  0.006006554  0.10294140 -0.26441162          0.3587061
# 
# Std. Errors:
#   (Intercept)    Scorecard        PGDP    P_CPI_4 Unemployment_lag_1
# 1 0.297246283 0.0003926426 0.009789217 0.02967993         0.02578564
# 2 0.007847701 0.0008717773 0.057095214 0.16024951         0.12324182
# 
# Residual Deviance: 19965.73 
# AIC: 19985.73 


# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************








