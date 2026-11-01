###############################################
###############################################
#########         CHAPTER 5             #######
###############################################
###############################################

###################################  
#### Step 1 - Import the library
###################################  


import pandas as pd

pd.set_option('display.max_columns', 700)



###############################################
######    import data set               #######
###############################################
recurrent = pd.read_sas('recurrent.sas7bdat', encoding='windows-1252')


print (list(recurrent.columns))

# =============================================================================
# ['ID', 'Date', 'TStart', 'TStop', 'Default', 'Default_Intensity', 
# 'Time_to_Default', #  'Vintage_segment', 'Scorecard', 'TOB', 'PGDP',
# 'Log_lag_1_GDP', 'Log_lag_2_GDP', 
#  'Log_lag_3_GDP', 'Log_lag_4_GDP', 'CPI', 'CPI_lag_1', 'CPI_lag_2', 'CPI_lag_3', 
#  'CPI_lag_4', 'Unemployment', 'Unemployment_lag_1', 'Unemployment_lag_2', 
#  'Unemployment_lag_3', 'Unemployment_lag_4', 'Interest_rate', 
#  'Interest_rate_lag_1', 'Interest_rate_lag_2', 'Interest_rate_lag_3', 
#  'Interest_rate_lag_4', 'Log_Houseprice', 'Log_lag_1_Houseprice',
#  'Log_lag_2_Houseprice', 'Log_lag_3_Houseprice', 'Log_lag_4_Houseprice']
# =============================================================================

print( recurrent.head(12)[['Date', 'TStart', 'TStop', 'Default', 'Default_Intensity','Time_to_Default']])

# =============================================================================
# 
#          Date  TStart  TStop  Default  Default_Intensity  Time_to_Default
# 0  2005-12-01     0.0    1.0      0.0                0.0              0.0
# 1  2006-01-01     1.0    2.0      0.0                0.0              1.0
# 2  2006-02-01     2.0    3.0      0.0                0.0              2.0
# 3  2006-03-01     3.0    4.0      0.0                0.0              3.0
# 4  2006-04-01     4.0    5.0      0.0                0.0              4.0
# 5  2006-05-01     5.0    6.0      0.0                0.0              5.0
# 6  2006-06-01     6.0    7.0      0.0                0.0              6.0
# 7  2006-07-01     7.0    8.0      0.0                0.0              7.0
# 8  2006-08-01     8.0    9.0      0.0                0.0              8.0
# 9  2006-09-01     9.0   10.0      0.0                0.0              9.0
# 10 2006-10-01    10.0   11.0      0.0                0.0             10.0
# 11 2006-11-01    11.0   12.0      0.0                0.0             11.0
# 
# =============================================================================


def frequency_table(x):
   ###Compute frequency table for a pandas series 
    frequency = x.value_counts(normalize=False)
    frequency.index.name = x.name
    frequency.name = "Frequency"
    percent = x.value_counts(normalize=True)
    percent.name = "Percent"
    frequency_table = pd.concat([frequency, percent], axis="columns")
    return frequency_table


results=frequency_table(recurrent["Vintage_segment"])

results.sort_index(inplace=True)
results


#            Frequency   Percent
# 1996-2003      10449  0.162547
# 2004-2006      35831  0.557395
# >=2007         18003  0.280058
# =============================================================================


# **********************************************************
# **********************************************************
# **********************************************************
# *******      Chapter 5 - Program 1 - Page 89     *********
# **********************************************************
# **********************************************************
# **********************************************************


import statsmodels.formula.api as smf

model = smf.logit(formula="Default ~  Scorecard  + Time_to_Default   +\
                  C(Vintage_segment, Treatment(reference='>=2007') )+ \
                  PGDP + Unemployment_lag_4 + Log_Houseprice", data=recurrent)

results = model.fit()

print(results.summary2())

