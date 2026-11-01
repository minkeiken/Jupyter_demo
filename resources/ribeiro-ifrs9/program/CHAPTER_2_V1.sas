/**********************************************************/
/**********************************************************/
/**********************************************************/
/******   CHAPTER 2 - ECONOMETRIC DATA PREPARATION    *****/
/**********************************************************/
/**********************************************************/
/**********************************************************/

%LET FOLDER= 
;
LIBNAME CHAP_2  "&FOLDER";


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 1 - Page 14    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/


/***************************************/
/**********  1-Unemployment  ***********/
/***************************************/
DATA   Unemployment;
input  Year Month $ Unemployment;
LABEL Unemployment	 = "1-Unemployment Rate - UK - Updated on 27/08/2016";
datalines;
1999 JAN	6.2
1999 FEB	6.2
1999 MAR	6.2
1999 APR	6.1
1999 MAY	6.0
1999 JUN	6.0
1999 JUL	5.9
1999 AUG	5.9
1999 SEP	5.8
1999 OCT	5.8
1999 NOV	5.8
1999 DEC	5.9
2000 JAN	5.8
2000 FEB	5.8
2000 MAR	5.7
2000 APR	5.6
2000 MAY	5.5
2000 JUN	5.3
2000 JUL	5.3
2000 AUG	5.3
2000 SEP	5.4
2000 OCT	5.3
2000 NOV	5.2
2000 DEC	5.2
2001 JAN	5.2
2001 FEB	5.1
2001 MAR	5.0
2001 APR	4.9
2001 MAY	5.0
2001 JUN	5.0
2001 JUL	5.1
2001 AUG	5.1
2001 SEP	5.1
2001 OCT	5.1
2001 NOV	5.2
2001 DEC	5.2
2002 JAN	5.1
2002 FEB	5.2
2002 MAR	5.2
2002 APR	5.2
2002 MAY	5.2
2002 JUN	5.2
2002 JUL	5.2
2002 AUG	5.3
2002 SEP	5.2
2002 OCT	5.2
2002 NOV	5.1
2002 DEC	5.0
2003 JAN	5.1
2003 FEB	5.2
2003 MAR	5.1
2003 APR	5.0
2003 MAY	4.9
2003 JUN	5.1
2003 JUL	5.1
2003 AUG	5.0
2003 SEP	5.0
2003 OCT	4.9
2003 NOV	4.9
2003 DEC	4.8
2004 JAN	4.8
2004 FEB	4.8
2004 MAR	4.8
2004 APR	4.8
2004 MAY	4.8
2004 JUN	4.8
2004 JUL	4.7
2004 AUG	4.7
2004 SEP	4.7
2004 OCT	4.7
2004 NOV	4.7
2004 DEC	4.7
2005 JAN	4.8
2005 FEB	4.7
2005 MAR	4.7
2005 APR	4.8
2005 MAY	4.8
2005 JUN	4.7
2005 JUL	4.7
2005 AUG	4.7
2005 SEP	4.9
2005 OCT	5.1
2005 NOV	5.1
2005 DEC	5.1
2006 JAN	5.2
2006 FEB	5.2
2006 MAR	5.3
2006 APR	5.4
2006 MAY	5.5
2006 JUN	5.5
2006 JUL	5.5
2006 AUG	5.5
2006 SEP	5.5
2006 OCT	5.4
2006 NOV	5.5
2006 DEC	5.5
2007 JAN	5.5
2007 FEB	5.5
2007 MAR	5.5
2007 APR	5.4
2007 MAY	5.4
2007 JUN	5.3
2007 JUL	5.3
2007 AUG	5.3
2007 SEP	5.2
2007 OCT	5.2
2007 NOV	5.2
2007 DEC	5.2
2008 JAN	5.2
2008 FEB	5.2
2008 MAR	5.3
2008 APR	5.2
2008 MAY	5.4
2008 JUN	5.5
2008 JUL	5.7
2008 AUG	5.9
2008 SEP	6.0
2008 OCT	6.2
2008 NOV	6.4
2008 DEC	6.5
2009 JAN	6.7
2009 FEB	7.1
2009 MAR	7.3
2009 APR	7.6
2009 MAY	7.8
2009 JUN	7.9
2009 JUL	7.9
2009 AUG	7.8
2009 SEP	7.9
2009 OCT	7.8
2009 NOV	7.8
2009 DEC	7.7
2010 JAN	7.9
2010 FEB	8.0
2010 MAR	8.0
2010 APR	7.9
2010 MAY	7.9
2010 JUN	7.8
2010 JUL	7.8
2010 AUG	7.8
2010 SEP	7.9
2010 OCT	7.9
2010 NOV	7.9
2010 DEC	7.9
2011 JAN	7.8
2011 FEB	7.8
2011 MAR	7.7
2011 APR	7.8
2011 MAY	7.9
2011 JUN	8.0
2011 JUL	8.2
2011 AUG	8.3
2011 SEP	8.4
2011 OCT	8.5
2011 NOV	8.4
2011 DEC	8.3
2012 JAN	8.3
2012 FEB	8.2
2012 MAR	8.2
2012 APR	8.1
2012 MAY	8.0
2012 JUN	8.1
2012 JUL	7.9
2012 AUG	7.9
2012 SEP	7.9
2012 OCT	7.8
2012 NOV	7.8
2012 DEC	7.8
2013 JAN	8.0
2013 FEB	7.8
2013 MAR	7.8
2013 APR	7.8
2013 MAY	7.7
2013 JUN	7.7
2013 JUL	7.7
2013 AUG	7.6
2013 SEP	7.4
2013 OCT	7.2
2013 NOV	7.2
2013 DEC	7.2
2014 JAN	6.9
2014 FEB	6.8
2014 MAR	6.6
2014 APR	6.4
2014 MAY	6.3
2014 JUN	6.1
2014 JUL	6.0
2014 AUG	6.0
2014 SEP	6.0
2014 OCT	5.9
2014 NOV	5.7
2014 DEC	5.7
2015 JAN	5.6
2015 FEB	5.6
2015 MAR	5.5
2015 APR	5.6
2015 MAY	5.6
2015 JUN	5.5
2015 JUL	5.4
2015 AUG	5.3
2015 SEP	5.2
2015 OCT	5.1
2015 NOV	5.1
2015 DEC	5.1
2016 JAN	5.1
2016 FEB	5.1
2016 MAR	5.0
2016 APR	4.9
2016 MAY	4.9
;
run ;

