trigger CustomerTrigger on Case (before insert,after insert) {
    
    String communityCaseId, caseContactEmail;
    if(Trigger.isBefore)
    {
        for(Case c : Trigger.new)
        {
            
            //c.Is_Case_Created_From_Customer_Community__c = true;
            if(c.system_id__c != null)
            {
                c.ByPass_VR_WF__c = true;
                communityCaseId = c.system_id__c ;  
                c.origin = 'Web';
                if(c.Customer_Email__c != null)
                {
                    caseContactEmail = c.Customer_Email__c;
                }
                /*

*/
            }
            
        }
        
        map<String, id> contactEmailIdMap = new map<String, id>();
        if(caseContactEmail  != null)
        {
            for(contact con : [SELECT id, email FROM Contact WHERE email =: caseContactEmail ])
            {
                if(con.id != null)
                    contactEmailIdMap.put(con.email, con.id); 
            }
        }
        
        if(communityCaseId  != null)
        {
            map<id,Community_Case__c> communityCaseMap = new  map<id,Community_Case__c>([SELECT id, normalized__c, Center_City_District__c, match_type__c,
                                                                                         Street_Address__c, ZIP_4__c, Zip_Code__c, Council_District_No__c, Police_District__c,
                                                                                         Pickup_Day__c, Sanitation_District__c, PhillyRising__c, Ladder_Local__c, Engine_Local__c,
                                                                                         Lat__c, Long__c
                                                                                         FROM  Community_Case__c
                                                                                         WHERE id =: communityCaseId ]);
            
            
            if(!communityCaseMap.isEmpty())
            {
                for(Case cs : Trigger.New)
                {
                    if(cs.system_id__c != null)
                    {
                        if(communityCaseMap.containsKey(cs.system_id__c))
                        {
                            cs.Center_City_District__c = communityCaseMap.get(cs.system_id__c).Center_City_District__c;
                            cs.Street__c =  communityCaseMap.get(cs.system_id__c).normalized__c;  
                            cs.zip_code__c = communityCaseMap.get(cs.system_id__c).Zip_Code__c ;
                            
                            cs.Council_District_No__c= communityCaseMap.get(cs.system_id__c).Council_District_No__c;
                            cs.Police_District__c= communityCaseMap.get(cs.system_id__c).Police_District__c;
                            cs.Pickup_Day__c= communityCaseMap.get(cs.system_id__c).Pickup_Day__c;
                            cs.Sanitation_District__c= communityCaseMap.get(cs.system_id__c).Sanitation_District__c;
                            cs.PhillyRising__c = communityCaseMap.get(cs.system_id__c).PhillyRising__c ;
                            cs.Ladder_Local__c= communityCaseMap.get(cs.system_id__c).Ladder_Local__c;
                            cs.Engine_Local__c = communityCaseMap.get(cs.system_id__c).Engine_Local__c  ;
                            cs.User_input_address__c = communityCaseMap.get(cs.system_id__c).Street_Address__c;
                            cs.Latitude__c = communityCaseMap.get(cs.system_id__c).lat__c;
                            cs.Longitude__c = communityCaseMap.get(cs.system_id__c).long__c;
                            if(!Test.isRunningTest()){
                                cs.Centerline_2272x__c = decimal.valueof(cs.Latitude__c );
                                cs.Centerline_2272y__c = decimal.valueof(cs.Longitude__c );
                            }
                            
                        }
                        
                        if(contactEmailIdMap != null && !contactEmailIdMap.isEmpty() && cs.Customer_Email__c != null && contactEmailIdMap.containsKey(cs.Customer_Email__c))
                        {
                            cs.contactId = contactEmailIdMap.get(cs.Customer_Email__c);
                        }
                    }
                }
            }
            
        }
    }
    
    if(Trigger.isAfter)
    {
        /* id systemID, caseId;
        
        // process for one record at a time
        for(Case cs : Trigger.New)
        {
            if(cs.system_id__c != null)
            {
                systemID = cs.system_id__c;
                caseId = cs.id;
            }
        }
        
        if(systemID != null && caseId != null)
        {
            UpdateInFuture.updateAttachment(caseId);
        }
        
        
        
        id systemID, caseId;

// process for one record at a time
for(Case cs : Trigger.New)
{
if(cs.system_id__c != null)
{
systemID = cs.system_id__c;
caseId = cs.id;
}
}

if(systemID != null && caseId != null)
{

list<attachment> attachmentListForCase = new list<attachment>();
System.debug('systemID : ' + systemID);

for(attachment attch : [SELECT id, contenttype, body, name FROM attachment WHERE parentId =: systemID])
{
Attachment csAttch = new Attachment();
csAttch.contenttype = attch.contenttype;
csAttch.body = attch.body;
csAttch.name  = attch.name;
csAttch.parentId = caseId;

attachmentListForCase.add(csAttch);
}

if(attachmentListForCase.size() > 0)
{
insert attachmentListForCase;
}
}*/
    }        
}