# =============================================================================
#                                                   Results: Logit
# ==================================================================================================================
# Model:                              Logit                            Pseudo R-squared:                 0.028      
# Dependent Variable:                 Default                          AIC:                              23400.9159 
# Date:                               2022-02-07 19:32                 BIC:                              23473.4843 
# No. Observations:                   64283                            Log-Likelihood:                   -11692.    
# Df Model:                           7                                LL-Null:                          -12029.    
# Df Residuals:                       64275                            LLR p-value:                      3.4519e-141
# Converged:                          1.0000                           Scale:                            1.0000     
# No. Iterations:                     8.0000                                                                        
# ------------------------------------------------------------------------------------------------------------------
#                                                                 Coef.   Std.Err.    z     P>|z|   [0.025   0.975] 
# ------------------------------------------------------------------------------------------------------------------
# Intercept                                                      -26.7413   5.6448  -4.7374 0.0000 -37.8048 -15.6777
# C(Vintage_segment, Treatment(reference='>=2007'))[T.1996-2003]  -0.7722   0.0730 -10.5830 0.0000  -0.9152  -0.6292
# C(Vintage_segment, Treatment(reference='>=2007'))[T.2004-2006]  -0.1963   0.0423  -4.6434 0.0000  -0.2791  -0.1134
# Scorecard                                                       -0.0037   0.0003 -10.9774 0.0000  -0.0044  -0.0030
# Time_to_Default                                                 -0.0201   0.0016 -12.5415 0.0000  -0.0233  -0.0170
# PGDP                                                            -0.1133   0.0259  -4.3794 0.0000  -0.1640  -0.0626
# Unemployment_lag_4                                               0.1938   0.0302   6.4192 0.0000   0.1347   0.2530
# Log_Houseprice                                                   2.0981   0.4472   4.6922 0.0000   1.2217   2.9745
# ==================================================================================================================
# =============================================================================



# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 5 - Program 2 - Page 93       *********
# **********************************************************
# **********************************************************
# **********************************************************


model2 = smf.logit(formula="Default ~  Scorecard  + Default_Intensity       \
                 + Log_lag_1_GDP +  Unemployment_lag_4 + Interest_rate_lag_1\
                 + Log_lag_3_Houseprice", data=recurrent)

results2 = model2.fit()

print(results2.summary2())

# =============================================================================
# =====================================================================
# Model:                Logit             Pseudo R-squared:  0.014     
# Dependent Variable:   Default           AIC:               23744.3919
# Date:                 2022-02-07 19:56  BIC:               23807.8893
# No. Observations:     64283             Log-Likelihood:    -11865.   
# Df Model:             6                 LL-Null:           -12029.   
# Df Residuals:         64276             LLR p-value:       7.7876e-68
# Converged:            1.0000            Scale:             1.0000    
# No. Iterations:       9.0000                                         
# ---------------------------------------------------------------------
#                       Coef.  Std.Err.    z     P>|z|   [0.025  0.975]
# ---------------------------------------------------------------------
# Intercept            65.5550  14.7589   4.4417 0.0000 36.6282 94.4819
# Scorecard            -0.0038   0.0003 -11.4037 0.0000 -0.0045 -0.0032
# Default_Intensity     0.0341   0.0124   2.7378 0.0062  0.0097  0.0584
# Log_lag_1_GDP        -4.0143   0.8568  -4.6853 0.0000 -5.6936 -2.3351
# Unemployment_lag_4    0.0911   0.0392   2.3222 0.0202  0.0142  0.1680
# Interest_rate_lag_1   0.1290   0.0213   6.0421 0.0000  0.0871  0.1708
# Log_lag_3_Houseprice -1.2068   0.5286  -2.2830 0.0224 -2.2427 -0.1708
# =====================================================================
# =============================================================================



############################################################
############################################################
############################################################
####### Chapter 5 - Program 3 - Page 96 - Model 3    #######
############################################################
############################################################
############################################################



# =============================================================================
# Step 2:  CREATE DUMMY BY Segment 
# =============================================================================
dummy_Segment=pd.get_dummies(recurrent['Vintage_segment'],prefix='Vintage_segment',)
dummy_Segment.head(10)# 10 rows

