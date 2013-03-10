/*
 * Student ID:   D10126532
 * Student Name: John Warde
 * Course Code:  DT230B
 *
 */

/* 
	Define library location 
*/
LIBNAME atlib "C:\SASData\johnwarde\SASAssignment";

/*
	From: http://marc.info/?l=sas-l&m=116624822680111&w=2
*/
proc format library=atlib;
  picture mony4d /* FEB-2003 */ low-high='%b-%Y' (datatype=date);
run;


/* 
    Import Customer Billing Records data
*/
data atlib.bills (replace=yes compress=yes);
    infile 'U:\ProgrammingForBigData\SasAssignment\bills.csv' dlm=',' dsd firstobs=2;
    informat date MONYY7.;
    input 
        ID               /* Numeric  Customer ID */
        date $           /* Numeric  The date of the bill (MMM-yyyy) */
        recurringCharge  /* Numeric  The recurring bundle charge this month */
        callCharges      /* Numeric  The call charges for this month */
        totalBill        /* Numeric  The total bill amount for this month */
        minutes          /* Numeric  The number of minutes used this month */
        overageMins      /* Numeric  The number of minutes over the customer's bundle used this month */
    ;
    format date MMYYD8.;
    *format date mony4d.;
run;


proc print data=atlib.bills;
	title "Bills raw data";
run;

/* 
   Import Customer Call Records data 
*/
data atlib.calls (replace=yes compress=yes);
    infile 'U:\ProgrammingForBigData\SasAssignment\calls.csv' dlm=',' dsd firstobs=2;
    informat callDate datetime. length 10.20;
    input 
        customerID          /* Numeric  customerID */
        callDate $          /* Numeric  The date and time of the call */
        length              /* Numeric  The length of the call in minutes */
        number              /* Numeric  The number called */
        outcome $           /* Numeric  The outcome of the call {blocked, unanswered, complete, dropped} */
        roaming $           /* Numeric  Was this call a roaming {true, false} */
        directorAssisted $  /* Numeric  Was this a directory assisted call {true, false} */
        peakOrOffPeak $     /* Numeric  Was this call on peak {true, false} */
    ;
    format callDate e8601dt.;
run;

/* 
   Print Customer Call Records data 
*/
proc print data=atlib.calls;
	title "Calls raw data";
run;


/*
    Import Call Summaries Data
*/
data atlib.callSummaries (replace=yes compress=yes);
    infile 'U:\ProgrammingForBigData\SasAssignment\callSummaries.csv' dlm=',' dsd firstobs=2;
    informat recordDate MONYY7.;
    input 
        customer           /* Numeric  Customer ID */
        recordDate $       /* Numeric  The date of the bill (MMM-yyyy) */
        callsDropped       /* Numeric  The number of calls dropped in this period */
        callsBlocked       /* Numeric  The number of blocked calls in the billing period */
        callsUnanswered    /* Numeric  The number of unanswered calls made in this period */
        callsCustCare      /* Numeric  The number of calls made to customer care in this period */
        callsDirectAssist  /* Numeric  The number of directory assisted calls made in this period */
        callsRoam          /* Numeric  The number of roaming calls made in this period */
        callsPeak          /* Numeric  The total number of peak calls made in this period */
        callsOffPeak       /* Numeric  The total number of off peak calls made in this period */
        callsTotal         /* Numeric  The total number of calls made in this period */
        totalMinutes       /* Numeric  The total number of minutes used in this period */
    ;
    format recordDate MMYYD8.;
run;

/*
    Print Call Summaries Data
*/
proc print data=atlib.callSummaries;
	title "Call Summaries raw data";
run;


