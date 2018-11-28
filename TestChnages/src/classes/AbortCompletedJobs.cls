global class AbortCompletedJobs implements Database.Batchable<sObject>, Database.Stateful,schedulable    {
    
    global Database.QueryLocator start(Database.BatchableContext BC)  {
        return Database.getquerylocator('select id from crontrigger where state = \'DELETED\'  and NextFireTime = null limit 150');
    }
    
    global void execute(Database.BatchableContext BC, List<Sobject>scope){
        for(Sobject s:scope){
            system.abortJob(s.id);
        } 
    }
    global void finish(Database.BatchableContext BC){}
     global void execute(SchedulableContext sc){
        Database.ExecuteBatch(new AbortCompletedJobs());
    } 
}