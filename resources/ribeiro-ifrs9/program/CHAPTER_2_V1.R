###############################################
###############################################
#########         CHAPTER 2             #######
###############################################
###############################################

#install.packages("graphics"    , dependencies=TRUE)
#install.packages("survival"    , dependencies=TRUE)
#install.packages("sas7bdat"    , dependencies=TRUE)
#install.packages("jtools"      , dependencies=TRUE)
#install.packages("Hmisc"       , dependencies=TRUE)
#install.packages("haven"       , dependencies=TRUE)
#install.packages("FMM"         , dependencies=TRUE)


# Activate the library
library(sas7bdat)
library(jtools)
library(Hmisc)
library(haven)
library(graphics)


# **********************************************************
# **********************************************************
# **********************************************************
# *******    Chapter 2 - Program 1 - Page 14       *********
# **********************************************************
# **********************************************************
# **********************************************************



###############################################
######    import data set               #######
###############################################

##### Read in the SAS data
unemployment <- read.sas7bdat("unemployment.sas7bdat")

head(unemployment)

# Sasdate Unemployment
# 1   14245          6.2
# 2   14276          6.2
# 3   14304          6.2
# 4   14335          6.1
# 5   14365          6.0
# 6   14396          6.0

unemployment$Sasdate<- as.Date(unemployment$Sasdate, '1960-01-01')
head(unemployment)

#      Sasdate Unemployment
# 1 1999-01-01          6.2
# 2 1999-02-01          6.2
# 3 1999-03-01          6.2
# 4 1999-04-01          6.1
# 5 1999-05-01          6.0
# 6 1999-06-01          6.0

unemployment[1:5,c("Sasdate","Unemployment") ]

#      Sasdate Unemployment
# 1 1999-01-01          6.2
# 2 1999-02-01          6.2
# 3 1999-03-01          6.2
# 4 1999-04-01          6.1
# 5 1999-05-01          6.0



############################################################
############################################################
############################################################
#######      Chapter 2 - Program 2 - Page 15         #######
############################################################
############################################################
############################################################

# https://stackoverflow.com/questions/44820406/convert-sas-date-format-to-r

economic_month_1 <- read.sas7bdat("economic_month_1.sas7bdat")
economic_month_1$Sasdate<- as.Date(economic_month_1$Sasdate , '1960-01-01')

economic_month_1[1:5,c("Sasdate","Unemployment","Inflation","Houseprice")]

#      Sasdate Unemployment Inflation Houseprice
# 1 1999-01-01          6.2       1.6   66384.92
# 2 1999-02-01          6.2       1.4   67021.05
# 3 1999-03-01          6.2       1.7   68308.08
# 4 1999-04-01          6.1       1.5   68856.13
# 5 1999-05-01          6.0       1.3   69932.91

############################################################
############################################################
############################################################
#######      Chapter 2 - Program 3 - Page 16         #######
############################################################
############################################################
############################################################

# https://www.rdocumentation.org/packages/plm/versions/1.6-5/topics/lag

economic_month_1$Lag_3_Unemployment <- Lag(economic_month_1$Unemployment, 3)
economic_month_1$Lag_6_Unemployment <- Lag(economic_month_1$Unemployment, 6)
economic_month_1$Lag_9_Unemployment <- Lag(economic_month_1$Unemployment, 9)

economic_month_1[1:12,c("Sasdate","Lag_3_Unemployment",
                        "Lag_6_Unemployment","Lag_9_Unemployment" )]


#       Sasdate Lag_3_Unemployment Lag_6_Unemployment Lag_9_Unemployment
# 1  1999-01-01                 NA                 NA                 NA
# 2  1999-02-01                 NA                 NA                 NA
# 3  1999-03-01                 NA                 NA                 NA
# 4  1999-04-01                6.2                 NA                 NA
# 5  1999-05-01                6.2                 NA                 NA
# 6  1999-06-01                6.2                 NA                 NA
# 7  1999-07-01                6.1                6.2                 NA
# 8  1999-08-01                6.0                6.2                 NA
# 9  1999-09-01                6.0                6.2                 NA
# 10 1999-10-01                5.9                6.1                6.2
# 11 1999-11-01                5.9                6.0                6.2
# 12 1999-12-01                5.8                6.0                6.2


############################################################
############################################################
############################################################
#######      Chapter 2 - Program 4 - Page 17         #######
############################################################
############################################################
############################################################

# https://www.datasciencemadesimple.com/log-function-r-log/

economic_month_1$Log_Houseprice       <- log(economic_month_1$Houseprice)
economic_month_1$Lag_3_Houseprice     <- Lag(economic_month_1$Houseprice    , 3)
economic_month_1$Log_LAG_3_Houseprice <- Lag(economic_month_1$Log_Houseprice, 3)

economic_month_1[1:12,c("Sasdate","Houseprice","Lag_3_Houseprice",
                        "Log_Houseprice",'Log_LAG_3_Houseprice')]

#       Sasdate Houseprice Lag_3_Houseprice Log_Houseprice Log_LAG_3_Houseprice
# 1  1999-01-01   66384.92               NA       11.10323                   NA
# 2  1999-02-01   67021.05               NA       11.11276                   NA
# 3  1999-03-01   68308.08               NA       11.13178                   NA
# 4  1999-04-01   68856.13         66384.92       11.13977             11.10323
# 5  1999-05-01   69932.91         67021.05       11.15529             11.11276
# 6  1999-06-01   70789.07         68308.08       11.16746             11.13178
# 7  1999-07-01   71232.00         68856.13       11.17370             11.13977
# 8  1999-08-01   72634.72         69932.91       11.19320             11.15529
# 9  1999-09-01   73232.46         70789.07       11.20139             11.16746
# 10 1999-10-01   73768.89         71232.00       11.20869             11.17370
# 11 1999-11-01   74954.05         72634.72       11.22463             11.19320
# 12 1999-12-01   75218.66         73232.46       11.22815             11.20139




