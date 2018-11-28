trigger UpdateCustomCaseAttachment on Community_Case__c (After Update) {
    
    for(Community_Case__c c : Trigger.new )
    {
        UpdateInFuture.updatecase(String.valueof(c.id));
    }
    
    

}