DATA   Unemployment;
RETAIN Sasdate;
SET  Unemployment;
Sasdate=intnx('MONTH','01JAN1999'd,_n_- 1); 
FORMAT  Sasdate DATE9.; 
DROP MONTH YEAR ;
RUN;

/***************************************/
/**   2-Consumer Prices Inflation    ***/
/***************************************/
/*CPI: Consumer Prices Inflation (% change) */

DATA   Inflation;
input  Year Month $ Inflation;
LABEL Inflation	 = "2-CPI: Consumer Prices index - Inflation (% change) - UK - Updated on 27/08/2016";
datalines;
1999 JAN	1.6
1999 FEB	1.4
1999 MAR	1.7
1999 APR	1.5
1999 MAY	1.3
1999 JUN	1.3
1999 JUL	1.3
1999 AUG	1.2
1999 SEP	1.2
1999 OCT	1.1
1999 NOV	1.2
1999 DEC	1.1
2000 JAN	0.8
2000 FEB	0.9
2000 MAR	0.6
2000 APR	0.6
2000 MAY	0.5
2000 JUN	0.8
2000 JUL	0.9
2000 AUG	0.6
2000 SEP	1.0
2000 OCT	1.0
2000 NOV	1.1
2000 DEC	0.8
2001 JAN	0.9
2001 FEB	0.8
2001 MAR	0.9
2001 APR	1.2
2001 MAY	1.7
2001 JUN	1.7
2001 JUL	1.4
2001 AUG	1.8
2001 SEP	1.3
2001 OCT	1.2
2001 NOV	0.8
2001 DEC	1.1
2002 JAN	1.6
2002 FEB	1.5
2002 MAR	1.5
2002 APR	1.4
2002 MAY	0.8
2002 JUN	0.6
2002 JUL	1.1
2002 AUG	1.0
2002 SEP	1.0
2002 OCT	1.4
2002 NOV	1.5
2002 DEC	1.7
2003 JAN	1.3
2003 FEB	1.6
2003 MAR	1.5
2003 APR	1.4
2003 MAY	1.3
2003 JUN	1.1
2003 JUL	1.3
2003 AUG	1.4
2003 SEP	1.4
2003 OCT	1.4
2003 NOV	1.3
2003 DEC	1.3
2004 JAN	1.4
2004 FEB	1.3
2004 MAR	1.1
2004 APR	1.1
2004 MAY	1.5
2004 JUN	1.6
2004 JUL	1.4
2004 AUG	1.3
2004 SEP	1.1
2004 OCT	1.2
2004 NOV	1.5
2004 DEC	1.7
2005 JAN	1.6
2005 FEB	1.7
2005 MAR	1.9
2005 APR	1.9
2005 MAY	1.9
2005 JUN	2.0
2005 JUL	2.3
2005 AUG	2.4
2005 SEP	2.5
2005 OCT	2.3
2005 NOV	2.1
2005 DEC	1.9
2006 JAN	1.9
2006 FEB	2.0
2006 MAR	1.8
2006 APR	2.0
2006 MAY	2.2
2006 JUN	2.5
2006 JUL	2.4
2006 AUG	2.5
2006 SEP	2.4
2006 OCT	2.4
2006 NOV	2.7
2006 DEC	3.0
2007 JAN	2.7
2007 FEB	2.8
2007 MAR	3.1
2007 APR	2.8
2007 MAY	2.5
2007 JUN	2.4
2007 JUL	1.9
2007 AUG	1.8
2007 SEP	1.8
2007 OCT	2.1
2007 NOV	2.1
2007 DEC	2.1
2008 JAN	2.2
2008 FEB	2.5
2008 MAR	2.5
2008 APR	3.0
2008 MAY	3.3
2008 JUN	3.8
2008 JUL	4.4
2008 AUG	4.7
2008 SEP	5.2
2008 OCT	4.5
2008 NOV	4.1
2008 DEC	3.1
2009 JAN	3.0
2009 FEB	3.2
2009 MAR	2.9
2009 APR	2.3
2009 MAY	2.2
2009 JUN	1.8
2009 JUL	1.8
2009 AUG	1.6
2009 SEP	1.1
2009 OCT	1.5
2009 NOV	1.9
2009 DEC	2.9
2010 JAN	3.5
2010 FEB	3.0
2010 MAR	3.4
2010 APR	3.7
2010 MAY	3.4
2010 JUN	3.2
2010 JUL	3.1
2010 AUG	3.1
2010 SEP	3.1
2010 OCT	3.2
2010 NOV	3.3
2010 DEC	3.7
2011 JAN	4.0
2011 FEB	4.4
2011 MAR	4.0
2011 APR	4.5
2011 MAY	4.5
2011 JUN	4.2
2011 JUL	4.4
2011 AUG	4.5
2011 SEP	5.2
2011 OCT	5.0
2011 NOV	4.8
2011 DEC	4.2
2012 JAN	3.6
2012 FEB	3.4
2012 MAR	3.5
2012 APR	3.0
2012 MAY	2.8
2012 JUN	2.4
2012 JUL	2.6
2012 AUG	2.5
2012 SEP	2.2
2012 OCT	2.7
2012 NOV	2.7
2012 DEC	2.7
2013 JAN	2.7
2013 FEB	2.8
2013 MAR	2.8
2013 APR	2.4
2013 MAY	2.7
2013 JUN	2.9
2013 JUL	2.8
2013 AUG	2.7
2013 SEP	2.7
2013 OCT	2.2
2013 NOV	2.1
2013 DEC	2
2014 JAN	1.9
2014 FEB	1.7
2014 MAR	1.6
2014 APR	1.8
2014 MAY	1.5
2014 JUN	1.9
2014 JUL	1.6
2014 AUG	1.5
2014 SEP	1.2
2014 OCT	1.3
2014 NOV	1
2014 DEC	0.5
2015 JAN	0.3
2015 FEB	0
2015 MAR	0
2015 APR	-0.1
2015 MAY	0.1
2015 JUN	0
2015 JUL	0.1
2015 AUG	0
2015 SEP	-0.1
2015 OCT	-0.1
2015 NOV	0.1
2015 DEC	0.2
2016 JAN	0.3
2016 FEB	0.3
2016 MAR	0.5
2016 APR	0.3
2016 MAY	0.3
2016 JUN	0.5
2016 JUL	0.6
;
RUN;

