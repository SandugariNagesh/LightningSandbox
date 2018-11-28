global class UpdateInFuture {
    @future
    public static void updateCase(String customCaseId)
    {
        String systemID, caseId;
        
      System.debug([SELECT Id, system_id__c FROM Case WHERE system_id__c=:customCaseId]);
        for(Case cs : [SELECT Id, system_id__c FROM Case WHERE system_id__c=:customCaseId])
        {
            if(cs.system_id__c != null)
            {
                systemID = cs.system_id__c;
                caseId = cs.id;
            }
        }

        if(systemID != null && caseId != null)
        {
            
            list<attachment> attachmentListForCase = new list<attachment>();
            System.debug('systemID : ' + systemID);
            
            for(attachment attch : [SELECT id, contenttype, body, name FROM attachment WHERE parentId =: systemID])
            {
                Attachment csAttch = new Attachment();
                csAttch.contenttype = attch.contenttype;
                csAttch.body = attch.body;
                csAttch.name  = attch.name;
                csAttch.parentId = caseId;
                
                attachmentListForCase.add(csAttch);
            }
            
            if(attachmentListForCase.size() > 0)
            {
                insert attachmentListForCase;
            }
        }
    }
    
}