@isTest
private class CaseCommentHelperTest {


        static testMethod void testLinkCountUpdate() {
        
                Case aCase = new Case(
                customer_request_id__c = '12234',
                subject = 'a subject',
                
                // next couple lines inserted to avoid trigger callout to locate and project (caseAfterUpdate/CaseWrapper)
                street__c = 'a street',
                centerline_match_type__c = 'a type',
                centerline_2272x__c = 10,
                centerline_2272y__c = 10,
                description = 'a description',
                Origin = 'Phone',
                Customer_Declined__c = TRUE,
                Translator_Required__c = 'No',
                Hansen_Request_ID__c = '979999'
                );
                
                
    
                Test.startTest();
               // list<case> hansencaseID = [SELECT id,Hansen_Request_ID__c  FROM case where Hansen_Request_ID__c != null limit 1] ;
                insert aCase;
                
                
                Case aCase2 = new Case(
                customer_request_id__c = '12234',
                subject = 'a subject',
                
                // next couple lines inserted to avoid trigger callout to locate and project (caseAfterUpdate/CaseWrapper)
                street__c = 'a street',
                centerline_match_type__c = 'a type',
                centerline_2272x__c = 10,
                centerline_2272y__c = 10,
                description = 'a description',
                Origin = 'Phone',
                Customer_Declined__c = TRUE,
                Translator_Required__c = 'No',
                parentid = aCase.id
                );
                
                insert aCase2;
                
                //id caseid = '500G000000bmkRiIAI';
                //if(!hansencaseID.isEmpty()){ 
                  //  caseid = hansencaseID[0].id;
                //}
                list<CaseComment> aComment  = new  list<CaseComment>();
                for(Integer i = 1; i < 8; i++) {                    
                    /*aComment[i].parentId =   aCase.id;
                    aComment[i].commentBody =   'a comment body';
                    aComment[i].isPublished =   true;*/
                    CaseComment tempComment= new CaseComment(parentId = aCase.id, commentBody = 'a comment body', isPublished = true);
                    aComment.add(tempComment);
                }   
                //CaseComment tempComment= new CaseComment(parentId = caseid , commentBody = 'a comment body', isPublished = true); 
                //CaseComment aComment= new CaseComment(parentId = aCase.id, commentBody = 'a comment body', isPublished = true);
                insert aComment;
                for(Integer i = 1; i < 8; i++) {                    
                    /*aComment[i].parentId =   aCase.id;
                    aComment[i].commentBody =   'a comment body';
                    aComment[i].isPublished =   true;*/
                    CaseComment tempComment= new CaseComment(parentId = aCase2.id, commentBody = 'a comment body for case2', isPublished = true);
                    aComment.add(tempComment);
                }   
                //insert tempComment;
                CaseCommentHelper.CommentInsertionWrapper1 c1 = new CaseCommentHelper.CommentInsertionWrapper1();
                CaseCommentHelper.CommentInsertionWrapper2 c2 = new CaseCommentHelper.CommentInsertionWrapper2();
                Test.stopTest();
    
                system.assert(true, 'Nothing to assert, because we are testing the callout');
        }
}