DATA   Inflation;
RETAIN Sasdate;
SET  Inflation;
Sasdate=intnx('MONTH','01JAN1999'd,_n_- 1); 
FORMAT  Sasdate DATE9.; 
DROP MONTH YEAR ;
RUN;

/***************************************/
/**   2-HOUSE PRICE INDEX             **/
/***************************************/
/* http://www.nationwide.co.uk/about/house-price-index/download-data#xtab:uk-series */


DATA   Houseprice;
input   date ddmmyy10. Houseprice;
label   Houseprice	 = "3-House Price Index - UK - Updated on 27/08/2016";
format  date ddmmyy10.; 
datalines;
01/01/1999	66384.92
01/02/1999	67021.05
01/03/1999	68308.08
01/04/1999	68856.13
01/05/1999	69932.91
01/06/1999	70789.07
01/07/1999	71232.00
01/08/1999	72634.72
01/09/1999	73232.46
01/10/1999	73768.89
01/11/1999	74954.05
01/12/1999	75218.66
01/01/2000	75060.42
01/02/2000	77071.74
01/03/2000	79392.50
01/04/2000	80892.76
01/05/2000	81005.78
01/06/2000	81451.93
01/07/2000	81133.02
01/08/2000	80736.64
01/09/2000	80672.49
01/10/2000	81036.37
01/11/2000	81769.72
01/12/2000	82188.42
01/01/2001	83449.87
01/02/2001	83313.62
01/03/2001	85076.55
01/04/2001	86243.55
01/05/2001	87266.61
01/06/2001	89067.57
01/07/2001	89961.60
01/08/2001	90361.07
01/09/2001	92432.44
01/10/2001	91652.79
01/11/2001	92261.67
01/12/2001	93544.48
01/01/2002	93231.24
01/02/2002	94964.63
01/03/2002	96792.37
01/04/2002	100472.60
01/05/2002	102885.56
01/06/2002	106692.77
01/07/2002	108818.43
01/08/2002	110890.16
01/09/2002	112918.52
01/10/2002	113665.00
01/11/2002	115760.80
01/12/2002	117205.78
01/01/2003	117905.37
01/02/2003	118521.47
01/03/2003	122179.55
01/04/2003	122747.93
01/05/2003	124751.70
01/06/2003	127214.50
01/07/2003	128251.26
01/08/2003	129257.65
01/09/2003	130473.42
01/10/2003	131947.34
01/11/2003	133387.67
01/12/2003	135443.57
01/01/2004	134805.73
01/02/2004	138729.56
01/03/2004	142584.26
01/04/2004	145917.92
01/05/2004	149019.88
01/06/2004	151523.86
01/07/2004	154298.53
01/08/2004	153742.53
01/09/2004	153726.76
01/10/2004	152159.15
01/11/2004	153438.59
01/12/2004	152622.73
01/01/2005	151757.17
01/02/2005	152878.94
01/03/2005	153876.17
01/04/2005	156128.03
01/05/2005	157272.25
01/06/2005	157790.99
01/07/2005	158347.70
01/08/2005	157309.75
01/09/2005	156516.54
01/10/2005	157107.35
01/11/2005	157138.89
01/12/2005	157249.76
01/01/2006	158477.77
01/02/2006	158572.97
01/03/2006	162082.50
01/04/2006	163573.28
01/05/2006	164632.29
01/06/2006	165729.91
01/07/2006	167732.73
01/08/2006	167721.48
01/09/2006	169412.67
01/10/2006	169623.49
01/11/2006	172184.85
01/12/2006	173745.94
01/01/2007	173224.53
01/02/2007	174705.53
01/03/2007	177082.55
01/04/2007	180314.17
01/05/2007	181584.50
01/06/2007	184070.22
01/07/2007	184269.86
01/08/2007	183898.45
01/09/2007	184723.33
01/10/2007	186043.58
01/11/2007	184098.57
01/12/2007	182079.51
01/01/2008	180473.15
01/02/2008	179358.05
01/03/2008	179110.14
01/04/2008	178554.76
01/05/2008	173583.06
01/06/2008	172415.02
01/07/2008	169316.48
01/08/2008	164653.94
01/09/2008	161797.39
01/10/2008	158872.29
01/11/2008	158442.08
01/12/2008	153047.58
01/01/2009	150500.86
01/02/2009	147745.53
01/03/2009	150946.11
01/04/2009	151860.78
01/05/2009	154015.63
01/06/2009	156441.91
01/07/2009	158870.54
01/08/2009	160223.90
01/09/2009	161815.92
01/10/2009	162038.08
01/11/2009	162764.20
01/12/2009	162102.97
01/01/2010	163480.80
01/02/2010	161319.63
01/03/2010	164518.67
01/04/2010	167801.97
01/05/2010	169162.08
01/06/2010	170110.78
01/07/2010	169346.95
01/08/2010	166507.23
01/09/2010	166756.82
01/10/2010	164278.88
01/11/2010	163132.67
01/12/2010	162248.85
01/01/2011	161211.08
01/02/2011	161182.66
01/03/2011	164750.90
01/04/2011	165609.02
01/05/2011	167208.25
01/06/2011	168205.26
01/07/2011	168730.56
01/08/2011	165914.21
01/09/2011	166255.55
01/10/2011	165650.32
01/11/2011	165797.99
01/12/2011	163821.83
01/01/2012	162228.25
01/02/2012	162712.35
01/03/2012	163327.22
01/04/2012	164134.29
01/05/2012	166021.53
01/06/2012	165738.11
01/07/2012	164389.40
01/08/2012	164728.77
01/09/2012	163963.50
01/10/2012	164153.36
01/11/2012	163852.74
01/12/2012	162262.19
01/01/2013	162245.25
01/02/2013	162637.55
01/03/2013	164630.41
01/04/2013	165586.08
01/05/2013	167911.57
01/06/2013	168940.66
01/07/2013	170825.45
01/08/2013	170513.95
01/09/2013	172126.76
01/10/2013	173677.94
01/11/2013	174566.48
01/12/2013	175825.60
01/01/2014	176491.00
01/02/2014	177845.97
01/03/2014	180264.31
01/04/2014	183576.51
01/05/2014	186511.61
01/06/2014	188902.94
01/07/2014	188948.55
01/08/2014	189305.83
01/09/2014	188374.45
01/10/2014	189333.24
01/11/2014	189387.81
01/12/2014	188558.57
01/01/2015	188445.79
01/02/2015	187963.55
01/03/2015	189453.68
01/04/2015	193048.40
01/05/2015	195166.06
01/06/2015	195055.29
01/07/2015	195621.34
01/08/2015	195279.06
01/09/2015	195585.01
01/10/2015	196807.13
01/11/2015	196305.11
01/12/2015	196999.27
01/01/2016	196828.54
01/02/2016	196929.74
01/03/2016	200250.96
01/04/2016	202435.78
01/05/2016	204367.87
01/06/2016	204967.70
01/07/2016	205715.26
;
run ;

