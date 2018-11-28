trigger CaseCommentAfterInsert on CaseComment (after insert, after update) {
    
    set<id> parentCaseids = new set<id>();
    set<id> cascomids = new set<id>();
    
    List<CaseComment> CaseComList = new List<CaseComment>();
    List<CaseComment> CaseComInsert = new List<CaseComment>();
    for (CaseComment each : trigger.new){ // Collecting the CaseCoomment IDs & ParentIDs       
        parentCaseids.add(each.parentId); 
        cascomids.add(each.id); 
        CaseComment cCom = new CaseComment(id = each.id, CommentBody = each.CommentBody,  parentId = each.id);
        CaseComList.add(cCom );
    }
    System.debug('List Of CaseComments:' + CaseComList);
    
    //Creating the Map with Key as ID and Values as Case list.
    Map<Id, List<Case>> mapCaseparent = new Map<Id , List<Case>>();
    List<Case> cCase = [Select id, caseNumber,Hansen_Request_ID__c,parentId from Case where parentId in :parentCaseids ];
    List<Case> HansenCasesid = [Select Id,Hansen_Request_ID__c from Case where Id in :parentCaseids and Hansen_Request_ID__c != Null];
    Map<ID, String> HansenWithID = new Map<ID, String>();
    set<String> casehansenreq = new set<string>();
       
    for(case ParentIdCase : cCase){
        
            if(mapCaseparent.containsKey(ParentIdCase.ParentId)) {
                List<Case> tmpCase = mapCaseparent.get(ParentIdCase.ParentId);
                tmpCase.add(ParentIdCase );
                mapCaseparent.put(ParentIdCase.ParentId, tmpCase);            
            }
               else {
                   List<Case> tmpCase = new List<Case>();
                   tmpCase.add(ParentIdCase);
                   mapCaseparent.put(ParentIdCase.ParentId, tmpCase);
               }
        
    }
    Map<String, Set<ID>> hansencases = new Map<String, Set<ID>>();
    For(case each : HansenCasesid ){
    
        if(each.Hansen_Request_ID__c != Null){
            casehansenreq.add(each.Hansen_Request_ID__c); 
            HansenWithID.put(each.id,each.Hansen_Request_ID__c); 
        }
    }
    
    List<case> childHansenCasesid = [Select Id,Hansen_Request_ID__c, status from Case where Id not in :parentCaseids and Hansen_Request_ID__c in :casehansenreq and parentId = null];
    
    for(case c : childHansenCasesid){
        if(hansencases.containsKey(c.Hansen_Request_ID__c)) {
            set<id> tmpCaseids = hansencases.get(c.Hansen_Request_ID__c);
            tmpCaseids.add(c.id);
            hansencases.put(c.Hansen_Request_ID__c, tmpCaseids );            
        }
        else {
           set<id> tempid = new set<id>();
           tempid.add(c.id); 
           hansencases.put(c.Hansen_Request_ID__c, tempid);
        }
    }
    
    System.debug('Map created :' + mapCaseparent);
    
    //For each case, updating the child cases comments.   
    for (CaseComment each : trigger.new) {
        //Related Cases change 10577449 START UNISYS
        //  List<Case> cCase = [Select id, caseNumber from Case where parentId =: each.parentId];
        List<Case> cCase = mapCaseparent.get(each.parentId);
        System.debug('New comment' + cCase);
        if(cCase != null) {
            for(Case cas : cCase) {
                CaseComment cCom = new CaseComment(CommentBody = each.CommentBody, isPublished = each.isPublished, parentId = cas.Id);
                System.debug('Inserting cCom');
                //insert cCom;
                CaseComInsert.add(cCom);
            }
        }

        if (RecursiveTriggerHandler.isFirstTimeCaseCommentAfter){
            RecursiveTriggerHandler.isFirstTimeCaseCommentAfter = false;
            String hansenNumberForID = HansenWithID.get(each.parentid);
            system.debug(hansenNumberForID);
            if(hansenNumberForID != null ){
            
                Set<id> IdListforHansenNumber = hansencases.get(hansenNumberForID);
                system.debug(IdListforHansenNumber );
                if(IdListforHansenNumber!=null && !IdListforHansenNumber.isEmpty()){
                                    
                    for( Id eachid : IdListforHansenNumber ){
                        if(each.parentid != eachid){                
                            system.debug(eachid );
                            caseComment cCom = new caseComment(CommentBody = each.CommentBody, isPublished = each.isPublished, parentId = eachid);
                            CaseComInsert.add(cCom);
                        }    
                    }
                }     
            }     
         }   
        //Related Cases change 10577449 END UNISYS
        //    CaseCommentHelper.SendSomething(each.parentId,each.id , each.CommentBody);
        //CaseCommentHelper.SendSomething(CaseComList);
    }
    insert CaseComInsert;// Batch level Insertion
    
    //Future call for PS
    CaseCommentHelper.SendSomething(parentCaseids,cascomids);
}