trigger EmailAlertOnAttachment on Attachment (after insert) {
    
    String emailTempalte  = 'AttachmentTriggerTemplate';
    OrgWideEmailAddress owa = [select id, DisplayName, Address from OrgWideEmailAddress WHERE DisplayName = 'Philly 311'];
  //  List<Attachment> AttachmentList = new List<Attachment>();
    List <String> listEmailMembers = new List<String>();
    List<Messaging.SingleEmailMessage> lstEmailId=new List<Messaging.SingleEmailMessage>();
    set<Id>caseIds = new set<Id>();
     for (Attachment a : trigger.new) {
             caseIds.add(a.parentId);
        
    }
    
    map<Id,Case> caseMap= new map<Id, case>( [SELECT Id,ContactId, ContactEmail, CaseNumber, RecordType.Name, Street__c, Department__c from Case where Id IN : caseIds]); 
    EmailTemplate tpl = [select Id,Subject, HtmlValue, Body FROM EmailTemplate WHERE Name = 'AttachmentTriggerTemplate' limit 1];
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<Messaging.EmailFileAttachment> attachmentList = new List<Messaging.EmailFileAttachment>();
    List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
    
    for (Attachment a : [select Name, Body, BodyLength, ParentId from Attachment where Id IN :Trigger.new]){
       
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(a.Name);
                efa.setBody(a.Body);
                fileAttachments.add(efa);
                
            
    }
    

    for (Attachment att : trigger.new) {
        try{
    
        if(!String.isBlank(caseMap.get(att.parentId).ContactId)){
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         mail.setTemplateId(tpl.id);
         mail.setTargetObjectId(caseMap.get(att.parentId).ContactId);
         mail.setWhatId(att.parentId);
         mail.setOrgWideEmailAddressId(owa.id);
         mail.setSaveAsActivity(false);
         if(fileAttachments != null && fileAttachments.size() > 0){
            mail.setFileAttachments(fileAttachments);
         }
         
         mails.add(mail);
       }
       Messaging.sendEmail(mails);
     }
      
    catch(Exception e){
        
    }
        
    }

}