DATA   Houseprice;
RETAIN Sasdate;
SET    Houseprice;
Sasdate=intnx('MONTH','01JAN1999'd,_n_- 1); 
FORMAT  Sasdate DATE9.; 
DROP DATE ;
RUN;




/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 2 - Page 15    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc sort data=Unemployment; 
by Sasdate;
run ;
proc sort data=inflation;
by Sasdate;
run ;
proc sort data=houseprice;
by Sasdate;
run ;

data  Economic_month_1;
merge Unemployment Inflation Houseprice;
BY    Sasdate;
run;

PROC DELETE DATA = Unemployment Inflation Houseprice;
RUN ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 3 - Page 16    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc expand data   = Economic_month_1       
            out    = Economic_month_lag         
            method = NONE ; 
convert Unemployment; 
convert Unemployment = Lag_3_Unemployment   / transformout=(lag 3 );  
convert Unemployment = Lag_6_Unemployment   / transformout=(lag 6 ); 
convert Unemployment = Lag_9_Unemployment   / transformout=(lag 9 );    
ID SASDATE ;  
FORMAT SASDATE DATE9.;                     
run;

PROC DELETE DATA= Economic_month_lag ;
RUN ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 4 - Page 17    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS GRAPHICS ON;
proc expand data   = Economic_month_1         
            out    = Economic_month_LOG_LAG       
            method = NONE 
            plots  = (INPUT TRANSFORMOUT ) ; 
