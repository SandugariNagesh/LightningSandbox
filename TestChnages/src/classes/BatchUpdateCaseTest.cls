@isTest(SeeAllData=true)
public class BatchUpdateCaseTest {
    
    public static testMethod void Test1() {
       user u = [SELECT ID, UserName FROM User 
                 WHERE email='nagesh.sandugari@in.unisys.com'  and Profile.Name ='SFDC Administrators' LIMIT 1];
       user u2 = [SELECT ID, UserName FROM User 
                  WHERE email ='valluru.raghu@unisys.com'  and Profile.Name ='SFDC Administrators'LIMIT 1];
       Group SupportCase = [ select id from group where developerName = 'Support' limit 1 ];
       List <Case> supportTicket = new List<Case>();
       List <Case> supportTicket1 = new List<Case>();
       RecordType r = [Select id from RecordType where DeveloperName = 'Support_Case'];
       Case c = new Case();
       System.RunAs(u) {
           for(integer i = 0; i<2; i++){
                c = new Case(RecordTypeId = r.Id, Subject = 'Test', Severity__c = '1 - Critical', Status= 'New',
                            Type_of_Issue__c = 'Defect'); 
                if(i == 1)
                    c.Severity__c = '2 - Urgent';            
                supportTicket.add(c);
           }
           insert supportTicket;
           for(case each : supportTicket){
            each.OwnerId = SupportCase.id;
            update each;   
           }
           
       }    
       System.RunAs(u2) {
           for(integer j = 0; j<2; j++){
                c = new Case(RecordTypeId = r.Id, Subject = 'Test', Severity__c = '1 - Critical', Status= 'New',
                                  Type_of_Issue__c = 'Issue'); 
                if(j == 1)
                    c.Severity__c = '3 - High';               
                supportTicket1.add(c);
           }
           insert supportTicket1;
           for(case each : supportTicket1){
            each.OwnerId = SupportCase.id;
            update each;   
           }
       }    
       Test.StartTest();
       BatchUpdateCase reassign = new BatchUpdateCase();
       ID batchprocessid = Database.executeBatch(reassign);
       Test.StopTest();
    }    
}