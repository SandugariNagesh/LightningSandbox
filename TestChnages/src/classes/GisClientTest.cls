@isTest
public class GisClientTest {

@isTest static void doCallTest() {

RecordType rt = [SELECT id,Name 
                           FROM RecordType 
                           WHERE SobjectType='Case' AND Name='Abandoned Bike' ];

Case cse=New Case(Type='Service Request Type',Department__c='Streets Department', RecordTypeId =rt.Id,Service_Request_Type__c='Abandoned Bike', 
Tagged_With_Yellow_Alert_Notice__c ='Yes',subject='Abandoned Bike',origin='Email',Missing_Damaged_Parts__c='YES', Unusable__c='No',
Time_Locked_in_Same_Location__c='One month or more');
Insert cse;

GisClient.QueryByRadius (rt.Id,22,18,2);

    }

}