convert Houseprice ;
convert Houseprice = Lag_3_Houseprice     / transformout=(lag 3 );
convert Houseprice = Log_Houseprice       / transformout=(log);
convert Houseprice = Log_LAG_3_Houseprice / transformin=(log)   transformout=(lag 3) ;
ID SASDATE ;  
FORMAT SASDATE DATE9.;                   
run;

PROC DELETE DATA= Economic_month_LOG_LAG ;
RUN ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 5 - Page 19    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc expand data   = Economic_month_1         
            out    = Economic_month_2       
            method = NONE; 
convert Unemployment;
convert Unemployment = Lag_3_Unemployment / transformout=( lag 3 );
convert Unemployment = Lag_6_Unemployment / transformout=( lag 6 );
convert Unemployment = Lag_9_Unemployment / transformout=( lag 9 );

convert Inflation;
convert Inflation    = Lag_3_Inflation    / transformout=( lag 3 );
convert Inflation    = Lag_6_Inflation    / transformout=( lag 6 );
convert Inflation    = Lag_9_Inflation    / transformout=( lag 9 );

convert Houseprice;
convert Houseprice   = Lag_3_Houseprice   / transformout=( lag 3 );
convert Houseprice   = Lag_6_Houseprice   / transformout=( lag 6 );
convert Houseprice   = Lag_9_Houseprice   / transformout=( lag 9 );
ID      SASDATE ;  
FORMAT  SASDATE DATE9.;                   
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 2 - Page 20    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

