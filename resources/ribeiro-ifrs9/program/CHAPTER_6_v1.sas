/**********************************************************/
/**********************************************************/
/**********************************************************/
/******         CHAPTER 6 -FRACTIONAL MODELS          *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 1 - Page 103   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


data   k401;
set    k401;
Logemp  = Log(Totemp);
Logemp2 = Log(Totemp)*Log(Totemp);
Age2    = Age * Age;
run ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 2 - Page 105   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


ODS HTML ;
TITLE COLOR=RED "Model 1 " BOLD COLOR= BLACK "Program 2" BOLD COLOR=BLUE " ÅPage 631 Paper";
ods select ParameterEstimates   ;
proc reg data = k401;
model prate = mrate logemp logemp2 age age2 sole ;
run ;
quit;
ODS HTML CLOSE;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 3 - Page 106   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML ;
TITLE COLOR=RED "Model 2 " BOLD COLOR= BLACK " ÅProgram 3" BOLD COLOR=BLUE " ÅPage 631 Paper";
ods select ParameterEstimates   ;
proc nlmixed data = K401 tech = trureg;
parms b0 = 0 b1 = 0 b2 = 0 b3 = 0 
      b4 = 0 b5 = 0 b6 = 0 ;
xb =  b0 +         
      b1 * Mrate   +
      b2 * Logemp  + 
 	  b3 * Logemp2 + 
      b4 * Age     + 
      b5 * Age2    + 
      b6 * sole ;

mu = 1 / (1 + exp(-xb));  

lh = (mu ** Prate) * ((1 - mu) ** (1 - Prate)); 
ll = log(lh);
model Prate ~ general(ll);
run;
ODS HTML CLOSE;
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 4 - Page 107   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/
ods trace on;

ODS HTML ;
ods select  ModelInfo ParameterEstimates   ;
TITLE COLOR=RED "Model 3 - QMLE " BOLD COLOR= BLACK " - Program 4" BOLD COLOR=BLUE " - Page 631 Paper";
proc glimmix data = k401 ;
model prate = Mrate Logemp Logemp2 Age Age2 Sole / dist = binomial link = logit solution; 
random _residual_; 
run;
ODS HTML CLOSE;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 5 - Page 107   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/***************************************/
/**********    MODEL 4   ***************/
/***************************************/
OPTION NOLABEL;
ODS HTML ;
ods graphics on;
TITLE COLOR=RED "Model 4 " BOLD COLOR= BLUE " - Program 5"  ;
proc glimmix data = Mortgage_lgd plots=pearsonpanel order = data;
class ltv_segment   ;
model lgd = LTV_segment 
             Basel_LGD 	 
             pgdp 
             cpi_lag_3  
             unemployment_lag_4 
             interest_rate_lag_3  
             log_lag_2_houseprice / dist = binomial link = logit solution ; 
random _residual_;
weight  accounts ; 
lsmeans ltv_segment / ilink;
output  out = Forecast_4  (keep = lgd Lgd_forecast_4 ltv_segment sasdate) 
pred(ilink) = Lgd_forecast_4 ;
run;
ODS HTML CLOSE;


/***************************************/
/******   BOX PLOT FIGURE   ************/
/***************************************/
OPTION NOLABEL;
ODS HTML STYLE= CUSTOMSAPPHIRE;
ods graphics on;
ODS SELECT BoxPlot; 
TITLE COLOR=RED "Model 4 " BOLD COLOR= BLUE " - Program 5 - " BoxPlot ;
proc glimmix data = Mortgage_lgd  plots=boxplot( marginal observed )order = data;
class ltv_segment   ;
model lgd = LTV_segment 
             Basel_LGD 	 
             Pgdp 
             Cpi_lag_3  
             Unemployment_lag_4 
             Interest_rate_lag_3  
             Log_lag_2_houseprice  / dist = binomial link = logit solution ; 
random _residual_ ; 
weight  accounts;
run;
ODS HTML CLOSE;
			


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 6 - Page 115   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


ODS HTML ;
TITLE COLOR=RED "Program 6 " BOLD COLOR= BLUE " ÅEPage 115"  ;
proc means data = Mortgage_lgd  maxdec=5 n nmiss min mean max std ORDER =DATA ; 
var   lgd;
class ltv_segment;
run;
ods html close;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 7 - Page 117   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/



