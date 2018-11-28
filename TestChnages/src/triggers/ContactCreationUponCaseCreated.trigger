trigger ContactCreationUponCaseCreated on Case (before insert) {
    set<String> emailAddresses = new set<String>();
    //First exclude any cases where the contact is set
    for (Case caseObj:Trigger.new) {
        if (caseObj.ContactId==null &&
            caseObj.SuppliedEmail!='')
        {
            emailAddresses.add(caseObj.SuppliedEmail);
        }
    }

    //Now we have a nice list of all the email addresses.  Let's query on it and see how many contacts already exist.
    List<Contact> listContacts = [Select Id,Email From Contact WHERE Email in :emailAddresses And email != null LIMIT 1000];
    Set<String> takenEmails = new Set<String>();
    for (Contact c:listContacts) {
        takenEmails.add(c.Email);
    }
    
    Map<String,Contact> emailToContactMap = new Map<String,Contact>();
    List<Case> casesToUpdate = new List<Case>();

    for (Case caseObj:Trigger.new) {
        if (caseObj.ContactId==null &&
         caseObj.Origin != 'Web' &&
         caseObj.Origin == 'Email' &&
            caseObj.SuppliedName!=null &&
            caseObj.SuppliedEmail!=null &&
            caseObj.SuppliedName!='' &&
            !caseObj.SuppliedName.contains('@') &&
            caseObj.SuppliedEmail!='' &&
           
            !takenEmails.contains(caseObj.SuppliedEmail))
        { 
        /* if ( 
          caseObj.SuppliedName=='' && 
          caseObj.SuppliedName==null ) {
          
          String leftPart = email.substringBefore('@');
          if(leftPart.size() == 1){
          String lastName = leftPartSplitted[0];
          */
            //The case was created with a null contact
            //Let's make a contact for it
            String[] nameParts = caseObj.SuppliedName.split(' ',2);
                if (nameParts.size() >= 1)
                {
                Contact cont ;
                if (nameParts.size()==1){
                           cont = new Contact(LastName=nameParts[0],
                                            Email=caseObj.SuppliedEmail,
                                            Autocreated__c=true);           
                }   
                else {
                            cont = new Contact(FirstName=nameParts[0],
                                            LastName=nameParts[1],
                                            Email=caseObj.SuppliedEmail,
                                            Autocreated__c=true);

            }
                emailToContactMap.put(caseObj.SuppliedEmail,cont);
                casesToUpdate.add(caseObj);
            }
        }
    }
    
    List<Contact> newContacts = emailToContactMap.values();
    insert newContacts;
    
    for (Case caseObj:casesToUpdate) {
        Contact newContact = emailToContactMap.get(caseObj.SuppliedEmail);
        
        caseObj.ContactId = newContact.Id;
    }
}