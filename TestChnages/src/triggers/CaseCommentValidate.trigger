/* This trigger has been created for an email alert to be sent in case of a duplicate Hansen comment.
The trigger checks if the current comment is from the scheduler ann compares the comment bodies of the current and previous comments.
If a duplicate is found, an email alert is sent to the public group Comment Alert */
trigger CaseCommentValidate on CaseComment (after insert) {  
    User u = [select firstname, lastname from user where id=:userinfo.getuserid()];
    string username = u.firstname + ' ' + u.lastname;
    System.debug('USER ' + username);
    
    List<String> idList= new List<String>();
    Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE name = 'Comment Alert'];
    for (GroupMember gm : g.groupMembers) {
       idList.add(gm.userOrGroupId);
    }
    User[] usr = [SELECT email FROM user WHERE id IN :idList];
    
    //Get the ID's   
    set<id> caseCommentid = new set<id>();
    for (CaseComment caseComment : Trigger.new) {  
        caseCommentid.add(caseComment.parentId);
    }
    //Creating the Map for ID & Hansen_Request_ID__c
    List<Case> CaseHansenIds = [Select Id,Hansen_Request_ID__c, status from Case where Id in :caseCommentid];
    map<id, String> parentcases = new map<id, String>();
    for(case each : CaseHansenIds ){
        parentcases.put(each.id,each.Hansen_Request_ID__c);
    }

    //Create a map of CaseComment ParentID & Comments 
    Map<Id,List<CaseComment>> mapCaseCmnts= new Map<Id,List<CaseComment>>();
    
    List< CaseComment> CaseCmnts = [Select id,CommentBody,ParentId,Createdby.name,createdDate from CaseComment where ParentId in :caseCommentid order by createdDate desc];
    
    for(CaseComment CaseCom: CaseCmnts){
        if(mapCaseCmnts.containsKey(CaseCom.ParentId)) {
            List<CaseComment> tmpCaseComment = mapCaseCmnts.get(CaseCom.ParentId);
            tmpCaseComment.add(CaseCom);
            mapCaseCmnts.put(CaseCom.ParentId, tmpCaseComment);            
        }
        else {
           List<CaseComment> tmpCaseComment = new List<CaseComment>();
           tmpCaseComment.add(CaseCom);
           mapCaseCmnts.put(CaseCom.ParentId, tmpCaseComment);
        }
    }
    System.debug('Map created :' + mapCaseCmnts);   
    
    string hansen_req_id;  
    for (CaseComment caseComment : Trigger.new) {  
        //Case parentCase = [Select Hansen_Request_ID__c, status from Case where Id =:caseComment.parentId]; Commented for DataLoader
        hansen_req_id = parentcases.get(caseComment.parentId);
        if( hansen_req_id != NULL) {
            //List<CaseComment> cCom = [Select id,CommentBody,ParentId,Createdby.name,createdDate from CaseComment where ParentId =: caseComment.parentId order by createdDate desc];
            List<CaseComment> cCom = mapCaseCmnts.get(caseComment.parentId);

            if(cCom.size() > 1) {
                Integer diff = 100;                             
                DateTime now = System.now();
                DateTime prev = cCom[1].createdDate;
                Integer nowMin = now.hour()*60 + now.minute();
                Integer prevMin = prev.hour()*60 + prev.minute();                          
                System.debug('Difference ' + nowMin + ' ' + prevMin);
                if((now.year() == prev.year()) && (now.month() == prev.month()) && (now.day() == prev.day()))
                  diff = nowMin - prevMin;
                System.debug('Difference ' + now.year() + ' ' + prev.year() + ' ' + now.month() + ' ' + prev.month() + ' ' + now.day() + ' ' + prev.day() + ' ' + now.minute() + ' ' + prev.minute() + ' ' + diff);           
                if((caseComment.CommentBody == cCom[1].CommentBody) && (cCom[1].Createdby.name == 'Hansen User') && (username == 'Hansen User') && (diff < 30)) { 
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setSenderDisplayName('Salesforce Support');
                    List<String> mailToAddresses = new List<String>(); 
                    String[] ccAddresses = new String[] {'311ITSupport@Phila.gov'}; 
                    /*Moved out of loop for DataLoader
                    List<String> idList= new List<String>(); 
                    Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE name = 'Comment Alert'];
                    for (GroupMember gm : g.groupMembers) {
                       idList.add(gm.userOrGroupId);
                    }
                    User[] usr = [SELECT email FROM user WHERE id IN :idList];*/
                    for(User us : usr) {
                       mailToAddresses.add(us.email);
                    }
                    mail.setToAddresses(mailToAddresses);
                    mail.setCcAddresses(ccAddresses);
                    mail.setSubject('URGENT: Hansen Duplicate Comment Alert!');                      
                    mail.setUseSignature(false); 
                    mail.setReplyTo('donotreply@salesforce.com');  
                    mail.setSenderDisplayName('Salesforce Support');                    
                    mail.setSaveAsActivity(false);                                      
                    mail.setPlainTextBody('A new duplicate comment has been inserted in the hansen case ' + caseComment.parentId + ' with the Hansen ID ' + hansen_req_id + ' in production');
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});  
                    System.debug('Mail sent');                       
                }  
            }  
        }                            
    }     

}