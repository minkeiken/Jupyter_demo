###############################################
###############################################
#########         CHAPTER 3             #######
###############################################
###############################################

###################################  
#### Step 1 - Import the library
###################################  


import pandas  as pd

pd.set_option('display.max_columns', 500)



###############################################
######    import data set               #######
###############################################

##### DATA SET IS CONFIDENTIAL 

mortgage_model_1 = pd.read_sas('mortgage_model_1.sas7bdat', encoding='windows-1252')



print (list(mortgage_model_1.columns))

# =============================================================================
# ['ID', '_t_', 'Start', 'End', 'Censor', 'Vintage', 'Scorecard', 'Balance',
#  'Payment',  'Sasdate', 'WOE_1', 'WOE_2', 'WOE_3', 'WOE_4', 'Unemployment', 
#  'Lag_1_Unemployment', 'Lag_2_Unemployment', 'Lag_3_Unemployment', 'Lag_4_Unemployment',
#  'Lag_5_Unemployment', 'Lag_6_Unemployment', 'Lag_7_Unemployment', 'Lag_8_Unemployment', 
#  'Lag_9_Unemployment', 'Lag_10_Unemployment', 'Lag_11_Unemployment', 'Lag_12_Unemployment',
#  'Inflation', 'Lag_3_Inflation', 'Lag_6_Inflation', 'Lag_9_Inflation', 'Houseprice',
#  'Lag_3_Houseprice', 'Lag_6_Houseprice', 'Lag_9_Houseprice', 'GDP', 'Lag_1_GDP',
#  'Lag_2_GDP', 'Lag_3_GDP', 'Lag_4_GDP', 'Lag_5_GDP', 'Lag_6_GDP', 'Lag_7_GDP', 
#  'Lag_8_GDP', 'Lag_9_GDP', 'Lag_10_GDP', 'Lag_11_GDP', 'Lag_12_GDP', 'PGDP']
# 
# =============================================================================

## array(['Sasdate', 'Unemployment'], dtype=object)



print( mortgage_model_1.head(12)[["ID" ,  "_t_" , "Start", "End" ,"Censor" ,"Vintage" , "Scorecard" ,]])

# =============================================================================
#      ID   _t_      Start End  Censor    Vintage  Scorecard
# 0   1.0   0.0 2010-01-01 NaT     0.0  2000-2008      775.0
# 1   1.0   1.0 2010-02-01 NaT     0.0  2000-2008      748.0
# 2   1.0   2.0 2010-03-01 NaT     0.0  2000-2008      757.0
# 3   1.0   3.0 2010-04-01 NaT     0.0  2000-2008      794.0
# 4   1.0   4.0 2010-05-01 NaT     0.0  2000-2008      779.0
# 5   1.0   5.0 2010-06-01 NaT     0.0  2000-2008      758.0
# 6   1.0   6.0 2010-07-01 NaT     0.0  2000-2008      774.0
# 7   1.0   7.0 2010-08-01 NaT     0.0  2000-2008      751.0
# 8   1.0   8.0 2010-09-01 NaT     0.0  2000-2008      790.0
# 9   1.0   9.0 2010-10-01 NaT     0.0  2000-2008      779.0
# 10  1.0  10.0 2010-11-01 NaT     0.0  2000-2008      795.0
# 11  1.0  11.0 2010-12-01 NaT     0.0  2000-2008      772.0
# =============================================================================


# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 3 - Program 1 - Page 33       *********
# **********************************************************
# **********************************************************
# **********************************************************


def frequency_table(x):
   ###Compute frequency table for a pandas series 
    frequency = x.value_counts(normalize=False)
    frequency.index.name = x.name
    frequency.name = "Frequency"
    percent = x.value_counts(normalize=True)
    percent.name = "Percent"
    frequency_table = pd.concat([frequency, percent], axis="columns")
    return frequency_table


results=frequency_table(mortgage_model_1["End"])

results.sort_index(inplace=True)
results