/*
    Import Customer Demographics
*/
data atlib.demographics (replace=yes compress=yes);
    infile 'U:\ProgrammingForBigData\SasAssignment\demographics.csv' dlm=',' dsd firstobs=2;
    length occupation $ 14;
    length serviceArea $ 14;
    input 
        customer            /* Numeric      The customer number */
        age                 /* Numeric      The customer's age */
        occupation $        /* Categorical  The occupation of the customer {clerical, crafts, homemaker, professional, retired, self-­-employed, student} */
        serviceArea $       /* Categorical  The cell-­-phone service area in which the customer lives */
        regionType $        /* Categorical  The type of region in which the customer lives {rural, suburban, town} */
        marital $           /* Categorical  The customer's marital status {yes, no, unknown} */
        children $          /* Categorical  There are children present in the customer's household {true, false} */
        income              /* Numeric      The customer's income {0 -­- 9} */
        months              /* Numeric      The number of months the customer has been in service */
        numPhones           /* Numeric      The number of phones the customer has owned */
        numModels           /* Numeric      The number of different phone models the customer has owned */
        currentEquipDays    /* Numeric      The number of days that the customer has owned their current handset */
        WebCapable $        /* Categorical  The customer's handset is web capable {true, false} */
        handsetPrice        /* Numeric      The price paid for the customer's handset */
        creditRating $      /* Categorical  The customers credit rating {a, aa, b, c, de, gy, z} */
        creditAdjust        /* Numeric      The number of times the customer's credit rating has been adjusted (either up or down) since they became a customer */
        truck $             /* Categorical  The customer owns a truck */
        rv $                /* Categorical  The customer owns a recreational vehicle {true, false} */
        motorcycle $        /* Categorical  The customer owns a motorcycle {true, false} */
        pc $                /* Categorical  The customer owns a personal computer {true, false} */
        ownHome $           /* Categorical  The customer owns their own home {true, false} */
        mailOrder $         /* Categorical  The customer buys via mail order {true, false} */
        mailResponder $     /* Categorical  The customer responds to mail offers {true, false} */
        mailFlag $          /* Categorical  The customer has chosen not to be solicited by mail {true, false} */
        travel $            /* Categorical  The customer has travelled internationally {true, false} */
        creditCard $        /* Categorical  The customer owns a credit card {true, false} */
        newCellUser $       /* Categorical  The customer is a known new cell phone user {yes, no, unknown} */
        numReferrals        /* Numeric      The number of referrals made by the customer */
    ;
	/* Correct some of the incoming data values for consistency */
	if serviceArea = "0" 	then serviceArea = ' ';

    if truck = 't' 			then truck = 'true';
    if truck = 'f' 			then truck = 'false';
    if rv = 't' 			then rv = 'true';
    if rv = 'f' 			then rv = 'false';
    if motorcycle = 't' 	then motorcycle = 'true';
    if motorcycle = 'f' 	then motorcycle = 'false';
    if pc = 't' 			then pc = 'true';
    if pc = 'f' 			then pc = 'false';
    if ownHome = 't' 		then ownHome = 'true';
    if ownHome = 'f' 		then ownHome = 'false';
    if mailOrder = 't' 		then mailOrder = 'true';
    if mailOrder = 'f' 		then mailOrder = 'false';
    if mailResponder = 't' 	then mailResponder = 'true';
    if mailResponder = 'f' 	then mailResponder = 'false';
    if mailFlag = 't' 		then mailFlag = 'true';
    if mailFlag = 'f' 		then mailFlag = 'false';
    if travel = 't' 		then travel = 'true';
    if travel = 'f' 		then travel = 'false';
	if creditCard = 't' 	then creditCard = 'true';
	if creditCard = 'f' 	then creditCard = 'false';
	if creditCard = 'yes' 	then creditCard = 'true';
	if creditCard = 'no' 	then creditCard = 'false';

	if regionType = 'r' 		then regionType = 'rural';
	if regionType = 's' 		then regionType = 'suburban';
	if regionType = 't' 		then regionType = 'town';
	if regionType = 'unknown' 	then regionType=' ';
run;

/*
    Print Demographics Data
*/
proc print data=atlib.demographics;
	title "Demographics raw data";
