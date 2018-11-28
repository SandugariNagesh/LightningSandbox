@isTest
public with sharing class CasePurgeJob3Test{
       
    static testmethod void m1() {
             
       String CRON_EXP = '0 0 0 15 3 ? *';
       String jobId = System.schedule('CasePurgeJob3Test',  CRON_EXP, new CasePurgeJob3());
       CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
      
       list<Case>caselist=new list<case>();
     for(Case a:[select id,origin,Case_Record_Type__c,caseNumber,department__c,Service_Request_Type__c from case]){
      a.Case_Record_Type__c='Information Request';
      caselist.add(a);

        }
         update caselist;
        Test.StartTest();
        CasePurgeJob3 sync = new CasePurgeJob3 ();
        Database.QueryLocator ql = sync.start(null);
        sync.execute(null,caselist);
        sync.Finish(null);
                
        
        
        Test.StopTest();   
    }

}