# ===================    Output 1     =========================================
#            Frequency   Percent
# 2010-01-01        315  0.034764
# 2010-02-01        447  0.049332
# 2010-03-01        326  0.035978
# 2010-04-01        373  0.041165
# 2010-05-01        333  0.036751
# 
# 2014-08-01         85  0.009381
# 2014-09-01         46  0.005077
# 2014-10-01        113  0.012471
# 2014-11-01         60  0.006622
# 2014-12-01         63  0.006953
# =============================================================================



# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 3 - Program 2 - Page 36       *********
# **********************************************************
# **********************************************************
# **********************************************************


# ========================== SAS PROGRAM ======================================
# ods graphics on;
# proc logistic data= mortgage_model_1 plots (maxpoints=10000)=(roc oddsratio ) ;
# class vintage / param=glm ;
# model censor (event="1") = _t_ 
# scorecard balance payment ltv  vintage 
# lag_12_unemployment  pgdp inflation lag_3_houseprice / link=logit ;
# units lag_12_unemployment = 1 2 
# 	  pgdp                = 1 2
#       scorecard           = 1 10    50 
#       balance             = 1 10000 20000
#       lag_3_houseprice    = 1 10000 20000; 
# nloptions tech=quanew maxit=1000;
# run;
# =============================================================================


results=frequency_table(mortgage_model_1["Vintage"])
results

# =============================================================================
#            Frequency   Percent
# 2000-2008    1433179  0.691384
# >= 2009       417606  0.201459
# 1990-1999     209270  0.100955
# 1970-1989      12857  0.006202
# =============================================================================



import statsmodels.formula.api as smf

model = smf.logit(formula="Censor ~  _t_ +  Scorecard  + Balance  + Payment + LTV +\
                  C(Vintage, Treatment(reference='>= 2009') )+ Lag_12_Unemployment+\
                  PGDP + Inflation + Lag_3_Houseprice", data=mortgage_model_1)

results = model.fit()
print(results.summary())

# =============================================================================
#                            Logit Regression Results                           
# ==============================================================================
# Dep. Variable:                 Censor   No. Observations:              2072912
# Model:                          Logit   Df Residuals:                  2072899
# Method:                           MLE   Df Model:                           12
# Date:                Fri, 04 Feb 2022   Pseudo R-squ.:                  0.5045
# Time:                        14:18:46   Log-Likelihood:                -28870.
# converged:                       True   LL-Null:                       -58267.
# Covariance Type:            nonrobust   LLR p-value:                     0.000
# ============================================================================================================================
#                                                                coef    std err          z      P>|z|      [0.025      0.975]
# ----------------------------------------------------------------------------------------------------------------------------
# Intercept                                                   21.5697      0.922     23.385      0.000      19.762      23.378
# C(Vintage, Treatment(reference=b'>= 2009'))[T.1970-1989]    -0.6685      0.110     -6.055      0.000      -0.885      -0.452
# C(Vintage, Treatment(reference=b'>= 2009'))[T.1990-1999]    -0.1223      0.091     -1.349      0.177      -0.300       0.055
# C(Vintage, Treatment(reference=b'>= 2009'))[T.2000-2008]    -0.3879      0.066     -5.906      0.000      -0.517      -0.259
# _t_                                                         -0.0025      0.001     -1.995      0.046      -0.005   -4.41e-05
# Scorecard                                                   -0.0477      0.000   -155.234      0.000      -0.048      -0.047
# Balance                                                   4.265e-06   2.13e-07     20.052      0.000    3.85e-06    4.68e-06
# Payment                                                     -0.0008   5.07e-05    -15.397      0.000      -0.001      -0.001
# LTV                                                         -0.0159      0.001    -27.429      0.000      -0.017      -0.015
# Lag_12_Unemployment                                          0.1392      0.050      2.775      0.006       0.041       0.238
# PGDP                                                        -0.0639      0.029     -2.223      0.026      -0.120      -0.008
# Inflation                                                   -0.0603      0.018     -3.321      0.001      -0.096      -0.025
# Lag_3_Houseprice                                          2.795e-05   3.98e-06      7.026      0.000    2.02e-05    3.57e-05
# ============================================================================================================================
# =============================================================================

###### or 

print(results.summary2())

