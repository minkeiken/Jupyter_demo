/**********************************************************/
/**********************************************************/
/**********************************************************/
/******   CHAPTER 4 - The Extended Cox Hazard Model   *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/********   Chapter 4 - Program 1 - Page 65       *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data SME;
set  SME;
     if Rating in ('01','02','03','04','05'     ) then Segment='01';
else if Rating in ('06','07','08','09','10','11') then Segment='02';
else if Rating in ('12','13','14','15','16')      then Segment='03';
else if Rating in ('17','18','19','20')           then Segment='04';
else if Rating in ('21','22','23')                then Segment='05';
run;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 2 - Page 65  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

option nolabel;
ods html ;
ods listing;
ods graphics on;
proc phreg data = SME covsandwich(aggregate) plots(overlay cl) = (survival cumhaz) ;
class Segment;      
model (Start,End)*Default(0) = Segment P1GDP Unemployment;
id    id_number;
hazardratio P1GDP        / units = 1 2 3 4 5;
hazardratio Unemployment / units = 1 2 3 4 5;
hazardratio Segment      / diff  = ref; 
run;
ods listing close;
ods html close ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 3 - Page 72  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


	
/**********************************************************/
/**********    SCENARIO ANALYSIS - 1             *********/
/**********************************************************/

ODS HTML image_dpi=300 ;
ODS GRAPHICS ON ;
PROC PHREG DATA = SME  COVSANDWICH(AGGREGATE)  
PLOTS(OVERLAY CL )= (Survival CUMHAZ); 
CLASS  Segment ;
MODEL  (START,END)*DEFAULT(0)=Segment P1GDP Unemployment ;
ID  Id_number;
BASELINE covariates = Scenario_1 
OUT      = Scenario_1_Result   
SURVIVAL = SURVIVAL 
CUMHAZ   = CUMHAZ  /ROWID=Segment ;
RUN; 
ODS HTML CLOSE ;
											

/**********************************************************/
/**********      SCENARIO ANALYSIS - 2       **************/
/**********************************************************/

ODS HTML  image_dpi=300 ;
ODS GRAPHICS ON ;
PROC PHREG DATA = SME  COVSANDWICH(AGGREGATE)  
PLOTS(OVERLAY CL )= (Survival CUMHAZ); 
CLASS  Segment ;
MODEL  (START,END)*DEFAULT(0)=Segment P1GDP Unemployment ;
ID  Id_number;
BASELINE covariates = Scenario_2 
OUT      = Scenario_2_Result     
SURVIVAL = SURVIVAL 
CUMHAZ   = CUMHAZ  /ROWID=Segment ;
RUN; 
ODS HTML CLOSE;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 4 - Page 74  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data Sme_Dummy;
set  sme  ;
Segment_01 =(Segment='01');
Segment_02 =(Segment='02');
Segment_03 =(Segment='03');
Segment_04 =(Segment='04');
Segment_05 =(Segment='05'); 
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 5 - Page 74  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


ODS HTML  ;
proc phreg data = sme_dummy  covsandwich(aggregate);
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 P1GDP Unemployment;
id  id_number;
run;
ODS HTML  CLOSE; 

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 6 - Page 75  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


Data Zerocov;
P1GDP = 0;
Unemployment = 0;
Segment_01   = 0;
Segment_02   = 0;
Segment_03   = 0;
Segment_04   = 0;
Run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 7 - Page 76  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML  ;
proc phreg data = sme_dummy  covsandwich(aggregate) ;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 P1GDP Unemployment;
id  id_number;
baseline 
	covariates = Zerocov 
	out        = Baseline   
	survival   = Baseline ;
	OUTPUT OUT=OUTPUT (WHERE=(id_number=617)) SURVIVAL=SURVIVAL_PHREG XBETA=XBETA  ; 
run;
ODS HTML  CLOSE; 


DATA Baseline;
SET  Baseline; 
RENAME END = Time;
RUN ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 8 - Page 77  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

PROC SORT DATA =sme_dummy   OUT=Scoredata_617(rename=(END=Time));
BY    id_number;
WHERE id_number =617 ;
RUN;


DATA Baseline;
SET  Baseline; 
KEEP Time Baseline;
RUN ;


ODS HTML  STYLE= HTMLBLUE;
ODS LISTING;
OPTION NOCENTER;
PROC PRINT DATA=PARA_EST NOOBS ;
VAR Parameter  Estimate ;
FORMAT Estimate BEST32.;
RUN ;
ODS HTML  CLOSE; 


data Scoredata_617(drop=lastS);
retain lastS 1;
merge Scoredata_617 Baseline;
by    Time;
if missing(Baseline) then Baseline=lastS;
else                    lastS = Baseline;
Survival_scored = Baseline ** exp( -2.44279312832475 * Segment_01 +  
								   -2.19325688308294 * Segment_02 +  
								   -1.80171901154827 * Segment_03 +  
								   -1.36423144878050 * Segment_04 +  
								   -0.18256838765585 * P1GDP      +
								    0.22684070032937 * Unemployment);
IF id_number=. then delete;
DROP SEGMENT START  Segment_01 Segment_02 Segment_03 
Segment_04 Segment_05 Rating Unemployment P1GDP default;
run;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********     Chapter 4 - Program 9 - Page 78  **********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

/***************************************/
/**********    STEP 01   ***************/
/***************************************/

Data Zerocov;
P1GDP = 0;
Unemployment = 0;
Segment_01   = 0;
Segment_02   = 0;
Segment_03   = 0;
Segment_04   = 0;
Run;