run;

/*
    Sort Demographics Data by ID then by date
*/
proc sort data=atlib.bills tagsort;
    by ID date;
run;


/*
	Aggregregate data in the bills dataset
*/
data bills_aggregate;
    set atlib.bills;
    by ID;
    keep
        ID                  /* customer ID */
        overage             /* Mean out of bundle minutes of use */
        overageMax          /* Max out of bundle minutes of use */
        overageMin          /* Min out of bundle minutes of use */
        recchrge            /* Mean total recurring charge */
        revenue             /* Mean monthly revenue */
        revenueTotal        /* The total revenue earned from this customer */
        revenueChange       /* % change in revenues in last two months */
    ;
    
    retain bill_counter 0;

    retain out_of_bundle_minutes_total 0;
    retain recurring_charge_total 0;
    retain overageMax 0;
    retain overageMin 999999;
    retain revenueTotal 0;
    
    if first.ID then 
    do;
        bill_counter = 0;   
        out_of_bundle_minutes_total = 0;
        recurring_charge_total = 0;
        overageMax = 0; 
        overageMin = 999999;    
        revenueTotal = 0;   
    end;
    bill_counter = bill_counter + 1;
    out_of_bundle_minutes_total = sum(out_of_bundle_minutes_total, overageMins);
    recurring_charge_total = sum(recurring_charge_total, recurringCharge);
    overageMax = max(overageMax, overageMins);
    overageMin = min(overageMin, overageMins);
    revenueTotal = sum(revenueTotal, totalBill);
    if last.ID then
    do;
	    overage = divide(out_of_bundle_minutes_total, bill_counter);
        recchrge = divide(recurring_charge_total, bill_counter);
        revenue = divide(revenueTotal, bill_counter);
        last_bill_total = lag1(totalBill);
		revenueChange = divide(dif1(totalBill), last_bill_total); 
        output;
    end;
run;

/*
    Sort Demographics Data by ID then by date
*/
proc sort data=atlib.callSummaries tagsort;
    by customer recordDate;
run;


/*
	Aggregregate data in the callSummaries dataset
*/
data callSummaries_aggregate;
    set atlib.callSummaries;
    by customer;
    keep
        customer            /* Customer ID */
        custcare            /* Mean number of customer care calls per month */
        custcareTotal       /* The total number of customer care calls made */
        custcareLast        /* The number of customer care calls made last month */
        directas            /* Mean number of directory assisted calls per month */
        directasLast        /* Number of director assisted calls last month */
        dropvce             /* Mean number of dropped voice calls per month */
        dropvceLast         /* Number of dropped voice calls last month */
        mou                 /* Mean monthly minutes of use */
        mouTotal            /* Total minutes of use */
        mouChange           /* % change in minutes of use in last two months */
        outcalls            /* Mean number of outbound voice calls per month */
        peakOffPeak         /* Ratio of peak to off-peak calls */
        peakOffPeakLast     /* Ratio of peak to off-peak calls last month */
        roam                /* Mean number of roaming calls per month */
    ;
    
    retain bill_counter 0;

    retain custcareTotal 0;
    retain directasTotal 0;
    retain dropvceTotal 0;
    retain revenueTotal 0;
    retain mouTotal 0;
    retain callsOffPeakTotal 0;
    retain callsPeakTotal 0;
    retain outcallsTotal 0;
    retain roamTotal 0;
    
    if first.customer then 
    do;
        bill_counter = 0;   
        custcareTotal = 0;
        directasTotal = 0;
        dropvceTotal = 0; 
        mouTotal = 0; 
        callsOffPeakTotal = 0;
        callsPeakTotal = 0;
        outcallsTotal = 0;
        roamTotal = 0; 
    end;
    bill_counter = bill_counter + 1;
    custcareTotal = sum(custcareTotal, callsCustCare);
    directasTotal = sum(directasTotal, callsDirectAssist);
    dropvceTotal = sum(dropvceTotal, callsDropped);
    mouTotal = sum(mouTotal, totalMinutes);
    callsOffPeakTotal = sum(callsOffPeakTotal, callsOffPeak);
    callsPeakTotal = sum(callsPeakTotal, callsOffPeak);
    outcallsTotal = sum(outcallsTotal, callsTotal);
    roamTotal = sum(roamTotal, callsRoam);

    if last.customer then
    do;
        custcare = divide(custcareTotal, bill_counter);
        custcareLast = custcareTotal;
        directas = divide(directasTotal, bill_counter);
        directasLast = callsDirectAssist;
        dropvce = divide(dropvceTotal, bill_counter);
        dropvceLast = callsDropped;
        mou = divide(mouTotal, bill_counter);
        previous_total_minutes = lag1(totalMinutes);
        mouChange = divide(dif1(totalMinutes), previous_total_minutes);
		outcalls = divide(outcallsTotal, bill_counter);
        peakOffPeak = divide(callsPeakTotal, callsOffPeakTotal);
        peakOffPeakLast = divide(callsPeak, callsOffPeak);
		roam = divide(roamTotal, bill_counter);
        output;
    end;
