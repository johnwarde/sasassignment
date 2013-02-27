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
data atlib.bills_small;
    infile 'U:\ProgrammingForBigData\SasAssignment\bills-small.csv' dlm=',' dsd firstobs=2;
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


proc print data=atlib.bills_small;
run;




/* 
   Import Customer Call Records data 

   Sample Data
1000004, 25Jan11:00:41:12, 1.281945212974323, 0884469412, complete, false, false, true

*/
data atlib.calls_small;
    infile 'U:\ProgrammingForBigData\SasAssignment\calls-small.csv' dlm=',' dsd firstobs=2;
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


proc print data=atlib.calls_small;
run;



/*

    Import Call Summaries Data

    Sample Data
1000004, Jan-2011, 0, 0, 0, 0, 0, 0, 1, 4, 5, 7.3825136479466

*/
data atlib.callSummaries_small;
    infile 'U:\ProgrammingForBigData\SasAssignment\callSummaries-small.csv' dlm=',' dsd firstobs=2;
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


proc print data=atlib.callSummaries_small;
run;

/*
    Import Customer Demographics

Sample Data
1000004, 26, crafts, MILMIL414, town, yes, true, 6.0, 60, 1, 1, 1812, false, 0.0, b, 0, 
false, false, false, false, true, false, false, false, false, true, yes, 0

*/
data atlib.demographics_small;
    infile 'U:\ProgrammingForBigData\SasAssignment\demographics-small.csv' dlm=',' dsd firstobs=2;
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


proc print data=atlib.demographics_small;
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
