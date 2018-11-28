@isTest
private class EmailAlertOnAttachmentTest {

    private static testMethod void checkEmails() {
        
        Contact c = new Contact(LastName = 'Test Contact',Email = 'test@philly311.com');
        insert c;
        case cse=New Case(Type='Service Request Type',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,street__c='xyz',Department__c='Streets Department',Case_record_type__c='Abandoned Bike',Service_Request_Type__c='Abandoned Bike',Missing_Damaged_Parts__c='Yes',Time_Locked_in_Same_Location__c='More Than One Month',contactid=c.id,Unusable__c='Yes',Tagged_With_Yellow_Alert_Notice__c='No',Translator_Required__c='No',Description='Test',subject='Abandoned Bike',origin='Email');
        insert cse;
        
        Attachment attach=new Attachment();     
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=cse.id;
        insert attach;
        
        List<Attachment> attachments=[select id, name from Attachment where parent.id=:cse.id];
        System.assertEquals(1, attachments.size());

    }

}