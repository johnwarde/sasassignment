/*
 * Student ID:   D10126532
 * Student Name: John Warde
 * Course Code:  DT230B
 *
 */

/* Define library location */
LIBNAME atlib "C:\SASData\johnwarde\SASAssignment";

/* 
    Import Customer Billing Records data 

    Sample Data
1000004, Jan-2011, 38.00, 0.00, 38.00, 7.3825136479466, 0.0

*/
data atlib.bills;
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
    * TODO: attempt to get Jan-2011 output format for below;
    format date MMYYD8.;
run;


proc print data=atlib.bills;
run;




/* 
   Import Customer Call Records data 

   Sample Data
1000004, 25Jan11:00:41:12, 1.281945212974323, 0884469412, complete, false, false, true

*/
data atlib.calls;
    infile 'U:\ProgrammingForBigData\SasAssignment\calls.csv' dlm=',' dsd firstobs=2;
    informat callDate datetime.;
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


proc print data=atlib.calls;
run;



/*

    Import Call Summaries Data

    Sample Data
1000004, Jan-2011, 0, 0, 0, 0, 0, 0, 1, 4, 5, 7.3825136479466

*/
data atlib.callSummaries;
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


proc print data=atlib.callSummaries;
run;

/*
    Import Customer Demographics

Sample Data
1000004, 26, crafts, MILMIL414, town, yes, true, 6.0, 60, 1, 1, 1812, false, 0.0, b, 0, 
false, false, false, false, true, false, false, false, false, true, yes, 0

*/
data atlib.demographics;
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
run;


proc print data=atlib.demographics;
run;



/*
    Analytics Base Table

1.  customer            Customer ID
2.  children            Presence of children in customer household
3.  credit              The customer’s credit rating
4.  creditCard          the customer possesses a credit card
5.  custcare            Mean number of customer care calls per month
6.  custcareTotal       The total number of customer care calls made
7.  custcareLast        The number of customer care calls made last month
8.  directas            Mean number of directory assisted calls per month
9.  directasLast        Number of director assisted calls last month
10. dropvce             Mean number of dropped voice calls per month
11. dropvceLast         Number of dropped voice calls last month
12. income              The customer’s income
13. marry               The customer’s marital status
14. mou                 Mean monthly minutes of use
15. mouTotal            Total minutes of use
16. mouChange           % change in minutes of use in last two months
17. occupation          The customer’s occupation
18. outcalls            Mean number of outbound voice calls per month
19. overage             Mean out of bundle minutes of use
20. overageMax          Max out of bundle minutes of use
21. overageMin          Min out of bundle minutes of use
22. peakOffPeak         Ratio of peak to off-peak calls
23. peakOffPeakLast     Ratio of peak to off-peak calls last month
24. recchrge            Mean total recurring charge
25. regionType          The type of region in which the customer lives
26. revenue             Mean monthly revenue
27. revenueTotal        The total revenue earned from this customer
28. revenueChange       % change in revenues in last two months
29. roam                Mean number of roaming calls per month
30. churn               A flag indicating whether the customer has churned {true, false}

*/
proc sort data=atlib.bills;
    by ID date;
Run;

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
        overage = out_of_bundle_minutes_total / bill_counter;
        recchrge = recurring_charge_total / bill_counter;
        revenue = revenueTotal / bill_counter;
        last_bill_total = lag1(totalBill);
        if (last_bill_total = . | last_bill_total = 0) then revenueChange = 0;
        else revenueChange = dif1(totalBill) / last_bill_total; 
        output;
    end;
run;

proc sort data=atlib.callSummaries;
    by customer recordDate;

run;

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
        custcare = custcareTotal / bill_counter;
        custcareLast = custcareTotal;
        directas = directasTotal / bill_counter;
        directasLast = callsDirectAssist;
        dropvce = dropvceTotal / bill_counter;
        dropvceLast = callsDropped;
        mou = mouTotal / bill_counter;
        previous_total_minutes = lag1(totalMinutes);
        if (previous_total_minutes = . | previous_total_minutes = 0) then mouChange = 0;
        else mouChange = dif1(totalMinutes) / previous_total_minutes; 
        outcalls = outcallsTotal / bill_counter;
        /* TODO: cater for division by zero in all cases where 
                 dividing by a value from a dataset, i.e. when
                 not dividing by a counter */
        /* Cater for divide by zero */
        if (callsOffPeakTotal = 0) then peakOffPeak = 0;
        else peakOffPeak = callsPeakTotal / callsOffPeakTotal;
        if (callsOffPeak = 0) then peakOffPeakLast = 0;
        else peakOffPeakLast = callsPeak / callsOffPeak;
        roam = roamTotal / bill_counter;
        output;
    end;
run;




/*

proc sort data = demographics;
    by customer;
run;


data atlib.abt;
    merge demographics
          bills_agg (rename (customer = ID));
          * bills_agg (rename (customer = ID bills_counter = counter)); 
    by ID;
run;

*/
