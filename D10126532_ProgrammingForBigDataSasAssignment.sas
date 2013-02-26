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

   Name             Type     Description
   ID               Numeric  Customer ID
   date             Numeric  The date of the bill (MMM-yyyy)
   recurringCharge  Numeric  The recurring bundle charge this month
   callCharges      Numeric  The call charges for this month
   totalBill        Numeric  The total bill amount for this month
   minutes          Numeric  The number of minutes used this month
   overageMins      Numeric  The number of minutes over the customer's bundle used this month
*/


data atlib.bills_small;
	infile 'U:\ProgrammingForBigData\SasAssignment\bills-small.csv' dlm=',' dsd firstobs=2;
    informat date MONYY7.;
	input ID date $ recurringCharge callCharges totalBill minutes overageMins;
	* TODO: attempt to get Jan-2011 output format for below;
	format date MMYYD8.;
run;


proc print data=atlib.bills_small;
run;




/* 
   Import Customer Call Records data 

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

Import Call Summaries Data

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

/*
	Import Customer Demographics


Name Type Description  

customer 			Numeric The customer number 
age 				Numeric The customer's age 
occupation 			Categorical The occupation of the customer {clerical, crafts, homemaker, professional, retired, self-­-employed, student} 
serviceArea 		Categorical The cell-­-phone service area in which the customer lives 
regionType 			Categorical The type of region in which the customer lives {rural, suburban, town} 
marital 			Categorical The customer's marital status {yes, no, unknown} 
children 			Categorical There are children present in the customer's household {true, false} 
income 				Numeric The customer's income {0 -­- 9} 
months 				Numeric The number of months the customer has been in service 
numPhones 			Numeric The number of phones the customer has owned 
numModels 			Numeric The number of different phone models the customer has owned 
currentEquipDays 	Numeric The number of days that the customer has owned their current handset 
WebCapable 			Categorical The customer's handset is web capable {true, false} 
handsetPrice 		Numeric The price paid for the customer's handset 
creditRating 		Categorical The customers credit rating {a, aa, b, c, de, gy, z} 
creditAdjust 		Numeric The number of times the customer's credit rating has been adjusted (either up or down) since they became a customer 
truck 				Categorical The customer owns a truck 
rv 					Categorical The customer owns a recreational vehicle {true, false} 
motorcycle 			Categorical The customer owns a motorcycle {true, false} 
pc 					Categorical The customer owns a personal computer {true, false} 
ownHome 			Categorical The customer owns their own home {true, false} 
mailOrder 			Categorical The customer buys via mail order {true, false} 
mailResponder 		Categorical The customer responds to mail offers {true, false} 
mailFlag 			Categorical The customer has chosen not to be solicited by mail {true, false} 
travel 				Categorical The customer has travelled internationally {true, false} 
creditCard 			Categorical The customer owns a credit card {true, false} 
newCellUser 		Categorical The customer is a known new cell phone user {yes, no, unknown} 
numReferrals 		Numeric The number of referrals made by the customer 


1000004, 26, crafts, MILMIL414, town, yes, true, 6.0, 60, 1, 1, 1812, false, 0.0, b, 0, 
false, false, false, false, true, false, false, false, false, true, yes, 0

*/
data atlib.demographics_small;
	infile 'U:\ProgrammingForBigData\SasAssignment\demographics-small.csv' dlm=',' dsd firstobs=2;
	length occupation $ 14;
	length serviceArea $ 14;
	input 
		customer 			/* Numeric The customer number */
		age 				/* Numeric The customer's age */
		occupation $		/* Categorical The occupation of the customer {clerical, crafts, homemaker, professional, retired, self-­-employed, student} */
		serviceArea $		/* Categorical The cell-­-phone service area in which the customer lives */
		regionType $		/* Categorical The type of region in which the customer lives {rural, suburban, town} */
		marital $			/* Categorical The customer's marital status {yes, no, unknown} */
		children $			/* Categorical There are children present in the customer's household {true, false} */
		income 				/* Numeric The customer's income {0 -­- 9} */
		months 				/* Numeric The number of months the customer has been in service */
		numPhones 			/* Numeric The number of phones the customer has owned */
		numModels 			/* Numeric The number of different phone models the customer has owned */
		currentEquipDays 	/* Numeric The number of days that the customer has owned their current handset */
		WebCapable $		/* Categorical The customer's handset is web capable {true, false} */
		handsetPrice  		/* Numeric The price paid for the customer's handset */
		creditRating $		/* Categorical The customers credit rating {a, aa, b, c, de, gy, z} */
		creditAdjust 		/* Numeric The number of times the customer's credit rating has been adjusted (either up or down) since they became a customer */
		truck $				/* Categorical The customer owns a truck */
		rv $				/* Categorical The customer owns a recreational vehicle {true, false} */
		motorcycle $		/* Categorical The customer owns a motorcycle {true, false} */
		pc $				/* Categorical The customer owns a personal computer {true, false} */
		ownHome $			/* Categorical The customer owns their own home {true, false} */
		mailOrder $			/* Categorical The customer buys via mail order {true, false} */
		mailResponder $		/* Categorical The customer responds to mail offers {true, false} */
		mailFlag $			/* Categorical The customer has chosen not to be solicited by mail {true, false} */
		travel $			/* Categorical The customer has travelled internationally {true, false} */
		creditCard $		/* Categorical The customer owns a credit card {true, false} */
		newCellUser $		/* Categorical The customer is a known new cell phone user {yes, no, unknown} */
		numReferrals 		/* Numeric The number of referrals made by the customer */
    ;
run;


proc print data=atlib.demographics_small;
run;