option label;
data   GDP_quarter_1;
input  Year Quarter $ GDP;
LABEL GDP	 = "4-GDP-Gross Domestic Product - UK: Chained Volume Measures: Seasonally Adjusted - Updated on 27/08/2016";
datalines;
1999 Q1	337294
1999 Q2	337547
1999 Q3	343693
1999 Q4	348449
2000 Q1	351979
2000 Q2	354546
2000 Q3	355557
2000 Q4	356094
2001 Q1	360749
2001 Q2	363235
2001 Q3	365696
2001 Q4	367157
2002 Q1	368690
2002 Q2	371397
2002 Q3	374205
2002 Q4	377469
2003 Q1	380565
2003 Q2	384014
2003 Q3	387841
2003 Q4	391048
2004 Q1	393247
2004 Q2	395113
2004 Q3	395867
2004 Q4	398259
2005 Q1	400558
2005 Q2	404875
2005 Q3	409270
2005 Q4	414816
2006 Q1	416183
2006 Q2	417146
2006 Q3	417741
2006 Q4	419236
2007 Q1	423472
2007 Q2	426600
2007 Q3	429845
2007 Q4	433079
2008 Q1	433710
2008 Q2	430887
2008 Q3	423618
2008 Q4	414037
2009 Q1	407291
2009 Q2	406353
2009 Q3	406641
2009 Q4	408298
2010 Q1	410542
2010 Q2	414699
2010 Q3	417024
2010 Q4	417507
2011 Q1	419828
2011 Q2	420109
2011 Q3	421918
2011 Q4	422965
2012 Q1	424834
2012 Q2	424468
2012 Q3	429319
2012 Q4	428321
2013 Q1	431025
2013 Q2	433271
2013 Q3	436560
2013 Q4	438707
2014 Q1	442425
2014 Q2	446519
2014 Q3	450141
2014 Q4	453891
2015 Q1	455086
2015 Q2	457002
2015 Q3	459006
2015 Q4	462139
2016 Q1	464212
2016 Q2	466944
;
run ;

