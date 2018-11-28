trigger AccountNameUpdateTrigger on Contact (after insert,after update){

    Boolean noAccount = false;
    list<id> cid = new list<id>();
    for (Contact c : Trigger.new) {
        cid.add(c.id);
        if (c.AccountId == null) {
            noAccount = true;    
        break;
        }
    }
    
    if (noAccount) {
        Id profileId = userinfo.getProfileId();
        list<Profile> profileName=[Select Id from Profile where Id=:profileId];
        if ((ProfileName[0].Id=='00e11000000Lx2B')|| (ProfileName[0].Id == '00e11000000LxBS') || (ProfileName[0].Id=='00eG0000000zzC9')||(ProfileName[0].Id=='00eG0000000zzC7') ||(ProfileName[0].Id=='00eG0000000zJev')) {
            Account[] citizen = [select Id from Account where name = 'Neighborhood Liaisons'];
             Account[] citizen1 = [select Id from Account where name = 'Neighborhood Liaisons Contacts'];
            List<Contact> con = [Select id, AccountId from Contact where id in: cid];
            for(Contact c : con) {
                //set contact as a citizen
                try{
                if (c.AccountId == null) {
                    c.AccountId = citizen1[0].Id;
                    update c;
                    }
                    
                }
                catch(Exception e){}
                finally
                {
                 if (c.AccountId == null) {
                    c.AccountId = citizen1[0].Id;
                    update c;
                    }
                  }  
                }
              
        }
         else{
            Account[] citizen = [select id from Account where name = 'City of Philadelphia'];
            if (Test.isRunningTest() && citizen.isEmpty())
                return;
                
            List<Contact> con = [select id, AccountId from Contact where id in: cid];
            for(Contact c : con) {
                 //set contact as a citizen
                if (c.AccountId == null && citizen != null && citizen.size() > 0) {
                    c.AccountId = citizen[0].Id;
                    update c;
                }
            }
        }
    }
}