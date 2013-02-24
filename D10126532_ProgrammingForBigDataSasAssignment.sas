/*
 * Student ID:   D10126532
 * Student Name: John Warde
 * Course Code:  DT230B
 *
 */

/* Define library location */
LIBNAME alib "C:\SASData\johnwarde\SASAssignment";

/* Import Customer Billing Records data */

data alib.bills_small;
	infile 'U:\ProrammingForBigData\SasAssignment\bills_small.csv' dlm=',' dsd firstobs=2;
/*
Name             Type     Description
ID               Numeric  Customer ID
date             Numeric  The date of the bill (MMM-yyyy)
recurringCharge  Numeric  The recurring bundle charge this month
callCharges      Numeric  The call charges for this month
totalBill        Numeric  The total bill amount for this month
minutes          Numeric  The number of minutes used this month
overageMins      Numeric  The number of minutes over the customer's bundle used this month
*/
    informat date MONYY7.;
	input ID date $ recurringCharge callCharges totalBill minutes overageMins;
	/* TODO: attempt to get Jan-2011 output format for below */ 
	format date MMYYD8.;
run;


proc print data=alib.bills_small;
run;



/*



Name             Type     Description
customerID        Numeric  customerID
callDate          Numeric  The date and time of the call
length            Numeric  The length of the call in minutes
number            Numeric  The number called
outcome           Numeric  The outcome of the call {blocked, unanswered, complete, dropped}
roaming           Numeric  Was this call a roaming {true, false}
directorAssisted  Numeric  Was this a directory assisted call {true, false}
peakOrOffPeak     Numeric  Was this call on peak {true, false}


customerID callDate length number outcome roaming directorAssisted peakOrOffPeak


*/


/*




callSummaries.csv

Name               Type     Description
callsBlocked       Numeric  The number of blocked calls in the billing period
callsCustCare      Numeric  The number of calls made to customer care in this period
callsDirectAssist  Numeric  The number of directory assisted calls made in this period
callsDropped       Numeric  The number of calls dropped in this period
callsOffPeak       Numeric  The total number of off peak calls made in this period
callsPeak          Numeric  The total number of peak calls made in this period
callsRoam          Numeric  The number of roaming calls made in this period
callsTotal         Numeric  The total number of calls made in this period
callsUnanswered    Numeric  The number of unanswered calls made in this period
customer           Numeric  Customer ID
recordDate         Numeric  The date of the bill (MMM-yyyy)
totalMinutes       Numeric  The total number of minutes used in this period

*/