del dummy_Segment['Segment_05' ]
dummy_Segment.head(10)# 10 rows


['Vintage_segment_1996-2003', 'Vintage_segment_2004-2006', 'Vintage_segment_>=2007']




#################################################################
####  Step 3:  Add dummy variables to the main data     #########
#################################################################

column_name=recurrent.columns.values.tolist()
recurrent2=recurrent[column_name].join(dummy_Segment)

del recurrent2['Vintage_segment' ]
print (list(recurrent2.columns))


column=['TStart', 'TStop', 'Default', 'Scorecard',
        'PGDP',  'Unemployment_lag_4','Log_Houseprice',
        'Vintage_segment_1996-2003', 'Vintage_segment_2004-2006' ]

recurrent2=recurrent2[column]


print (list(recurrent2.columns))


# =============================================================================
# proc phreg data= recurrent ;
# class  vintage_segment  / param=glm  ;
# model (tstart, tstop)*default(0)=scorecard vintage_segment pgdp unemployment_lag_4 log_houseprice ;
# run;
# =============================================================================



### https://stats.stackexchange.com/questions/493289/recurrent-events-analysis-software-python

# =============================================================================
# https://lifelines.readthedocs.io/en/latest/fitters/regression/CoxTimeVaryingFitter.html#
# https://lifelines.readthedocs.io/en/latest/Time%20varying%20survival%20regression.html
# https://buildmedia.readthedocs.org/media/pdf/lifelines/latest/lifelines.pdf
# =============================================================================

from lifelines import CoxTimeVaryingFitter
ctv = CoxTimeVaryingFitter()

ctv.fit(recurrent2,  event_col="Default", start_col='TStart', stop_col='TStop', show_progress=False  )

ctv.plot()

ctv.print_summary(6, model="CoxTimeVaryingFitter")





# =============================================================================
# <lifelines.CoxTimeVaryingFitter:
#     fitted with 64283 periods, 64283 subjects, 2969 events>
#          event col = 'Default'
# number of subjects = 64283
#  number of periods = 64283
#   number of events = 2969
# partial log-likelihood = -22038.588706
# =============================================================================
# =============================================================================
#                                coef  exp(coef)   se(coef)   coef lower 95%   coef upper 95%  exp(coef) lower 95%  exp(coef) upper 95%
# covariate                                                                                                                            
# Scorecard                 -0.003649   0.996358   0.000328        -0.004291        -0.003006             0.995718             0.996998
# PGDP                      -0.110288   0.895576   0.025132        -0.159545        -0.061031             0.852532             0.940794
# Unemployment_lag_4         0.189333   1.208443   0.029436         0.131639         0.247026             1.140696             1.280213
# Log_Houseprice             2.077298   7.982870   0.435747         1.223250         2.931346             3.398215            18.752846
# Vintage_segment_1996-2003 -0.744889   0.474787   0.071468        -0.884963        -0.604814             0.412729             0.546176
# Vintage_segment_2004-2006 -0.185070   0.831046   0.040930        -0.265292        -0.104848             0.766982             0.900462
# 
#                                    z        p   -log2(p)
# covariate                                               
# Scorecard                 -11.134328   <5e-07  93.241908
# PGDP                       -4.388417 0.000011  16.418345
# Unemployment_lag_4          6.431978   <5e-07  32.886386
# Log_Houseprice              4.767216 0.000002  19.030158
# Vintage_segment_1996-2003 -10.422708   <5e-07  82.082420
# Vintage_segment_2004-2006  -4.521564 0.000006  17.313698
# ---
# Partial AIC = 44089.177412
# log-likelihood ratio test = 259.806222 on 6 df
# -log2(p) of ll-ratio test = 174.345779
# =============================================================================



##############################################################
##############################################################
##############         ENF OF FILE         ###################
##############################################################
##############################################################




