public class ContactWrapperClass {

    public static void checkAnonAnon(List<Contact> conList, List<User> uList, List<Profile> pList)  {
        
        // No SOQL Query
        System.debug('Checking ANON ANON Contact');        
        String name ;
        Integer i =0;
        for(Contact c : conList ) {
            if(c.firstName != null)
                name = c.firstName+ ' ' + c.lastName;
            else 
                name = c.lastName;    
            if(name.equalsIgnoreCase('ANON ANON')) {
                c.addError('Contact Name Not Permissible');
            }
            if(Trigger.isUpdate) {
                if(c.id == '003G000001lF2wN'  || c.Email == 'anonymous@publicstuff.com') {
                    c.addError('You Dont Have Permission To Update This Contact');
                }
            }
            i++;
        }
        validateEmail(conList, uList, pList);
    }   
    
    public static void validateEmail(List<Contact> conList, List<User> uList, List<Profile> pList)  {

        System.debug('Checking for Duplicate Contact');
        List<Contact> conSet = new List<Contact>();
        Set<String> conEmail = new Set<String>();
        try{
            for (Contact con : conList) {
             
             System.debug('Contact Id: ' + con.id);
             if(con.Email != null)    {
                System.debug('Contact Email: ' + con.Email); 
                conSet = [Select id from Contact where email =: con.Email and id !=: con.Id and accountId =: con.Accountid  LIMIT 1];
                System.debug('Contact with same email id: ' + conList.size());
                System.debug(conList);
                System.debug(conSet);
                if(conSet.size() > 0){
                    con.email.addError('Unique Email-id need to be entered!');    
                }
             }
                if(con.email != null ){     
                    if(con.email == con.email2__c || con.email == con.email3__c || con.email == con.email4__c || con.email == con.email5__c) {
                        con.email.addError('Unique Email-id need to be entered!');
                    }    
                }
                if(con.email2__c != null ){     
                    if(con.email2__c == con.email || con.email2__c == con.email3__c || con.email2__c == con.email4__c || con.email2__c == con.email5__c) {
                        con.email2__c.addError('Unique Email-id need to be entered!');
                    }    
                }
                if(con.email3__c != null ) {
                
                    if(con.email3__c == con.email2__c || con.email3__c == con.email || con.email3__c == con.email4__c || con.email3__c == con.email5__c) {
                        con.email3__c.addError('Unique Email-id need to be entered!');
                    }
                }
                if(con.email4__c !=null) { 
                    if(con.email4__c == con.email || con.email4__c == con.email2__c || con.email4__c == con.email3__c || con.email4__c == con.email5__c) {
                        con.email4__c.addError('Unique Email-id need to be entered!');
                    }
                }
                if(con.email5__c != null ) {
                 
                     if(con.email5__c == con.email || con.email5__c == con.email3__c || con.email5__c == con.email4__c || con.email5__c == con.email2__c) {
                        con.email5__c.addError('Unique Email-id need to be entered!');
                    }    
               }  
           }
        }
        catch(Exception ex)    {
            System.debug('Error Occurred: ' + ex.getMessage());
        }
        finally {
            populateAccountNameForPartnerUser(conList,uList,pList);
        }
    }
    
    public static void populateAccountNameForPartnerUser(List<Contact> conList, List<User> uList, List<Profile> pList)  {
        
        // 1 SOQL Query 
        if(pList != null && pList.size() == 1 && uList != null && uList.size() == 1)    {
            if((pList[0].Name == 'City Council') || (pList[0].name == 'Neighborhood Liaison') || (pList[0].name == 'Police Department Liaisons')){
                for(Contact c : conList) {              
                    try {
                        if(uList[0].AccountId != null){
                            c.AccountId = uList[0].AccountId;  
                        }
                    } catch(Exception e) {
                        c.addError(e.getMessage());
                    }
                }    
            } 
        }
    }
    
    public static void accountNameUpdate(List<ID> conIDList, List<User> uList, List<Profile> pList) {
        List<Contact>conList = [Select id, Name, Email, AccountID from Contact where id in: conIDList];
        List<Account> citizen = [select id from Account where name = 'City of Philadelphia' LIMIT 1];
        List<Contact> conToUpdate = new List<Contact>();    
        if (Test.isRunningTest() && citizen.isEmpty())
            return;                
        for(Contact c : conList) {
            //set contact as a citizen
            if (c.AccountId == null && citizen != null && citizen.size() == 1) {
                    c.AccountId = citizen[0].Id;
                    conToUpdate.add(c);
            }
        }
        
        if(conToUpdate != null && conToUpdate.size() > 0)
            Database.Update(conToUpdate);
    }

}