# =============================================================================
#                                              Results: Logit
# =========================================================================================================
# Model:                            Logit                         Pseudo R-squared:              0.505     
# Dependent Variable:               Censor                        AIC:                           57766.6320
# Date:                             2022-02-05 08:37              BIC:                           57929.7100
# No. Observations:                 2072912                       Log-Likelihood:                -28870.   
# Df Model:                         12                            LL-Null:                       -58267.   
# Df Residuals:                     2072899                       LLR p-value:                   0.0000    
# Converged:                        1.0000                        Scale:                         1.0000    
# No. Iterations:                   12.0000                                                                
# ---------------------------------------------------------------------------------------------------------
#                                                          Coef.  Std.Err.     z     P>|z|   [0.025  0.975]
# ---------------------------------------------------------------------------------------------------------
# Intercept                                               21.5697   0.9224   23.3854 0.0000 19.7620 23.3775
# C(Vintage, Treatment(reference='>= 2009'))[T.1970-1989] -0.6685   0.1104   -6.0552 0.0000 -0.8849 -0.4521
# C(Vintage, Treatment(reference='>= 2009'))[T.1990-1999] -0.1223   0.0907   -1.3490 0.1773 -0.3001  0.0554
# C(Vintage, Treatment(reference='>= 2009'))[T.2000-2008] -0.3879   0.0657   -5.9064 0.0000 -0.5166 -0.2592
# _t_                                                     -0.0025   0.0012   -1.9953 0.0460 -0.0049 -0.0000
# Scorecard                                               -0.0477   0.0003 -155.2342 0.0000 -0.0483 -0.0471
# Balance                                                  0.0000   0.0000   20.0520 0.0000  0.0000  0.0000
# Payment                                                 -0.0008   0.0001  -15.3974 0.0000 -0.0009 -0.0007
# LTV                                                     -0.0159   0.0006  -27.4294 0.0000 -0.0170 -0.0147
# Lag_12_Unemployment                                      0.1392   0.0502    2.7751 0.0055  0.0409  0.2375
# PGDP                                                    -0.0639   0.0288   -2.2234 0.0262 -0.1203 -0.0076
# Inflation                                               -0.0603   0.0181   -3.3214 0.0009 -0.0958 -0.0247
# Lag_3_Houseprice                                         0.0000   0.0000    7.0258 0.0000  0.0000  0.0000
# =========================================================================================================











# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 3 -  Page 44 - figure 12      *********
# **********************************************************
# **********************************************************
# **********************************************************


# =============================================================================
# https://www.statology.org/plot-roc-curve-python/
# =============================================================================

# =============================================================================
# Step 1: Import Necessary Packages ----- sklearn 
# =============================================================================

from sklearn.linear_model import LogisticRegression
from sklearn import metrics
import matplotlib.pyplot as plt

# =============================================================================
# Step 2:  CREATE DUMMY BY Vintage 
# =============================================================================

dummy_Vintage=pd.get_dummies(mortgage_model_1['Vintage'],prefix='Vintage',)
dummy_Vintage.head(10)# 10 rows


# =============================================================================
#    Vintage_1970-1989  Vintage_1990-1999  Vintage_2000-2008  Vintage_>= 2009
# 0                  0                  0                  1                0
# 1                  0                  0                  1                0
# 2                  0                  0                  1                0
# 3                  0                  0                  1                0
# 4                  0                  0                  1                0
# 5                  0                  0                  1                0
# 6                  0                  0                  1                0
# 7                  0                  0                  1                0
# 8                  0                  0                  1                0
# 9                  0                  0                  1                0
# =============================================================================


#################################################################
####  Step 3:  Add dummy variables to the main data     #########
#################################################################

column_name=mortgage_model_1.columns.values.tolist()
mortgage_model_1=mortgage_model_1[column_name].join(dummy_Vintage)

del column_name


# =============================================================================
#  Step 4:define the predictor variables and the response variable  
# =============================================================================

cols=[ '_t_',  'Scorecard', 'Balance', 'Payment', 'LTV', 'Vintage_1970-1989', 
      'Vintage_1990-1999' , 'Vintage_2000-2008' ,'Lag_12_Unemployment', 'PGDP',
      'Inflation', 'Lag_3_Houseprice' ]

X=mortgage_model_1[cols]