############################################################
############################################################
############################################################
#######      Chapter 2 - Program 5 - Page 19         #######
############################################################
############################################################
############################################################


economic_month_1$Lag_3_Unemployment = Lag(economic_month_1$Unemployment, 3)
economic_month_1$Lag_6_Unemployment = Lag(economic_month_1$Unemployment, 6)
economic_month_1$Lag_9_Unemployment = Lag(economic_month_1$Unemployment, 9)

economic_month_1$Lag_3_Inflation    = Lag(economic_month_1$Inflation   , 3)
economic_month_1$Lag_6_Inflation    = Lag(economic_month_1$Inflation   , 6)
economic_month_1$Lag_9_Inflation    = Lag(economic_month_1$Inflation   , 9)

economic_month_1$Lag_3_Houseprice   = Lag(economic_month_1$Houseprice  , 3)
economic_month_1$Lag_6_Houseprice   = Lag(economic_month_1$Houseprice  , 6)
economic_month_1$Lag_9_Houseprice   = Lag(economic_month_1$Houseprice  , 9)

### open the dataframe to see the results











############################################################
############################################################
############################################################
#######      Chapter 2 - Program 7 - Page 21         #######
############################################################
############################################################
############################################################

# https://stackoverflow.com/questions/25062408/interpolate-extend-quarterly-to-monthly-series


gdp_quarter_1         <- read.sas7bdat("gdp_quarter_1.sas7bdat")
gdp_quarter_1$Sasdate <- as.Date(gdp_quarter_1$Sasdate, '1960-01-01')

gdp_quarter_1[1:5,c("Sasdate","GDP") ]

#      Sasdate    GDP
# 1 1999-01-01 337294
# 2 1999-04-01 337547
# 3 1999-07-01 343693
# 4 1999-10-01 348449
# 5 2000-01-01 351979


DateSeq_month <- seq(gdp_quarter_1$Sasdate[1],
                     tail(gdp_quarter_1$Sasdate,1),by="1 month")

DateSeq_month

# [1]  "1999-01-01" "1999-02-01" "1999-03-01" "1999-04-01" "1999-05-01"
# [6]  "1999-06-01" "1999-07-01" "1999-08-01" "1999-09-01" "1999-10-01"
# [11] "1999-11-01" "1999-12-01" "2000-01-01" "2000-02-01" "2000-03-01"
# [16] "2000-04-01" "2000-05-01" "2000-06-01" "2000-07-01" "2000-08-01"
# ----- 
# -----
# [191] "2014-11-01" "2014-12-01" "2015-01-01" "2015-02-01" "2015-03-01"
# [196] "2015-04-01" "2015-05-01" "2015-06-01" "2015-07-01" "2015-08-01"
# [201] "2015-09-01" "2015-10-01" "2015-11-01" "2015-12-01" "2016-01-01"
# [206] "2016-02-01" "2016-03-01" "2016-04-01"

### Numerical Interpolation: Natural Cubic Spline

GDP_month  <- data.frame(Sasdate  = DateSeq_month, 
                         GDP= spline(gdp_quarter_1, method="natural", 
                         xout     = DateSeq_month)$y)
GDP_month 

#     Sasdate      GDP
# 1   1999-01-01 337294.0
# 2   1999-02-01 336885.1
# 3   1999-03-01 336849.0
# 4   1999-04-01 337547.0
# 5   1999-05-01 339178.4
# 6   1999-06-01 341454.7

GDP_month=merge(gdp_quarter_1, GDP_month, by='Sasdate', all.y = T)

head(GDP_month)

#      Sasdate  GDP.x    GDP.y
# 1 1999-01-01 337294 337294.0
# 2 1999-02-01     NA 336885.1
# 3 1999-03-01     NA 336849.0
# 4 1999-04-01 337547 337547.0
# 5 1999-05-01     NA 339178.4
# 6 1999-06-01     NA 341454.7


############################################################
############################################################
############################################################
#######      Chapter 2 - Program 8 - Page 23         #######
############################################################
############################################################
############################################################

# https://stackoverflow.com/questions/30678606/quarterly-year-over-year-growth-rate


gdp_quarter_1         <- read.sas7bdat("gdp_quarter_1.sas7bdat")

############################
# set date to a date object
gdp_quarter_1$Sasdate <- as.Date(gdp_quarter_1$Sasdate, '1960-01-01')
gdp_quarter_1[1:5,c("Sasdate","GDP") ]



# order by date
gdp_quarter_1 <- gdp_quarter_1[order(gdp_quarter_1$Sasdate), ]


# function to calculate differences
f <- function(x) c(NA, 100*diff(x)/x[-length(x)])

gdp_quarter_1$PGDP <- ave(gdp_quarter_1$GDP, 
                          format(gdp_quarter_1$Sasdate, "%m"), FUN=f)

gdp_quarter_1

#       Sasdate    GDP       PGDP
# 1  1999-01-01 337294         NA
# 2  1999-04-01 337547         NA
# 3  1999-07-01 343693         NA
# 4  1999-10-01 348449         NA
# 5  2000-01-01 351979  4.3537685
# 6  2000-04-01 354546  5.0360394
# 7  2000-07-01 355557  3.4519178
# 8  2000-10-01 356094  2.1940083
# 9  2001-01-01 360749  2.4916259
# 10 2001-04-01 363235  2.4507398


# **********************************************************
# **********************************************************
# **********************************************************
# *******          EOF -  END OF FILE              *********
# **********************************************************
# **********************************************************
# **********************************************************





 
 
 
 
 