###############################################
###############################################
#########         CHAPTER 3             #######
###############################################
###############################################

# install.packages("survival"    , dependencies=TRUE)
# install.packages("sas7bdat"    , dependencies=TRUE)
# install.packages("learnr"      , dependencies=TRUE)
# install.packages("jtools"      , dependencies=TRUE)
# install.packages("epiDisplay"  , dependencies=TRUE)
# install.packages("settings"    , dependencies=TRUE)



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

##### DATA SET IS CONFIDENTIAL 


# Read in the SAS data
mortgage_model_1 <- read.sas7bdat("mortgage_model_1.sas7bdat")


ls(mortgage_model_1)

# [1] "Balance"             "Censor"             
# [3] "End"                 "GDP"                
# [5] "Houseprice"          "ID"                 
# [7] "Inflation"           "Lag_1_GDP"          
# [9] "Lag_1_Unemployment"  "Lag_10_GDP"         
# [11] "Lag_10_Unemployment" "Lag_11_GDP"         
# [13] "Lag_11_Unemployment" "Lag_12_GDP"         
# [15] "Lag_12_Unemployment" "Lag_2_GDP"          
# [17] "Lag_2_Unemployment"  "Lag_3_GDP"          
# [19] "Lag_3_Houseprice"    "Lag_3_Inflation"    
# [21] "Lag_3_Unemployment"  "Lag_4_GDP"          
# [23] "Lag_4_Unemployment"  "Lag_5_GDP"          
# [25] "Lag_5_Unemployment"  "Lag_6_GDP"          
# [27] "Lag_6_Houseprice"    "Lag_6_Inflation"    
# [29] "Lag_6_Unemployment"  "Lag_7_GDP"          
# [31] "Lag_7_Unemployment"  "Lag_8_GDP"          
# [33] "Lag_8_Unemployment"  "Lag_9_GDP"          
# [35] "Lag_9_Houseprice"    "Lag_9_Inflation"    
# [37] "Lag_9_Unemployment"  "LTV"                
# [39] "Payment"             "PGDP"               
# [41] "Sasdate"             "Scorecard"          
# [43] "Start"               "Unemployment"       
# [45] "Vintage"             "WOE_1"              
# [47] "WOE_2"               "WOE_3"              
# [49] "WOE_4"               "X_t_"   



###############################################
##########    Step 1  -- Factor  ##############
###############################################
mortgage_model_1$Vintage <- factor(mortgage_model_1$Vintage)
contrasts(mortgage_model_1$Vintage) 

#              1996-2003 2004-2006
# >=2007            0         0
# 1996-2003         1         0
# 2004-2006         0         1





############################################################
############################################################
####### Chapter 3 - Program 1 - Page 36 - Model 1    #######
############################################################
############################################################

options(show.signif.stars = FALSE)

# Model Fitting
model <- glm(Censor ~  X_t_ + Scorecard  + Balance + Payment + 
            LTV + Vintage + Lag_12_Unemployment +PGDP +
             Inflation + Lag_3_Houseprice, 
             family=binomial(link = "logit"), data = mortgage_model_1)


options(scipen = 999)
summary(model )



#                          Estimate    Std. Error  z value             Pr(>|z|)
# (Intercept)         21.5697478087  0.9223585171   23.385 < 0.0000000000000002
# _t_                -0.0024896284  0.0012477480   -1.995             0.046010
# Scorecard           -0.0477040053  0.0003073034 -155.234 < 0.0000000000000002
# Balance              0.0000042647  0.0000002127   20.052 < 0.0000000000000002
# Payment             -0.0007803940  0.0000506834  -15.397 < 0.0000000000000002
# LTV                 -0.0158815577  0.0005789969  -27.429 < 0.0000000000000002
# Vintage1970-1989    -0.6685012695  0.1104013638   -6.055     0.00000000140252
# Vintage1990-1999    -0.1223405620  0.0906883568   -1.349             0.177330
# Vintage2000-2008    -0.3879185077  0.0656780887   -5.906     0.00000000349747
# Lag_12_Unemployment  0.1391976333  0.0501595964    2.775             0.005519
# PGDP                -0.0639239189  0.0287503869   -2.223             0.026188
# Inflation           -0.0602599426  0.0181427313   -3.321             0.000896
# Lag_3_Houseprice     0.0000279519  0.0000039784    7.026     0.00000000000213
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 116534  on 2072911  degrees of freedom
# Residual deviance:  57741  on 2072899  degrees of freedom
# AIC: 57767




############################################################
############################################################
#######        Chapter 3 - Program 8 - Page 53       #######
############################################################
############################################################
############################################################



###############################################
######    import data set               #######
###############################################


# Read in the SAS data
mortgage_model_2 <- read.sas7bdat("mortgage_model_2.sas7bdat")


