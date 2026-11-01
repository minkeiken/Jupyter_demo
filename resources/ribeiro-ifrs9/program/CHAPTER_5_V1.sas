/**********************************************************/
/**********************************************************/
/**********************************************************/
/******           Chapter 5 - Recurrent Models        *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/*https://stats.oarc.ucla.edu/sas/faq/how-can-i-model-repeated-events-survival-analysis-in-proc-phreg/*/

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 5 - Program 1 - Page 89       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ods html ;
title color=red "model 1 " bold color=blue " – recurrent gap time using time_to_default";
proc logistic  data=recurrent namelen=200  plots (maxpoints=10000)=(roc oddsratio );
class  vintage_segment  / param=glm  ;
model default(event='1') = scorecard
                           time_to_default 
						   vintage_segment 
                           pgdp unemployment_lag_4 log_houseprice /link=logit; 
units 
time_to_default     = 1 2 
pgdp                = 1 2 
unemployment_lag_4  = 1 2  
 ;                   
run;
quit;
ods html close;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 5 - Program 2 - Page 93       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


ods html style= htmlblue;
title;
ods select parameterestimates   association ;
title color=red "Model 2 " bold color=blue " – Recurrent Intensity Model using Default_intensity";
proc logistic  data=Recurrent namelen=200  plots (maxpoints=10000)=(roc oddsratio );
model default(event='1') = scorecard
                           default_intensity 
						   log_lag_1_gdp 
                           unemployment_lag_4 
                           interest_rate_lag_1 
                           log_lag_3_houseprice /link=logit expb;                              
run;
ods html close;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 5 - Program 3 - Page 96       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ods trace on;

ODS HTML ;
OPTION NOLABEL;
TITLE COLOR=RED "Model 3 " BOLD COLOR=BLUE " - AG - Intensity Model";
proc phreg data= recurrent covm covs(aggregate);
class  vintage_segment  / param=glm  ;
model (tstart, tstop)*default(0)=scorecard vintage_segment pgdp unemployment_lag_4 log_houseprice ;
run;
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 5 - Program 4 - Page 97       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML ;
OPTION NOLABEL;
TITLE COLOR=RED "Model 4 " BOLD COLOR=BLUE " – The Proportional Rates/Means Model";
ods select  ParameterEstimates;
proc phreg data=recurrent covm covs(aggregate);
class  vintage_segment  / param=glm  ;
model (tstart, tstop) * default(0)=scorecard  vintage_segment pgdp unemployment_lag_4 log_houseprice ;
id id; 
run;
ODS HTML CLOSE;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 5 - Program 5 - Page 99       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


DATA Recurrent_2;
SET  Recurrent  ;
if Default_Intensity >= 4 then Default_Intensity = 4;
RUN ; 


ODS HTML ;
OPTION NOLABEL;
TITLE COLOR=RED "Model 5 " BOLD COLOR=BLUE " – The Prentice-Williams-Peterson Total Time Model (PWP-TT)";
proc phreg data= Recurrent_2 plots(overlay=stratum)= (survival)  covm covs(aggregate);
CLASS  Vintage_segment  / PARAM=GLM  ;
model (Tstart,TStop)*Default(0)=scorecard Vintage_segment pgdp unemployment_lag_4 log_houseprice ;
strata Default_Intensity;
run;
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********  EOF ---   END OF FILE  ***********************/
/**********************************************************/
/**********************************************************/
/**********************************************************/


