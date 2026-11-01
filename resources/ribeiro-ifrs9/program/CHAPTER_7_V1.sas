/**********************************************************/
/**********************************************************/
/**********************************************************/
/******         CHAPTER 7 - COMPETING RISKS           *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 7 - Program 1 - Page 137   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data  Cif ;
input Id Scorecard PGDP P_CPI_4 Unemployment_lag_1 ;
datalines;                      
1 550 2.90062367172977 1.54010770321617 5 
1 650 2.90062367172977 1.54010770321617 5 
1 750 2.90062367172977 1.54010770321617 5 
;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 7 - Program 2 - Page 137   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/



option label;
ODS HTML ;
/*---------   EVENTCODE(COX)= 1   ----------------*/
TITLE COLOR=RED "Competing Risks Model" BOLD COLOR=BLUE " - Default" height=18PT;
ods graphics on;
TITLE2 COLOR=RED "Cox Proportional" BOLD COLOR=BLUE " (Censor=1) ";
proc phreg data = BTL plots(overlay)=cif covsandwich(aggregate) ;
model End*Censor(0) = Scorecard PGDP p_cpi_4 unemployment_lag_1 /eventcode(cox)=1  ;
id    id;
baseline covariates=cif OUT =CIF_PLOT_1 CIF=CIF_1 /  rowid=Scorecard;
run;
/*---------  EVENTCODE(COX)= 2  ----------------*/
TITLE COLOR=RED "Competing Risks Model" BOLD COLOR=BLUE " - Prepayment"height=16;
ods graphics on;
TITLE2 COLOR=RED "Cox Proportional" BOLD COLOR=BLUE " (Censor=2)" ;
proc phreg data = BTL plots(overlay)=cif covsandwich(aggregate) ;
model End*Censor(0) = Scorecard PGDP p_cpi_4 unemployment_lag_1 /eventcode(cox)=2  ;
id    id;
baseline covariates=cif OUT =CIF_PLOT_2 CIF=CIF_2 /  rowid=Scorecard;
run;

ODS HTML CLOSE ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 7 - Program 3 - Page 141   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS TRACE OFF;
OPTION LABEL;
ODS HTML ;
/*---------   EVENTCODE(COX)= 1   ----------------*/
TITLE COLOR=RED "Competing Risks Model" BOLD COLOR=BLUE " - Default";
ods graphics on;
TITLE2 COLOR=RED "Fine and Grey Model" BOLD COLOR=BLUE " (Status=1) ";
proc phreg data = BTL plots(overlay)=cif covsandwich(aggregate) ;
model End*Censor(0) = Scorecard PGDP p_cpi_4 unemployment_lag_1 /eventcode (FG) =1  ;
id    id;
baseline covariates=cif OUT =CIF_PLOT_1 CIF=CIF_1 /  rowid=Scorecard;
run;
/*---------  EVENTCODE(COX)= 2  ----------------*/
TITLE COLOR=RED "Competing Risks Model" BOLD COLOR=BLUE " - Prepayment";
ods graphics on;
TITLE2 COLOR=RED "Fine and Grey Model" BOLD COLOR=BLUE " (Status=2) ";
proc phreg data = BTL plots(overlay)=cif covsandwich(aggregate) ;
model End*Censor(0) = Scorecard PGDP p_cpi_4 unemployment_lag_1 /eventcode (FG)=2  ;
id    id;
baseline covariates=cif OUT =CIF_PLOT_2 CIF=CIF_2 /  rowid=Scorecard;
run;

ODS LISTING CLOSE;
ODS HTML CLOSE ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 7 - Program 4 - Page 144   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


OPTION LABEL;
ODS HTML;
PROC LOGISTIC data = BTL;
MODEL Censor (REF="0") =  Scorecard  / link=glogit ;
nloptions tech=quanew MAXIT=1000;
run;
ODS HTML CLOSE ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 7 - Program 5 - Page 146   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML ;
ODS GRAPHICS ON;
PROC LOGISTIC data=BTL PLOTS (MAXPOINTS=10000)=( ODDSRATIO ) ;
MODEL Censor (REF="0") =  Scorecard pgdp p_cpi_4 unemployment_lag_1 / link=glogit EXPB ;

units Unemployment_lag_1  = 2
      pgdp                = 2 
      Scorecard           = 10 ;
      
nloptions tech=quanew MAXIT=1000;
run;
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     EOF ---   END OF FILE      ****************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
