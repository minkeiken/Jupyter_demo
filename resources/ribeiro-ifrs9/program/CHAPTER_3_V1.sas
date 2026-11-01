/**********************************************************/
/**********************************************************/
/**********************************************************/
/******   CHAPTER 3 - ECONOMETRIC DATA PREPARATION    *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 1 - Page 33  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/
proc freq data=mortgage_model_1; 
tables end / nocol nopercent norow;
format end monyy7.;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 2 - Page 36  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/
ods graphics on;
proc logistic data= mortgage_model_1 plots (maxpoints=10000)=(roc oddsratio ) ;
class vintage / param=glm ;
model censor (event="1") = _t_ 
scorecard balance payment ltv  vintage 
lag_12_unemployment  pgdp inflation lag_3_houseprice / link=logit ;
units lag_12_unemployment = 1 2 
	  pgdp                = 1 2
      scorecard           = 1 10    50 
      balance             = 1 10000 20000
      lag_3_houseprice    = 1 10000 20000; 
nloptions tech=quanew maxit=1000;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/*********     Chapter 3 - Program 3 - Page 41    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data GDP;
set  GDP;
if _n_ = 2 then Pgdp + 1;
if _n_ = 3 then Pgdp + 2;
if _n_ = 4 then Pgdp + 3;
run;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 4 - Page 46  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/***************************************/
/**********        1     ***************/
/***************************************/

data   Score_Customer_id_3;
   set       Customer_id_3;
   %include "&FOLDER\score_code.sas";
run;


/* or below */

/***************************************/
/**********         2    ***************/
/***************************************/


data  Score_Customer_id_3;
SET   Customer_id_3;

*****************************************;
** SAS Scoring Code for PROC Logistic;
*****************************************;

length I_Censor $ 12;
label I_Censor = 'Into: Censor' ;
label U_Censor = 'Unnormalized Into: Censor' ;
format U_Censor BEST12.0;

label P_Censor1 = 'Predicted: Censor=1' ;
label P_Censor0 = 'Predicted: Censor=0' ;

drop _LMR_BAD;
_LMR_BAD=0;

*** Check interval variables for missing values;
if nmiss(_t_,Scorecard,Balance,Payment,LTV,Lag_12_Unemployment,PGDP,Inflation,
        Lag_3_Houseprice) then do;
   _LMR_BAD=1;
   goto _SKIP_000;
end;

*** Generate design variables for Vintage;
drop _0_0 _0_1 _0_2 _0_3 ;
_0_0= 0;
_0_1= 0;
_0_2= 0;
_0_3= 0;
length _st9 $ 9; drop _st9;
_st9 = left(trim(put (Vintage, $9.)));
if _st9 = '1970-1989'  then do;
   _0_0 = 1;
end;
else if _st9 = '1990-1999'  then do;
   _0_1 = 1;
end;
else if _st9 = '2000-2008'  then do;
   _0_2 = 1;
end;
else if _st9 = '>= 2009'  then do;
   _0_3 = 1;
end;
else do;
   _0_0 = .;
   _0_1 = .;
   _0_2 = .;
   _0_3 = .;
   _LMR_BAD=1;
   goto _SKIP_000;
end;

*** Compute Linear Predictors;
drop _LP0;
_LP0 = 0;

*** Effect: _t_;
_LP0 = _LP0 + (-0.00248963072439) * _t_;
*** Effect: Scorecard;
_LP0 = _LP0 + (-0.04770397409812) * Scorecard;
*** Effect: Balance;
_LP0 = _LP0 + (4.2647412732567E-6) * Balance;
*** Effect: Payment;
_LP0 = _LP0 + (-0.00078039355904) * Payment;
*** Effect: LTV;
_LP0 = _LP0 + (-0.01588155225145) * LTV;
*** Effect: Vintage;
_LP0 = _LP0 + (-0.66850218235608) * _0_0;
_LP0 = _LP0 + (-0.12234140304867) * _0_1;
_LP0 = _LP0 + (-0.38791929935261) * _0_2;
*** Effect: Lag_12_Unemployment;
_LP0 = _LP0 + (0.1391974555645) * Lag_12_Unemployment;
*** Effect: PGDP;
_LP0 = _LP0 + (-0.06392384350206) * PGDP;
*** Effect: Inflation;
_LP0 = _LP0 + (-0.06025990583634) * Inflation;
*** Effect: Lag_3_Houseprice;
_LP0 = _LP0 + (0.00002795188368) * Lag_3_Houseprice;

*** Predicted values;
drop _MAXP _IY _P0 _P1;
_TEMP = 21.5697344687743  + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
P_Censor1 = _P0;
_MAXP = _P0;
_IY = 1;
P_Censor0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
select( _IY );
   when (1) do;
      I_Censor = '1' ;
      U_Censor = 1;
   end;
   when (2) do;
      I_Censor = '0' ;
      U_Censor = 0;
   end;
   otherwise do;
      I_Censor = '';
      U_Censor = .;
   end;