DATA GDP_quarter_1;
RETAIN Sasdate;
SET  GDP_quarter_1;
Sasdate=intnx('QUARTER','01JAN1999'd,_n_- 1); 
FORMAT  Sasdate YYQ6.; 
DROP Year Quarter ;
RUN;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 7 - Page 20    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc expand data   = GDP_quarter_1                
            out    = GDP_month           
			method = spline             
			from   = quarter             
            to     = month PLOTS=ALL ;         
convert     GDP  / observed=average  ;
id sasdate ;  
FORMAT sasdate DATE9.;                   
run;

DATA  Economic_month;
MERGE Economic_month_1   GDP_month;
BY    sasdate;
RUN;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 8 - Page 23    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

ODS graphics on;
proc expand data   = GDP_quarter_1         
            out    = GDP_quarter_2       
			method = none   
            plots  = (INPUT TRANSFORMOUT ) ; 
convert GDP ;
convert GDP = PGDP / transformout=( pctdif 4);
id Sasdate; 
LABEL PGDP	 = "4-PGDP-Percentange Change - Prior Quarter is the Base - Updated on 27/08/2016"; 
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 9 - Page 25    *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data GDP_quarter_2 ;
set  GDP_quarter_2 ;

PGDP_SAS_CODE  = ( (GDP - LAG4(GDP))/ LAG4(GDP)) *100; 
LABEL  PGDP_SAS_CODE =  "4-PGDP-Percentange Change - Prior Quarter year is the Base - Updated on 27/08/2016";

Error = ABS (PGDP_SAS_CODE  - PGDP);
Format Error 5.2; 
run ;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 10 - Page 25   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

PROC EXPAND data   = GDP_quarter_1         
            out    = GDP_quarter_2       
			method = none; 
convert GDP;
convert GDP = PGDP / transformout=(pctdif 4);
id sasdate; 
LABEL PGDP  = "4-PGDP-Percentage Change - Prior Quarter is the Base - Updated on 27/08/2016"; 
RUN;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 11 - Page 26   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

PROC EXPAND data   = GDP_quarter_2
            out    = GDP_month_1
 	        method = spline
			from   = quarter
            to     = month;
convert     GDP = GDP / observed = average;
convert     PGDP      / observed = average;
id SASDATE;
FORMAT SASDATE DATE9.; 
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 12 - Page 26   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/
proc expand data   = GDP_month_1             
            out    = GDP_month_2 
 	        method = NONE;   
convert GDP;
convert GDP = Lag_3_GDP / transformout = (lag 3 );
convert GDP = Lag_6_GDP / transformout = (lag 6 );
convert GDP = Lag_9_GDP / transformout = (lag 9 );
id SASDATE;  
FORMAT SASDATE DATE9.; 
run;
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 13 - Page 27   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

data  Economic_month;
merge Economic_month_2 GDP_month_2;
BY    sasdate;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 14 - Page 29   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc sort data = internal out = sorted_internal ;
by   id _t_;
run;

proc sort data = bureau  out = sorted_bureau   ;
by   id _t_;
run;

data  internal_bureau;
merge sorted_internal sorted_bureau;
by    id _t_;
run ;


/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 15 - Page 29   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

proc sort data = internal_bureau OUT = Sorted_internal_bureau ;
by   sasdate;
run;

proc sort data = economic_month OUT = Sorted_economic_month;
by   sasdate;
run;

data  mortage_model_1;
merge Sorted_internal_bureau(in=A) Sorted_economic_month(IN=B);
BY    SASDATE;
IF    A=B;
run;

proc sort data = mortage_model_1 ;
by   id _t_;
run;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********    Chapter 2 - Program 16 - Page 30   *********/
/**********************************************************/
/**********************************************************/
/**********************************************************/

PROC DATASETS LIB=WORK NOLIST;
modify mortage_model_1;

LABEL ID                 = "0-Customer Id";   

LABEL Start              = "1-Survival - Time Id"; 
LABEL End                = "1-Survival - Time Id";
LABEL Censor             = "1-Survival - Censor - Target" ;

LABEL _t_                = "2-Input - Required Longitudinal Time";

LABEL Vintage            = "2-Input - Internal Customer Information - Vintage";
LABEL Scorecard          = "2-Input - Internal Customer Information - Scorecard";
LABEL Balance            = "2-Input - Internal Customer Information - Actual Outstanding Balance";
LABEL Payment            = "2-Input - Internal Customer Information - Contractual Monthly Payment";
LABEL LTV                = "2-Input - Internal Customer Information - Loan to Value" ;

