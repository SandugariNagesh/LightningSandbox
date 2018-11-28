@isTest 
public class StopDeletingCasesTest {
    static testMethod void Dontdeletecases() 
    {
            Case CaseD= new Case(Type='Service Request Type',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,
            street__c='xyz',Department__c='Streets Department',
            Case_record_type__c='Abandoned Bike',Service_Request_Type__c='Abandoned Bike',
            Missing_Damaged_Parts__c='Yes',Time_Locked_in_Same_Location__c='More Than One Month',
            Unusable__c='Yes',Tagged_With_Yellow_Alert_Notice__c='No',
            Translator_Required__c='No',Description='Test',subject='Abandoned Bike',origin='Email');
        
            insert CaseD;

            try
            {
                Delete  CaseD;
            }
            catch(Exception ee)
            {}
    }
}