run;

/*
	Print Call Summaries aggregrate
*/
proc print data=callSummaries_aggregate;
	title "Call Summaries Aggregrate data";
run;


/*
	Merge Bills aggregrate date with Call Summaries aggregrate data on Customer (ID) 
*/
data bill_and_call_summaries_merged;
    merge bills_aggregate (rename=(ID=customer))
          callSummaries_aggregate;
    by customer;
run;


/*
	Sort Demographics data
*/
proc sort data=atlib.demographics tagsort;
    by customer;
run;


/*
	Create a dataset with only the columns we need from the Demographics data
*/
data demographics_chop_for_abt replace (compress=yes);
    set atlib.demographics (rename=(marital=marry creditRating=credit));
    keep
        customer            /* Customer ID */
        children            /* Presence of children in customer household */
        credit              /* The customer’s credit rating */
        creditCard          /* the customer possesses a credit card */
        income              /* The customer’s income */
        marry               /* The customer’s marital status */
        occupation          /* The customer’s occupation */
        regionType          /* The type of region in which the customer lives */
    ;
run;


/*
	Merge the above dataset with the aggregrate data on Customer (ID)
*/
data abt_before_churn;
    merge bill_and_call_summaries_merged
          demographics_chop_for_abt;
    by customer;
run;


/*
	Assemble the final "Analytics Base Table" dataset
*/
data atlib.abt;
    set abt_before_churn;
    /* 
        TODO: Attempting to put the fields in the order to match specification,
        however the order of the keep statement is not followed
    */
    keep
        customer            /* Customer ID */
        children            /* Presence of children in customer household */
        credit              /* The customer’s credit rating */
        creditCard          /* the customer possesses a credit card */
        custcare            /* Mean number of customer care calls per month */
        custcareTotal       /* The total number of customer care calls made */
        custcareLast        /* The number of customer care calls made last month */
        directas            /* Mean number of directory assisted calls per month */
        directasLast        /* Number of director assisted calls last month */
        dropvce             /* Mean number of dropped voice calls per month */
        dropvceLast         /* Number of dropped voice calls last month */
        income              /* The customer’s income */
        marry               /* The customer’s marital status */
        mou                 /* Mean monthly minutes of use */
        mouTotal            /* Total minutes of use */
        mouChange           /* % change in minutes of use in last two months */
        occupation          /* The customer’s occupation */
        outcalls            /* Mean number of outbound voice calls per month */
        overage             /* Mean out of bundle minutes of use */
        overageMax          /* Max out of bundle minutes of use */
        overageMin          /* Min out of bundle minutes of use */
        peakOffPeak         /* Ratio of peak to off-peak calls */
        peakOffPeakLast     /* Ratio of peak to off-peak calls last month */
        recchrge            /* Mean total recurring charge */
        regionType          /* The type of region in which the customer lives */
        revenue             /* Mean monthly revenue */
        revenueTotal        /* The total revenue earned from this customer */
        revenueChange       /* % change in revenues in last two months */
        roam                /* Mean number of roaming calls per month */
        churn               /* A flag indicating whether the customer has churned {true, false} */
    ;
    /* Assume customer is not churned initially */
    churn = "false";
    /* Algoritm for determining if the customer had churned. */
    /* Adjust as appropiate */
    if (mouChange < 0 AND custcare < 2.0) then churn = "true";