LABEL WOE_1              = "3-Input - Bureau Data - WOE_1";
LABEL WOE_2              = "3-Input - Bureau Data - WOE_2";
LABEL WOE_3              = "3-Input - Bureau Data - WOE_3";
LABEL WOE_4              = "3-Input - Bureau Data - WOE_4";

LABEL Sasdate            = "4-Rejected - Sasdate - Time ID" ;  

LABEL       Unemployment = "5-Input - Economic - 1-Unemployment Rate - UK - Updated on 27/08/2016";
LABEL Lag_3_Unemployment = "5-Input - Economic - 1-Unemployment Rate - UK - Updated on 27/08/2016";
LABEL Lag_6_Unemployment = "5-Input - Economic - 1-Unemployment Rate - UK - Updated on 27/08/2016";
LABEL Lag_9_Unemployment = "5-Input - Economic - 1-Unemployment Rate - UK - Updated on 27/08/2016";

LABEL Houseprice         = "5-Input - Economic - 3-House Price Index - UK - Updated on 27/08/2016";
LABEL Lag_3_Houseprice   = "5-Input - Economic - 3-House Price Index - UK - Updated on 27/08/2016";
LABEL Lag_6_Houseprice   = "5-Input - Economic - 3-House Price Index - UK - Updated on 27/08/2016";
LABEL Lag_9_Houseprice   = "5-Input - Economic - 3-House Price Index - UK - Updated on 27/08/2016";

LABEL Inflation          = "5-Input - Economic - 2-CPI: Consumer Prices Index - Inflation (% change) - UK - Updated on 27/08/2016";
LABEL Lag_3_Inflation    = "5-Input - Economic - 2-CPI: Consumer Prices Index - Inflation (% change) - UK - Updated on 27/08/2016";
LABEL Lag_6_Inflation    = "5-Input - Economic - 2-CPI: Consumer Prices Index - Inflation (% change) - UK - Updated on 27/08/2016";
LABEL Lag_9_Inflation    = "5-Input - Economic - 2-CPI: Consumer Prices Index - Inflation (% change) - UK - Updated on 27/08/2016";

LABEL GDP                = "5-Input - Economic - 4-GDP-Gross Domestic Product - UK: Chained Volume Measures: Seasonally Adjusted - Updated on 27/08/2016" ;
LABEL Lag_3_GDP          = "5-Input - Economic - 4-GDP-Gross Domestic Product - UK: Chained Volume Measures: Seasonally Adjusted - Updated on 27/08/2016" ;
LABEL Lag_6_GDP          = "5-Input - Economic - 4-GDP-Gross Domestic Product - UK: Chained Volume Measures: Seasonally Adjusted - Updated on 27/08/2016" ;
LABEL Lag_9_GDP          = "5-Input - Economic - 4-GDP-Gross Domestic Product - UK: Chained Volume Measures: Seasonally Adjusted - Updated on 27/08/2016" ;
LABEL PGDP               = "5-Input - Economic - 4-PGDP-Percentange Change - Prior Quarter is the Base - Updated on 27/08/2016";
run;
quit;


DATA  mortage_model_1;
RETAIN ID    Start              End                Censor             _t_  
Vintage      Scorecard          Balance            Payment            LTV 
Sasdate      WOE_1              WOE_2              WOE_3              WOE_4 
Unemployment Lag_3_Unemployment Lag_6_Unemployment Lag_9_Unemployment 
Inflation    Lag_3_Inflation    Lag_6_Inflation    Lag_9_Inflation 
Houseprice   Lag_3_Houseprice   Lag_6_Houseprice   Lag_9_Houseprice 
GDP          Lag_3_GDP          Lag_6_GDP          Lag_9_GDP          PGDP ;
SET   mortage_model_1;
run;

PROC DATASETS LIBRARY=WORK NOLIST DETAILS KILL;
RUN;
QUIT;

/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********  EOF ---   END OF FILE  ***********************/
/**********************************************************/
/**********************************************************/
/**********************************************************/


