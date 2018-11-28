public with sharing class PostMethodImplementationController {

    public string orgainzation{get;set;}
    public string appName{get;set;} 
    public string productUrl{get;set;}
    public string firstName{get;set;}
    public string lastName{get;set;}
    public string email{get;set;}
    public string phone{get;set;}    
    public string url{get;set;}
    public string key{get;set;} 
    
    APIkey_Register__c v = new APIkey_Register__c();    
    boolean flag1=false;    
    PageReference pageRef;
    
    public PostMethodImplementationController(){ 
     
    }


    public PageReference save() {

        list<APIkey_Register__c> obj1 =[Select url_Open311__c from APIkey_Register__c where url_Open311__c=:productUrl];
        
        //Support Ticket # 091909892
        //Added try catch block to handle exception thrown while API Key creation        
        if(obj1.isEmpty()){
            try {
                APIkey_Register__c obj = new APIkey_Register__c();
                obj.Organization_Open311__c=orgainzation;
                obj.App_Name_Open311__c=appName;
                obj.url_Open311__c=productUrl;
                obj.First_Name_Open311__c=firstName;
                obj.Last_Name_Open311__c=lastName;
                obj.Email_Open311__c=email;
                obj.Phone_Open311__c=decimal.valueOf(phone);
                insert(obj);
                                
                v =[select Key_Open311__c from APIkey_Register__c where url_Open311__c =:productUrl] ;
                key=string.valueOf(v.key_Open311__c);
                
                //Support Ticket # 091909892
                //Feature added to send an email to the user once API Key is generated.
                
                String[] toAddresses = new String[] {email}; 
                OrgWideEmailAddress ow = [select Id from OrgWideEmailAddress LIMIT 1];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
                mail.setToAddresses(toAddresses);
                
                if(ow.Id != null)
                    mail.setOrgWideEmailAddressId(ow.Id);
                mail.setUseSignature(false);
                mail.setSubject('API Key Creation Notification');
                String body = 'Hi ' + firstName + ', \n\tApi Key \"' + v.key_Open311__c + '\" has been created for the Organisation which can be used from this instance. \nRegards,\nPhilly 311';              
                mail.setPlainTextBody(body);
                Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                        
                pageRef = Page.AppKeyRegistrationSuccess;
                pageRef.getParameters().put('key',string.valueOf(v.key_Open311__c));  
            }
            catch(Exception ex)    {
                pageRef = Page.AppKeyRegistrationFailure;
                pageRef.getParameters().put('error',ex.getMessage());  
            }                        
        } 
        else if((obj1.isEmpty()==false))  {   
     
            v =[select Key_Open311__c from APIkey_Register__c where url_Open311__c =:productUrl] ;
            key=string.valueOf(v.key_Open311__c);
            
            pageRef = Page.AppKeyRegistrationFailure;
            pageRef.getParameters().put('key',string.valueOf(v.key_Open311__c));  
        }

        return pageRef;      
    
    }
 }