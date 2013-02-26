/*
 * Student ID:   D10126532
 * Student Name: John Warde
 * Course Code:  DT230B
 *
 */

/* Define library location */
*LIBNAME atlib "C:\SASData\johnwarde\SASAssignment";

/* Import Customer Billing Records data 

   Name             Type     Description
   ID               Numeric  Customer ID
   date             Numeric  The date of the bill (MMM-yyyy)
   recurringCharge  Numeric  The recurring bundle charge this month
   callCharges      Numeric  The call charges for this month
   totalBill        Numeric  The total bill amount for this month
   minutes          Numeric  The number of minutes used this month
   overageMins      Numeric  The number of minutes over the customer's bundle used this month
*/

/*
data atlib.bills_small;
	infile 'U:\ProgrammingForBigData\SasAssignment\bills-small.csv' dlm=',' dsd firstobs=2;
    informat date MONYY7.;
	input ID date $ recurringCharge callCharges totalBill minutes overageMins;
	* TODO: attempt to get Jan-2011 output format for below;
	format date MMYYD8.;
run;


proc print data=atlib.bills_small;
run;
*/



/* Import Customer Call Records data 

   Name              Type     Description
   customerID        Numeric  customerID
   callDate          Numeric  The date and time of the call
   length            Numeric  The length of the call in minutes
   number            Numeric  The number called
   outcome           Numeric  The outcome of the call {blocked, unanswered, complete, dropped}
   roaming           Numeric  Was this call a roaming {true, false}
   directorAssisted  Numeric  Was this a directory assisted call {true, false}
   peakOrOffPeak     Numeric  Was this call on peak {true, false}

*/
data atlib.calls_small;
	infile 'U:\ProgrammingForBigData\SasAssignment\calls-small.csv' dlm=',' dsd firstobs=2;
    informat callDate datetime.;
	input customerID callDate $ length number outcome $ roaming $ directorAssisted $ peakOrOffPeak $;
	format callDate e8601dt.;
run;


proc print data=atlib.calls_small;
run;



/*

callSummaries.csv

Name               Type     Description
customer           Numeric  Customer ID
recordDate         Numeric  The date of the bill (MMM-yyyy)
callsDropped       Numeric  The number of calls dropped in this period
callsBlocked       Numeric  The number of blocked calls in the billing period
callsUnanswered    Numeric  The number of unanswered calls made in this period
callsCustCare      Numeric  The number of calls made to customer care in this period
callsDirectAssist  Numeric  The number of directory assisted calls made in this period
callsRoam          Numeric  The number of roaming calls made in this period
callsPeak          Numeric  The total number of peak calls made in this period
callsOffPeak       Numeric  The total number of off peak calls made in this period
callsTotal         Numeric  The total number of calls made in this period
totalMinutes       Numeric  The total number of minutes used in this period

customer, recordDate, callsDropped, callsBlocked, callsUnanswered, callsCustCare, callsDirectAssist, callsRoam, callsPea
k, callsOffPeak, callsTotal, totalMinutes
1000004, Jan-2011, 0, 0, 0, 0, 0, 0, 1, 4, 5, 7.3825136479466

*/
data atlib.callSummaries_small;
	infile 'U:\ProgrammingForBigData\SasAssignment\callSummaries-small.csv' dlm=',' dsd firstobs=2;
    informat recordDate MONYY7.;
	input customer recordDate $ callsDropped callsBlocked callsUnanswered callsCustCare callsDirectAssist callsRoam callsPeak callsOffPeak callsTotal totalMinutes;
	format recordDate MMYYD8.;
run;


proc print data=atlib.callSummaries_small;
run;