ls(mortgage_model_2)
# 
# 1] "Balance"             "Censor"              "End"                 "GDP"                
# [5] "Houseprice"          "ID"                  "Inflation"           "Lag_1_GDP"          
# [9] "Lag_1_Unemployment"  "Lag_10_GDP"          "Lag_10_Unemployment" "Lag_11_GDP"         
# [13] "Lag_11_Unemployment" "Lag_12_GDP"          "Lag_12_Unemployment" "Lag_2_GDP"          
# [17] "Lag_2_Unemployment"  "Lag_3_GDP"           "Lag_3_Houseprice"    "Lag_3_Inflation"    
# [21] "Lag_3_Unemployment"  "Lag_4_GDP"           "Lag_4_Unemployment"  "Lag_5_GDP"          
# [25] "Lag_5_Unemployment"  "Lag_6_GDP"           "Lag_6_Houseprice"    "Lag_6_Inflation"    
# [29] "Lag_6_Unemployment"  "Lag_7_GDP"           "Lag_7_Unemployment"  "Lag_8_GDP"          
# [33] "Lag_8_Unemployment"  "Lag_9_GDP"           "Lag_9_Houseprice"    "Lag_9_Inflation"    
# [37] "Lag_9_Unemployment"  "LTV"                 "LTV_Segment"         "Payment"            
# [41] "PGDP"                "Sasdate"             "Scorecard"           "Start"              
# [45] "Unemployment"        "Vintage"             "WOE_1"               "WOE_2"              
# [49] "WOE_3"               "WOE_4"               "X_csb1"              "X_csb10"            
# [53] "X_csb2"              "X_csb3"              "X_csb4"              "X_csb5"             
# [57] "X_csb6"              "X_csb7"              "X_csb8"              "X_csb9"             
# [61] "X_t_"
# 

###############################################
##########    Step 1  -- Factor  ##############
###############################################

mortgage_model_2$LTV_Segment <- factor(mortgage_model_2$LTV_Segment)
contrasts(mortgage_model_2$LTV_Segment) 



### change the base - level LTV_Segment to 2
contrasts(mortgage_model_2$LTV_Segment) = contr.treatment(2, base = 2)
contrasts(mortgage_model_2$LTV_Segment) 


###############################################
##########    Step 2  -- Model   ##############
###############################################

# Model Fitting
model2 <- glm(Censor ~  X_t_ + Vintage+LTV_Segment+ Balance + WOE_1+ WOE_2 +WOE_3
                     + X_csb1+ X_csb3 + X_csb4 + X_csb5 
                     +  X_csb7 + X_csb8 + X_csb9 +
                     Lag_12_Unemployment + PGDP + Lag_9_Inflation + Lag_3_Houseprice,
                     family=binomial(link = "logit"), data = mortgage_model_2)

options(scipen = 999)
summary(model2)


# Coefficients:
#                           Estimate     Std. Error z value             Pr(>|z|)
# (Intercept)         -20.2421042191   1.3349034547 -15.164 < 0.0000000000000002
# X_t_                 -0.1068704611   0.0072079140 -14.827 < 0.0000000000000002
# Vintage1970-1989      3.6155514020   0.1000860759  36.124 < 0.0000000000000002
# Vintage1990-1999      1.7955375845   0.0838145509  21.423 < 0.0000000000000002
# Vintage2000-2008      2.1236205481   0.0638950608  33.236 < 0.0000000000000002
# LTV_Segment1         -1.2898999423   0.0273911499 -47.092 < 0.0000000000000002
# Balance              -0.0000008333   0.0000001462  -5.700 0.000000011958011080
# WOE_1                 0.1587009503   0.0357963344   4.433 0.000009274072921726
# WOE_2                -0.5133664399   0.0394019930 -13.029 < 0.0000000000000002
# WOE_3                 0.5400374982   0.0099685905  54.174 < 0.0000000000000002
# X_csb1               -0.0173286780   0.0014538408 -11.919 < 0.0000000000000002
# X_csb3                0.0084603830   0.0007611801  11.115 < 0.0000000000000002
# X_csb4               -0.0108442157   0.0011334277  -9.568 < 0.0000000000000002
# X_csb5                0.0068957328   0.0008176719   8.433 < 0.0000000000000002
# X_csb7               -0.0046734900   0.0006088431  -7.676 0.000000000000016411
# X_csb8                0.0043507973   0.0005413573   8.037 0.000000000000000922
# X_csb9               -0.0014172758   0.0001653027  -8.574 < 0.0000000000000002
# Lag_12_Unemployment   0.3562676388   0.0950188751   3.749             0.000177
# PGDP                 -0.2142937428   0.0501922351  -4.269 0.000019594673699904
# Lag_9_Inflation      -0.1362695260   0.0262837905  -5.185 0.000000216541475631
# Lag_3_Houseprice      0.0000728754   0.0000052239  13.950 < 0.0000000000000002
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 116534  on 2072911  degrees of freedom
# Residual deviance: 105831  on 2072891  degrees of freedom
# AIC: 105873

# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************









