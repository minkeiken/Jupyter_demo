###############################################
###############################################
#########         CHAPTER 4             #######
###############################################
###############################################

###################################  
#### Step 1 - Import the library
###################################  


import pandas                  as pd

pd.set_option('display.max_columns', 500)



###############################################
######    import data set               #######
###############################################
sme = pd.read_sas('sme.sas7bdat', encoding='windows-1252')

print (list(sme.columns))

# =============================================================================
# ['Id_number', 'Rating', 'Segment', 'Start', 
#  'End', 'Default', 'Unemployment', 'P1GDP']
# =============================================================================


print( sme.head(12)[['Id_number', 'Rating', 'Segment', 'Start', 
  'End', 'Default', 'Unemployment', 'P1GDP']])

# =============================================================================
#     Id_number Rating Segment  Start   End  Default  Unemployment     P1GDP
# 0         1.0     06      02    0.0   1.0      0.0      5.381802  2.638286
# 1         1.0     06      02    1.0   2.0      0.0      5.468690  2.723277
# 2         1.0     06      02    2.0   3.0      0.0      5.547722  3.921913
# 3         1.0     06      02    3.0   4.0      0.0      5.246166  4.135325
# 4         1.0     04      01    4.0   5.0      0.0      5.377862  3.445049
# 5         1.0     04      01    5.0   6.0      0.0      5.419767  4.605891
# 6         1.0     04      01    6.0   7.0      0.0      5.025285  5.350068
# 7         1.0     04      01    7.0   8.0      0.0      4.960769  5.491998
# 8         1.0     04      01    8.0   9.0      0.0      4.683444  4.709535
# 9         1.0     04      01    9.0  10.0      0.0      4.538473  4.331376
# 10        1.0     04      01   10.0  11.0      0.0      4.628194  2.625863
# 11        1.0     04      01   11.0  12.0      0.0      4.230530  3.975108
# =============================================================================

del sme['SASDATE' ]
del sme['Rating' ]



# =============================================================================
# Step 2:  CREATE DUMMY BY Segment 
# =============================================================================
dummy_Segment=pd.get_dummies(sme['Segment'],prefix='Segment',)
dummy_Segment.head(10)# 10 rows

del dummy_Segment['Segment_05' ]
dummy_Segment.head(10)# 10 rows


#################################################################
####  Step 3:  Add dummy variables to the main data     #########
#################################################################

column_name=sme.columns.values.tolist()
print (list(sme.columns))

sme=sme[column_name].join(dummy_Segment)

del sme['Segment']
print (list(sme.columns))


column=['Id_number', 'Start', 'End', 'Default', 'Segment_01', 'Segment_02', 
        'Segment_03', 'Segment_04', 'P1GDP', 'Unemployment' ]

sme=sme[column]


# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 4 - Program 2 - Page 65       *********
# **********************************************************
# **********************************************************
# **********************************************************

from lifelines import CoxTimeVaryingFitter
ctv = CoxTimeVaryingFitter()
# =============================================================================
# ctv.fit(sme, id_col="Id_number", event_col="Default", start_col="Start", stop_col="End", show_progress=True  )
# =============================================================================

ctv.fit(sme,  event_col="Default", start_col='Start', stop_col='End', id_col="Id_number", show_progress=False  )

ctv.plot()

ctv.print_summary(4, model="CoxTimeVaryingFitter")

# =============================================================================
# ctv.print_summary(4, model="CoxTimeVaryingFitter")
# Iteration 8: norm_delta = 0.00000, step_size = 1.00000, ll = -14691.94290, newton_decrement = 0.00000, seconds_since_start = 0.7Convergence completed after 8 iterations.
# <lifelines.CoxTimeVaryingFitter: fitted with 225974 periods, 28609 subjects, 1591 events>
#          event col = 'Default'
# number of subjects = 28609
#  number of periods = 225974
#   number of events = 1591
# partial log-likelihood = -14691.9429
#   time fit was run = 2022-02-07 10:53:34 UTC
#              model = CoxTimeVaryingFitter
# 
# ---
#                 coef  exp(coef)   se(coef)   coef lower 95%   coef upper 95%  exp(coef) lower 95%  exp(coef) upper 95%
# covariate                                                                                                             
# Segment_01   -2.4760     0.0841     0.1814          -2.8314          -2.1205               0.0589               0.1200
# Segment_02   -2.2248     0.1081     0.1534          -2.5255          -1.9242               0.0800               0.1460
# Segment_03   -1.8319     0.1601     0.1452          -2.1165          -1.5474               0.1205               0.2128
# Segment_04   -1.3920     0.2486     0.1461          -1.6785          -1.1056               0.1867               0.3310
# P1GDP        -0.1836     0.8322     0.0124          -0.2079          -0.1594               0.8123               0.8527
# Unemployment  0.2282     1.2563     0.0243           0.1806           0.2759               1.1979               1.3177
# 
#                     z      p   -log2(p)
# covariate                              
# Segment_01   -13.6525 <5e-05   138.5565
# Segment_02   -14.5045 <5e-05   155.9490
# Segment_03   -12.6174 <5e-05   118.8303
# Segment_04    -9.5255 <5e-05    69.0452
# P1GDP        -14.8494 <5e-05   163.2847
# Unemployment   9.3857 <5e-05    67.1168

# Partial AIC = 29395.8858
# log-likelihood ratio test = 601.5740 on 6 df
# -log2(p) of ll-ratio test = 418.4691
# 
# =============================================================================



# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************