y=mortgage_model_1['Censor']

# =============================================================================
#  Step 5:instantiate the model
# =============================================================================

log_regression = LogisticRegression()


# =============================================================================
# Step 6: Fit the model using the training data
# =============================================================================
log_regression.fit(X,y)

# =============================================================================
# https://stats.stackexchange.com/questions/203740/logistic-regression-scikit-learn-vs-statsmodels
# =============================================================================


# =============================================================================
# Step 7: Plot the ROC Curve
# =============================================================================

#define metrics

y_pred_proba = log_regression.predict_proba(X)[::,1]
fpr, tpr, _ = metrics.roc_curve(y,  y_pred_proba)



#create ROC curve
plt.plot(fpr,tpr)
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.show()



# =============================================================================
# Step 8: Calculate the AUC
# =============================================================================


#define metrics

auc = metrics.roc_auc_score(y, y_pred_proba)

auc

# =============================================================================
# Out[38]: 0.9659027374785445
# =============================================================================

# =============================================================================
# Step 9: create ROC curve
# =============================================================================



plt.plot(fpr,tpr,label="AUC="+str(auc))
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.legend(loc=4)
plt.show()


# =============================================================================
# Step 9: create ROC curve Improved
# =============================================================================


from sklearn.metrics import roc_curve

fpr, tpr, thresholds = roc_curve(y, log_regression.predict_proba(X)[:,1])
plt.figure()
plt.plot(fpr, tpr, label='Logistic Regression (area = %0.2f)' % auc)
plt.plot([0, 1], [0, 1],'r--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic')
plt.legend(loc="lower right")
plt.savefig('Log_ROC')
plt.show()
















# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 3 - Program 8 - Page 53       *********
# **********************************************************
# **********************************************************
# **********************************************************

# =============================================================================
# 
# ODS HTML STYLE = HTMLBLUE;
# ODS OUTPUT ParameterEstimates=  ParameterEstimates ModelANOVA=ModelANOVA ;;
# ODS GRAPHICS ON;
# proc logistic data= Mortgage_model_2 plots (maxpoints=10000)=(roc oddsratio ) ;
# class Vintage LTV_Segment/ PARAM=GLM  ;
# model Censor (event="1") = _t_ 
# Vintage   LTV_Segment
# Balance WOE_1 WOE_2 WOE_3  
# _csb1 _csb3 _csb4 _csb5  _csb7 _csb8 _csb9 
# Lag_12_Unemployment PGDP Lag_9_Inflation Lag_3_Houseprice  ;
# nloptions tech=quanew MAXIT=1000;
# run;
# ODS HTML CLOSE;
# =============================================================================

###############################################
######    import data set               #######
###############################################
mortgage_model_2 = pd.read_sas('mortgage_model_2.sas7bdat', encoding='windows-1252')


print (list(mortgage_model_2.columns))

# =============================================================================
# ['LTV_Segment', 'ID', '_t_', 'Start', 'End', 'Censor', 'Vintage', 'Scorecard',
#  'Balance', 'Payment', 'LTV', 'Sasdate', 'WOE_1', 'WOE_2', 'WOE_3', 'WOE_4', 
#  'Unemployment', 'Lag_1_Unemployment', 'Lag_2_Unemployment', 'Lag_3_Unemployment',
#  'Lag_4_Unemployment', 'Lag_5_Unemployment', 'Lag_6_Unemployment', 'Lag_7_Unemployment',
#  'Lag_8_Unemployment', 'Lag_9_Unemployment', 'Lag_10_Unemployment', 'Lag_11_Unemployment',
#  'Lag_12_Unemployment', 'Inflation', 'Lag_3_Inflation', 'Lag_6_Inflation',
#  'Lag_9_Inflation', 'Houseprice', 'Lag_3_Houseprice', 'Lag_6_Houseprice',
#  'Lag_9_Houseprice', 'GDP', 'Lag_1_GDP', 'Lag_2_GDP', 'Lag_3_GDP',
#  'Lag_4_GDP', 'Lag_5_GDP', 'Lag_6_GDP', 'Lag_7_GDP', 'Lag_8_GDP', 
#  'Lag_9_GDP', 'Lag_10_GDP', 'Lag_11_GDP', 'Lag_12_GDP', 'PGDP', 
#  '_csb1', '_csb2', '_csb3', '_csb4', '_csb5', '_csb6', '_csb7',
#  '_csb8', '_csb9', '_csb10']
# =============================================================================

