@isTest(SeeAllData=true)
public class AbortCompletedJobsTest {
    
    
    private class RestMock implements HttpCalloutMock {
        
        public HTTPResponse respond(HTTPRequest req) {
            String fullJson = 'your Json Response';
            
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'text/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
    }
    
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
       
       String CRON_EXP = '0 0 0 3 9 ? 2022';
       
       String jobId = System.schedule('AbortCompletedJobsTest', CRON_EXP, new AbortCompletedJobs());
         
       CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

       Test.setMock(HttpCalloutMock.class, new RestMock());

       Test.StartTest(); 
        BatchUpdateCase reassign = new BatchUpdateCase();
        ID batchprocessid = Database.executeBatch(reassign);
       
       AbortCompletedJobs cb= new AbortCompletedJobs();
       list<sobject>obj=new list<sobject>();
       Database.QueryLocator ql = cb.start(null);
       cb.execute(null,obj);
       cb.Finish(null);

       
       
       
       //ID abortbatchprocessid = Database.executeBatch(abortreassign);
       
       Test.StopTest();
    }    
}