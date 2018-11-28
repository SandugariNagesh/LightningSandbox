trigger triggerOnContact on Contact (before insert, after insert, before update, after update) {

    List<User> uList = [Select Id, AccountId from User where  id=: userInfo.getUserId()]; 
    List<Profile> pList = [select Id, Name from profile where id=: userInfo.getProfileID()];
        
    if(Trigger.isBefore)    {
        ContactWrapperClass.checkAnonAnon(Trigger.New, uList, pList);
    }
    else if(Trigger.isAfter){
        
        List<ID> conIDList = new List<ID>();
        for(Contact c: Trigger.New)
            conIDList.add(c.Id);
        ContactWrapperClass.accountNameUpdate(conIDList, uList, pList);
        // only run for single-record updates
        if (Trigger.new.size() != 1)
            return; 
        //ContactWrapper.AddressAndAreas(Trigger.new[0].id);
    }
}