end;
_SKIP_000:
if _LMR_BAD = 1 then do;
I_Censor = '';
U_Censor = .;
P_Censor1 = .;
P_Censor0 = .;
end;
drop _TEMP;

*************************************;
***** end scoring code for regression;
*************************************;
RUN;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 5 - Page 48  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/* SAS macro that duplicates the Excel RANDBETWEEN function */

/* https://blogs.sas.com/content/iml/2015/10/05/random-integers-sas.html */


%macro RandBetween(min, max);
   (&min + floor((1+&max-&min)*ranuni(seed) ))
%mend;


data  Score_Customer_id_3_RANDOM;
SET   Score_Customer_id_3;
seed = 123;
Lag_3_Houseprice = %RandBetween (170000, 200000);
run;

/****** OUTPUT 8 - Page 49   ****/
ODS LISTING;
PROC MEANS DATA= Score_Customer_id_3_RANDOM;
VAR Lag_3_Houseprice ;
RUN ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 6 - Page 51  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data Mortgage_model_2 ;
set  mortgage_model_1 ;
array k{10} _temporary_ (5 10 15 20 25 30 35 40 45 50);
array _csb{10};
do i=1 to 10;
_csb[i]=(_t_ >k[i])*(_t_-k[i])**3 - _t_**3 + 3*k[i]*_t_**2 - 3*k[i]**2*_t_;
varname="_csb"||strip(i);
index=i;
knotv=k[i];
end;
DROP varname i knotv index; 
run;

option label;
proc datasets lib=work nolist;
modify Mortgage_model_2;
LABEL _csb1  = "6-Input - Cubic Splines Basis  1";
LABEL _csb2  = "6-Input - Cubic Splines Basis  2";
LABEL _csb3  = "6-Input - Cubic Splines Basis  3";
LABEL _csb4  = "6-Input - Cubic Splines Basis  4";
LABEL _csb5  = "6-Input - Cubic Splines Basis  5";
LABEL _csb6  = "6-Input - Cubic Splines Basis  6";
LABEL _csb7  = "6-Input - Cubic Splines Basis  7";
LABEL _csb8  = "6-Input - Cubic Splines Basis  8";
LABEL _csb9  = "6-Input - Cubic Splines Basis  9";
LABEL _csb10 = "6-Input - Cubic Splines Basis 10";
quit;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 7- Page 52   **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/
DATA   Mortgage_model_2;
LENGTH LTV_Segment  $8 ;
SET    Mortgage_model_2;
     IF LTV <  70 THEN LTV_Segment="[0-70]";
Else IF LTV >= 70 THEN LTV_Segment="[70-100]";
RUN ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 8 - Page 53  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML STYLE = HTMLBLUE;
ODS OUTPUT ParameterEstimates=  ParameterEstimates ModelANOVA=ModelANOVA ;;
ODS GRAPHICS ON;
proc logistic data= Mortgage_model_2 plots (maxpoints=10000)=(roc oddsratio ) ;
class Vintage LTV_Segment/ PARAM=GLM  ;
model Censor (event="1") = _t_ 
Vintage   LTV_Segment
Balance WOE_1 WOE_2 WOE_3  
_csb1 _csb3 _csb4 _csb5  _csb7 _csb8 _csb9 
Lag_12_Unemployment PGDP Lag_9_Inflation Lag_3_Houseprice  ;
nloptions tech=quanew MAXIT=1000;
run;
ODS HTML CLOSE;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 9 - Page 56  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc dmdb data=Mortgage_model_2 out = dmdb_train dmdbcat=cat_train;
class   "Vintage"n  "LTV_Segment"n Censor(desc) ; 
var "Balance"n 
    "Lag_9_Inflation"n 
    "WOE_1"n  "WOE_2"n  "WOE_3"n  
    "Lag_12_Unemployment"n 
    "Lag_3_Houseprice"n 
    "PGDP"n 
     "_csb1"n   "_csb3"n   "_csb4"n   "_csb5"n   "_csb7"n   "_csb8"n   "_csb9"n  _t_ ;
run;
 

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 3 - Program 10 - Page 56  *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

filename _dmrfile "folder\score_code_model_2_dmreg.sas";

proc dmreg data=mortgage_model_2 dmdbcat = cat_train;
class censor  "vintage"n "ltv_segment"n;
model censor = _t_  
"vintage"n  "ltv_segment"n 
"balance"n "woe_1"n  "woe_2"n  "woe_3"n 
"_csb1"n "_csb3"n "_csb4"n "_csb5"n "_csb7"n "_csb8"n "_csb9"n 
"lag_12_unemployment"n "pgdp"n "lag_9_inflation"n "lag_3_houseprice"n /  link = glogit coding=glm;
code file = _dmrfile format = best32. group=surv ;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********  EOF ---   END OF FILE  ***********************/
/**********************************************************/
/**********************************************************/
/**********************************************************/