run;


/*
	Print the ABT dataset
*/
proc print data=atlib.abt;
	title "Analytics Base Table data";
run;


/*
	Export the deliverable abt.csv
*/
proc export data=atlib.abt
     outfile="U:\ProgrammingForBigData\SasAssignment\sasassignment\abt.csv"
     dbms=csv
     replace;
run;


/*
	Isolate fields in the demographics data for frequency reports. 
*/
data demographics_for_freq_reports;
    set atlib.demographics;
	keep
		occupation          /* Categorical  The occupation of the customer {clerical, crafts, homemaker, professional, retired, self-­-employed, student} */
		serviceArea         /* Categorical  The cell-­-phone service area in which the customer lives */
		regionType          /* Categorical  The type of region in which the customer lives {rural, suburban, town} */
		marital             /* Categorical  The customer's marital status {yes, no, unknown} */
		children            /* Categorical  There are children present in the customer's household {true, false} */
		WebCapable          /* Categorical  The customer's handset is web capable {true, false} */
		creditRating        /* Categorical  The customers credit rating {a, aa, b, c, de, gy, z} */
		truck               /* Categorical  The customer owns a truck */
		rv                  /* Categorical  The customer owns a recreational vehicle {true, false} */
		motorcycle          /* Categorical  The customer owns a motorcycle {true, false} */
		pc                  /* Categorical  The customer owns a personal computer {true, false} */
		ownHome             /* Categorical  The customer owns their own home {true, false} */
		mailOrder           /* Categorical  The customer buys via mail order {true, false} */
		mailResponder       /* Categorical  The customer responds to mail offers {true, false} */
		mailFlag            /* Categorical  The customer has chosen not to be solicited by mail {true, false} */
		travel              /* Categorical  The customer has travelled internationally {true, false} */
		creditCard          /* Categorical  The customer owns a credit card {true, false} */
		newCellUser         /* Categorical  The customer is a known new cell phone user {yes, no, unknown} */
	;
run;

/*
	Generate frequecy reports
*/
ODS pdf;
proc freq data=demographics_for_freq_reports;
    table _ALL_ / nocum missing;
	title "Frequency Report for Categorical Demographic data";
run;
ODS pdf close;


/* 

TODO:
- DONE: use divide() function instead of if statments for divide by zero
- DONE: rename ID to customer in final dataset atlib.abt
- DONE: Investigate: in final dataset, found "t" and "f" values in the 4th 26th records amongst a true/false values 
- DONE: Export out to a CSV?
- DONE: Frequency reports for categorical variables
- Investigate: in final dataset, peakOffPeak feld values do not seem correct, only 1 and zeros!?
- Reports showing min, max and mean number of missing values for all numeric variables.
- Consider the logic for customers who do not have records for all 6 months?
- Create a graphical report?
- Document code
- Attempt to get Jan-2011 output format for import of bills.csv
- Fix import of calls.csv: getting this error:
NOTE: Invalid data for length in line 82939 27-30.
RULE:     ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9--
82939     1001276, 29Jan11:03:20:42, NaN, 0044632491291, complete, false, false, true 75
callDate=2011-01-29T03:20:42 length=. customerID=1001276 number=44632491291 outcome=complete
roaming=false directorAssisted=false peakOrOffPeak=true _ERROR_=1 _N_=82938

*/