/***************************************/
/**********    MODEL 5   ***************/
/***************************************/
ODS HTML ;
ods graphics on ;
TITLE COLOR=RED "Model 5 " BOLD COLOR= BLUE " - Program 7"  ;
proc glimmix data = Mortgage_lgd plots = pearsonpanel ORDER =DATA ;
class  ltv_segment   ;
model  lgd =   LTV_segment Basel_LGD 	 
pgdp cpi_lag_3  unemployment_lag_4 interest_rate_lag_3  log_lag_2_houseprice
/ dist = binomial link = logit solution ; 
 _variance_ = _mu_**2 * (1-_mu_)**2;
lsmeans ltv_segment /ilink;
output  out =forecast_5( keep = lgd Lgd_forecast_5  LTV_segment sasdate ) 
pred(ilink) =Lgd_forecast_5  ;
weight  accounts;
run;
quit;
ods html close;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 8 - Page 119   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/***************************************/
/**********    MODEL 6   ***************/
/***************************************/

ODS HTML ;
ods graphics on ;
TITLE COLOR=RED "Model 6 " BOLD COLOR= BLUE " EProgram 8"  ;
proc glimmix data = Mortgage_lgd plots = pearsonpanel;;
model  lgd = Basel_LGD
             Pgdp
			          Unemployment_lag_4 
             Interest_rate_lag_1 
             Log_Houseprice / dist = binomial link = logit solution; 
weight  accounts;
random _residual_  ;
WHERE LTV_Segment="0<=LTV<=0.7"; 
output  out =forecast_6( keep = lgd Lgd_forecast_6 ltv_segment sasdate ) 
pred(ilink) =Lgd_forecast_6    ;
run;
quit;
ods html close;
	
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 9 - Page 120   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/***************************************/
/**********    MODEL 7   ***************/
/***************************************/

OPTION NOLABEL;
ODS HTML  ;
ods graphics on ;
TITLE COLOR=RED "Model 7 " BOLD COLOR= BLUE " ÅEProgram 9"  ;
proc glimmix data = Mortgage_lgd plots = pearsonpanel;;
model  lgd = Basel_LGD
             Pgdp
			 Unemployment_lag_4 
             Interest_rate_lag_1 
             Log_Houseprice / dist = binomial link = logit solution; 
weight  accounts;
_variance_ = _mu_**2 * (1-_mu_)**2;
WHERE LTV_Segment="0<=LTV<=0.7"; 
output  out = forecast_7( keep = lgd Lgd_forecast_7 ltv_segment sasdate ) 
pred(ilink) = Lgd_forecast_7;
run;
ODS HTML CLOSE;



/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 6 - Program 10 - Page 121  *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/***************************************/
/**********    MODEL 8   ***************/
/***************************************/

/***************************************/
/*********    STEP 01 - LAG     ********/
/***************************************/
				
data Mortgage_lgd;
set  Mortgage_lgd;
lgd_lag_1=lag(lgd);
WHERE LTV_Segment="0<=LTV<=0.7"; 
run;

/***************************************/
/*********    STEP 02 - model    *******/
/***************************************/

ODS HTML ;
ods graphics on ;
proc glimmix data = Mortgage_lgd plots = pearsonpanel;;
model  lgd =  lgd_lag_1 CPI_lag_4 Unemployment_lag_2 Log_Houseprice / dist = binomial link = logit solution; 
weight  accounts;
random _residual_;
WHERE LTV_Segment="0<=LTV<=0.7"; 
output  out = forecast_8( keep = lgd Lgd_forecast_8 ltv_segment sasdate ) 
pred(ilink) = Lgd_forecast_8;
run;
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/*********   Chapter 6 - Program 11 - Page 122    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML ;
ods graphics on ;
proc glimmix data = Mortgage_lgd plots = pearsonpanel;;
model  lgd =  lgd_lag_1 CPI_lag_4 Unemployment_lag_2 Log_Houseprice / dist = binomial link = logit solution; 
weight  accounts;
_variance_ = _mu_**2 * (1-_mu_)**2;
WHERE LTV_Segment="0<=LTV<=0.7"; 
output  out = forecast_9( keep = lgd Lgd_forecast_9 ltv_segment sasdate ) 
pred(ilink) = Lgd_forecast_9;
run;
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********  EOF ---   END OF FILE  ***********************/
/**********************************************************/
/**********************************************************/
/**********************************************************/