results=frequency_table(mortgage_model_2["LTV_Segment"])

results.sort_index(inplace=True)
results
# =============================================================================
#           Frequency   Percent
# [0-70]      1332860  0.642989
# [70-100]     740052  0.357011
# =============================================================================


model = smf.logit(formula="Censor ~  _t_     +\
                  C(Vintage, Treatment(reference='>= 2009') )+ C(LTV_Segment, Treatment(reference='[70-100]') )  + \
                  Balance + WOE_1+ WOE_2 +WOE_3 +\
                  _csb1+  _csb3 +  _csb4 + _csb5 +  _csb7 + _csb8 + _csb9 +\
                  Lag_12_Unemployment +\
                  PGDP + Lag_9_Inflation + Lag_3_Houseprice", data=mortgage_model_2)

results = model.fit()
print(results.summary())

# =============================================================================
#                            Logit Regression Results                           
# ==============================================================================
# Dep. Variable:                 Censor   No. Observations:              2072912
# Model:                          Logit   Df Residuals:                  2072891
# Method:                           MLE   Df Model:                           20
# Date:                Sat, 05 Feb 2022   Pseudo R-squ.:                 0.09185
# Time:                        09:29:09   Log-Likelihood:                -52915.
# converged:                       True   LL-Null:                       -58267.
# Covariance Type:            nonrobust   LLR p-value:                     0.000
# =============================================================================================================================
#                                                                 coef    std err          z      P>|z|      [0.025      0.975]
# -----------------------------------------------------------------------------------------------------------------------------
# Intercept                                                   -20.2421      1.335    -15.161      0.000     -22.859     -17.625
# C(Vintage, Treatment(reference='>= 2009'))[T.1970-1989]       3.6156      0.100     36.115      0.000       3.419       3.812
# C(Vintage, Treatment(reference='>= 2009'))[T.1990-1999]       1.7955      0.084     21.414      0.000       1.631       1.960
# C(Vintage, Treatment(reference='>= 2009'))[T.2000-2008]       2.1236      0.064     33.214      0.000       1.998       2.249
# C(LTV_Segment, Treatment(reference='[70-100]'))[T.[0-70]]    -1.2899      0.027    -47.090      0.000      -1.344      -1.236
# _t_                                                          -0.1069      0.007    -14.824      0.000      -0.121      -0.093
# Balance                                                   -8.333e-07   1.46e-07     -5.700      0.000   -1.12e-06   -5.47e-07
# WOE_1                                                         0.1587      0.036      4.433      0.000       0.089       0.229
# WOE_2                                                        -0.5134      0.039    -13.029      0.000      -0.591      -0.436
# WOE_3                                                         0.5400      0.010     54.173      0.000       0.520       0.560
# _csb1                                                        -0.0173      0.001    -11.918      0.000      -0.020      -0.014
# _csb3                                                         0.0085      0.001     11.114      0.000       0.007       0.010
# _csb4                                                        -0.0108      0.001     -9.567      0.000      -0.013      -0.009
# _csb5                                                         0.0069      0.001      8.432      0.000       0.005       0.008
# _csb7                                                        -0.0047      0.001     -7.675      0.000      -0.006      -0.003
# _csb8                                                         0.0044      0.001      8.036      0.000       0.003       0.005
# _csb9                                                        -0.0014      0.000     -8.573      0.000      -0.002      -0.001
# Lag_12_Unemployment                                           0.3563      0.095      3.749      0.000       0.170       0.543
# PGDP                                                         -0.2143      0.050     -4.269      0.000      -0.313      -0.116
# Lag_9_Inflation                                              -0.1363      0.026     -5.184      0.000      -0.188      -0.085
# Lag_3_Houseprice                                           7.288e-05   5.22e-06     13.949      0.000    6.26e-05    8.31e-05
# =============================================================================================================================


# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************







