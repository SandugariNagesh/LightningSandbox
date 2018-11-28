global class CaseCommentHelper {

        //public static void SendSomething(id anId, id commentId, string aComment) {   //Changed the Parameters for Data Loader
        public static void SendSomething(Set<id> Caseidlst,Set<id> caseComIdLst ) {
                if (system.isFuture())
                //  SendSomethingNow(anId, commentId, aComment); //Changed the Parameters for Data Loader
                    SendSomethingNow(Caseidlst,caseComIdLst);
                else
                //  SendSomethingFuture(anId, commentId, aComment); //Changed the Parameters for Data Loader
                    SendSomethingFuture(Caseidlst,caseComIdLst);
        }
        
        @future (callout=true)
        static void SendSomethingFuture(Set<id> Caseidlst,Set<id> caseComIdLst) {
            //SendSomethingNow(anId, commentId, aComment); //Changed the Parameters for Data Loader
            SendSomethingNow(Caseidlst,caseComIdLst);
        }
        
        //static void SendSomethingNow(id anId, id commentId, string aComment) { //Changed the Parameters for Data Loader
        static void SendSomethingNow(Set<id> Caseidlst,Set<id> caseComIdLst) {
                system.debug('HasFired = ' + HasFired);
                
                /****** if (HasFired)
                            return;
                                            
                HasFired = true;
                
                ****** Need to Re-Write *********/
                
                /*Case aCase = [ Select id, CaseNumber, Customer_Request_id__c from case where id = :anId limit 1 ];
                system.assertNotEquals(null, aCase);
                
                CaseComment com = [ Select id, createdById, createdBy.Name, IsPublished from CaseComment where id =: commentId limit 1];
                system.assertNotEquals(null, com); */
                
                //Creating the Map for caseID & Case details
                 Map<id, List<case> > caselist = new Map<id, List<case> >();
                  for(case cas :[select  id, CaseNumber, Customer_Request_id__c from case where id in :Caseidlst]){
                    if(caselist.containsKey(cas.Id)) {
                        List<case> tempCase = caselist.get(cas.Id);
                        tempCase.add(cas);
                        caselist.put(cas.Id, tempCase);
                    } else {
                        List<Case> tmpCase = new List<Case>();
                        tmpCase.add(cas);
                        caselist.put(cas.Id, tmpCase);
                    }
                }
                
                //Creating the Map for ParentID & CaseComment 
                map<id, list<casecomment> > cascomlist = new Map<id, list<casecomment> >();
                for(CaseComment casecom :[Select id, parentid, createdById, createdBy.Name, IsPublished,CommentBody from CaseComment where id in :caseComIdLst])
                {
                    if(cascomlist.containsKey(casecom.Id)) {
                        List<CaseComment> tempCase = cascomlist.get(casecom.Id);
                        tempCase.add(casecom);
                        cascomlist.put(casecom.ParentId, tempCase);
                    } else {
                        List<CaseComment> tmpCase = new List<CaseComment>();
                        tmpCase.add(casecom);
                        cascomlist.put(casecom.ParentId, tmpCase);
                    }
                }
                
                 List<Case_Comment_Insertion_Failed__c> commInserFailed = new List<Case_Comment_Insertion_Failed__c>();
                 
               // For loop for each Case ID
                For(Id comid: Caseidlst ){
                    list<CaseComment> com = cascomlist.get(comid);
                                           
                    if(com != null){
                        
                        list<case> aCase = caselist.get(com[0].parentid);
                                                
                        String createdBy = 'Owner';
                        string aComment = com[0].CommentBody ; 
                        id commentId = com[0].id ; 
                        if (String.IsNotBlank(com[0].createdBy.Name)) {
                                createdBy = com[0].createdBy.Name;
                        }
                    
                        if (com[0].IsPublished == false || String.IsBlank(aCase[0].Customer_Request_Id__c))
                                return;
                    
                        Http http = new Http();
                        HttpRequest request = new HttpRequest();
                    
                        request.setMethod('POST');
                       
                        String body = String.Format('requestId={0}&comment={1}&caseId={2}&caseNumber={3}',
                            new string[] { 
                                EncodingUtil.URLEncode(aCase[0].Customer_Request_id__c, 'UTF-8'),
                                EncodingUtil.URLEncode(aComment , 'UTF-8') ,
                                EncodingUtil.URLEncode(aCase[0].id, 'UTF-8'), 
                                EncodingUtil.URLEncode(aCase[0].CaseNumber, 'UTF-8') 
                            }
                        );
                    
                        request.setBody(body);
                        request.setEndpoint(String.Format('{0}/rest/philly311/comment_submitPS',
                        new string[] { 
                        X311SystemSettings.SAGURL()}));
                    
                        System.debug('Body: ' + body);
                        
                        try {
                            CommentInsertionResponse comRes = new CommentInsertionResponse();
                            String statusCode = null;
                            String resp = null;
                            Httpresponse response = new Httpresponse();
                            if (!Test.isRunningTest())    {
                                response = http.send(request);                            
                                resp = response.getBody();        
                                System.debug(response.getStatusCode());
                                statusCode = String.valueOf(response.getStatusCode());
                             }   
                             else    {
                                 statusCode = '400';
                             }
                            if (statusCode == '200') {
                                    System.debug(response.getBody());
                                    comRes = (CommentInsertionResponse)JSON.deserialize(resp, CommentInsertionResponse.class); 
                                    System.debug('comRes.response: ' + comRes.response);
                                    System.debug('comRes.StatusCode: ' + comRes.StatusCode);
                                    System.debug('comRes.response.status.code: ' + comRes.response.status.code);
                            }
                            
                            if ((statusCode != '200' ) || comRes.response.status.code != '200') {
                                    Matcher m = Pattern.compile('.{1,255}').matcher(aComment); 
                                    Integer len = aComment.length();
                                    Case_Comment_Insertion_Failed__c c = new Case_Comment_Insertion_Failed__c();
                                    c.Name = commentId;
                                    c.Case_ID__c = aCase[0].id ;
                                    c.Case_Number__c = aCase[0].CaseNumber;
                                    c.Case_Comment_Body_Size__c = len;
                                    c.Customer_Request_ID__c = aCase[0].Customer_Request_id__c;          
                                    c.Case_Comment_Body_1__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_2__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_3__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_4__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_5__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_6__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_7__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_8__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_9__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_10__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_11__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_12__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_13__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_14__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_15__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    c.Case_Comment_Body_16__c = m.find() ? aComment.substring(m.start(), m.end()) : '';
                                    //insert c; commented to Insert the records batch level
                                   commInserFailed.add(c);
                            }
                        } catch(Exception ex) {
                    
                                System.debug('Insertion Failed: ' + ex.getMessage());
                            }                       
                    }
                }
                insert commInserFailed;
            }
      
        public class CommentInsertionResponse {
                public CommentInsertionWrapper1  response;
                public String StatusCode;
                public String Status;
        }
      
        public class CommentInsertionWrapper1 {
                public CommentInsertionWrapper2  status;
        }
      
        public class CommentInsertionWrapper2 {
                public String message; 
                public String code_message;
                public String code;
                public String type;
        }
        
        static boolean HasFired = false;
}