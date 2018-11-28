global class ProcessArticleSubscriptionEmail implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
        Messaging.InboundEnvelope envelope) {
        
            Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
            FAQ1__kav flist2 = new Faq1__Kav();
            FAQ1__kav flist1 = new Faq1__Kav();
            String myPlainText = 'The knowledge article for which you have  subscribed has been updated. Please login to the below link to check the change';
            string articleNumber = email.plainTextBody;
            Messaging.reserveSingleEmailCapacity(100);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            list<String> addr=new list<String>();
            // Support ticket #09410933 fix start
            try {
                try {
                    flist2 = [select id,isLatestVersion,ArticleNumber,KnowledgeArticleId,PublishStatus from FAQ1__kav where  publishStatus='Online' and Language='en_US' and ArticleNumber=:articleNumber limit 1 ];
                } 
                catch (Exception e) {}
                try {
                    flist1 = [select id,ArticleNumber,KnowledgeArticleId,LastPublishedDate,LastModifiedDate,Summary,Title from FAQ1__kav where PublishStatus='Draft' and Language='en_US' ORDER BY LastModifiedDate desc limit 1]; // and LastModifiedDate>:dt2 and LastModifiedDate<:dt
                } 
                catch (Exception e){}
                if(flist1 !=null){
                    for(SubscribeArticle__c sub:[select email__c,ArticleID__c from SubscribeArticle__c where ArticleID__c=:flist1.articleNumber]) {
                        addr.add(sub.email__c); 
                        system.debug('email addresses' + addr);               
                    }
                }if (flist2 != null ) {
                    for(SubscribeArticle__c sub:[select email__c,ArticleID__c from SubscribeArticle__c where ArticleID__c=:flist2.articleNumber]) {
                        addr.add(sub.email__c); 
                        system.debug('email addresses' + addr);               
                    }
                }
              // Support ticket #09410933 fix end   
             } catch (Exception e) {
                 system.debug('Exception Occured' + e.getMessage());
             }   
                        
               // system.debug('Exited for loop with the email addresses' + addr);
                if(addr.size()!=0){
                    system.debug('Address is'+addr);
                    mail.setToAddresses(addr);
                    mail.setReplyTo('philly311@phila.gov');
                    mail.setSenderDisplayName('City Of Philadelphia Knowledge Article');
                    mail.setSubject('Knowledge Article Number '+flist2.articleNumber+ ' has been Updated');
                    mail.setBccSender(false);
                    mail.setUseSignature(false);
                    // Support ticket #09410933 fix start 
                    if(flist2.knowledgeArticleid != null) 
                    mail.setPlainTextBody(myPlainText+'\n https://philly311--c.na23.visual.force.com/apex/X311TemplateFAQSample?id='+id.valueOf(flist2.knowledgearticleid));
                    if(flist1.knowledgeArticleid != null)
                    mail.setPlainTextBody(myPlainText+'\n https://philly311--c.na23.visual.force.com/apex/X311TemplateFAQSample?id='+id.valueOf(flist1.knowledgearticleid));
                    if(mail.plainTextBody != null)
                    // Support ticket #09410933 fix end
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
           }
                return result;
    }
}