/***************************************/
/**********    STEP 02   ***************/
/***************************************/
proc phreg data = sme_dummy  covsandwich(aggregate) noprint;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 P1GDP Unemployment;
id  id_number;
baseline 
	covariates = Zerocov 
	out        = Baseline   
	survival   = Baseline ;
	OUTPUT OUT=OUTPUT (WHERE=(id_number=617)) Survival=Survival Xbeta=Xbeta  ; 
run;


DATA Baseline;
SET  Baseline; 
RENAME END = Time;
RUN ;

/***************************************/
/**********    STEP 03   ***************/
/***************************************/


Data Stress_Test; 
input id_number  Time       Segment $ P1GDP Unemployment
      Segment_01 Segment_02 Segment_03 Segment_04 Segment_05 ; 
Datalines; 
617 40  01  1.1  5.2  1 0 0 0 0
617 41  01  0.9  4.3  1 0 0 0 0
617 42  01  1.5  4.5  1 0 0 0 0
617 43  01  0.5  5.6  1 0 0 0 0
617 44  01 -0.2  6.7  1 0 0 0 0
617 45  01  1.2  7.2  1 0 0 0 0
617 46  01  0.8  4.5  1 0 0 0 0
617 47  01  1.8  5.6  1 0 0 0 0
617 48  01  4.3  6.1  1 0 0 0 0
617 49  01 -0.5  8.1  1 0 0 0 0
617 50  01  1.2  10   1 0 0 0 0
617 51  01  1.8  12   1 0 0 0 0
; 
run ;

DATA Stress_Test;
RETAIN Sasdate DATE;
SET  Stress_Test;
LENGTH  DAY      $2  
		MONTH    $3 
		YEAR     $4 
		DATASAS  $10;
DATE=intnx('qtr','01JAN2011'd,_n_-1);

MONTH = MONTH (DATE); 
YEAR =  YEAR  (DATE);  
DAY='01'; 
DATASAS = CATX("-",DAY,MONTH,YEAR) ;
SASDATE = INPUT(DATASAS, DDMMYY10.);
drop month day year date datasas ;
FORMAT    SASDATE YYQ6.;
RUN ;
title;

/***************************************/
/**********    STEP 04   ***************/
/***************************************/


data Stress_Test2(drop=lastS);
retain lastS 1;
merge Stress_Test Baseline;
by    Time;
if missing(Baseline) then Baseline=lastS;
else                    lastS = Baseline;
Survival    = Baseline ** exp( -2.44279312832475 * Segment_01 +  
								   -2.19325688308294 * Segment_02 +  
								   -1.80171901154827 * Segment_03 +  
								   -1.36423144878050 * Segment_04 +  
								   -0.18256838765585 * P1GDP      +
								    0.22684070032937 * Unemployment);
IF id_number=. then delete;
DROP SEGMENT   Segment_01 Segment_02 Segment_03 
Segment_04 Segment_05  Baseline  ;
run;

/***************************************/
/**********    STEP 05   ***************/
/***************************************/


DATA  Stress_Test3;
set   output (DROP = XBETA  )
Stress_Test2 (rename = (Time = end));
RUN ;

/***************************************/
/**********    STEP 06   ***************/
/***************************************/


ODS HTML STYLE=HTMLBLUE ;
Title1 'Stressed Survival - Segment 01';
title;
proc sgplot data=Stress_Test3;
series x=sasdate y=Survival / markers 
markerattrs=(symbol=circlefilled color=blue)
lineattrs=(color=blue); 
refline '01JAN2011'd / axis=x lineattrs=(color=red thickness= 3 );
xaxis LABEL="Year"  
valueattrs=(Color=Black Family=Arial Size=10 Weight=Bold) 
LABELATTRS=(Color=Black Family=Arial Size=10   Weight=Bold) ;

yaxis LABEL="Stressed Survival - Segment 01" 
LABELATTRS=(Color=Black Family=Arial Size=10   Weight=Bold) ;
WHERE YEAR(sasdate) > 2001; 
run;
ODS HTML CLOSE ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********   Chapter 4 - Program 10 - Page 80    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS HTML ;
ods select  ParameterEstimates ;
TITLE COLOR=RED "Model 1" BOLD COLOR=BLUE " - TIES = BRESLOW";
proc phreg data = sme_dummy  covsandwich(aggregate) ;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 
P1GDP Unemployment/ TIES= BRESLOW;
id  id_number;
run;
ods select  ParameterEstimates ;
TITLE COLOR=RED "Model 1" BOLD COLOR=BLUE " - TIES = DISCRETE";
proc phreg data = sme_dummy  covsandwich(aggregate) ;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 
P1GDP Unemployment/ TIES= DISCRETE;
id  id_number;
run;
ods select  ParameterEstimates ;
TITLE COLOR=RED "Model 1" BOLD COLOR=BLUE " - TIES = EFRON";
proc phreg data = sme_dummy  covsandwich(aggregate) ;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 
P1GDP Unemployment/ TIES= EFRON;
id  id_number;
run;
ods select  ParameterEstimates ;
TITLE COLOR=RED "Model 1" BOLD COLOR=BLUE " - TIES = EXACT";
proc phreg data = sme_dummy  covsandwich(aggregate) ;
ods output ParameterEstimates = para_est; 
model  (start,end)*default(0)= Segment_01 Segment_02 Segment_03 Segment_04 
P1GDP Unemployment/ TIES= EXACT;
id  id_number;
run;
TITLE;
ODS HTML CLOSE;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********  EOF ---   END OF FILE  ***********************/
/**********************************************************/
/**********************************************************/
/**********************************************************/


