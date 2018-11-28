global class IntegrationRelatedTask    {

    global void parseDetailsFieldfromPS(Case cs, Group gr)    {
        System.debug('IntegrationRelatedTask.parseDetailsFieldfromPS Method.');   
        System.debug('Description before parsing: ' + cs.Description);
        String descr = null,oldDesc = null;
        //Support ticket fix #09437878 start
        list<String> descNewSplit = new list<String>();
        //Support ticket fix #09437878 start end 
        descr = cs.Description;
        oldDesc = cs.Description;
        List<String> descSplit = new List<String>();
        List<String> updatedDescSplit = new List<String>();
        Map<String, String> fieldMap = new Map<String, String>();
        List<PS_Fields_Mapping__c> fieldList = [Select Name ,Field_Name__c, Value__c, Length__c from PS_Fields_Mapping__c];
        Map<String, Integer> fieldLength = new Map<String, Integer>();
        if(fieldList != null && fieldList.size() > 0)    {
            for(PS_Fields_Mapping__c f : fieldList)    {
                fieldMap.put(f.Field_Name__c,f.Value__c); 
                if(f.Length__c != null)  
                    fieldLength.put(f.Field_Name__c, Integer.valueOf(f.Length__c));
            }
        }
        
        System.debug('Field Map: ' + fieldMap);
        if(descr == null)
            descr = '  ';
        integer index = descr.toLowerCase().indexOf('custom fields:');
        System.debug('Description coming from PS: ' + descr);
        System.debug('Index of Custom Field: ' + index);
        
        //start of changes made for support ticket 09158078
        if(cs.Service_Request_Type__c == null)  {
            cs.Validated_Cases_from_PS__c = TRUE;
            cs.OwnerId = gr.Id;
        }
         
        if((cs.Case_Record_Type__c == 'Abandoned Vehicle')&&((cs.Street__c.contains(' & ')) || (cs.Street__c.contains(' @ ')) || (cs.Street__c.containsIgnoreCase(' and ')))) {
            cs.Validated_Cases_from_PS__c = TRUE;
            cs.OwnerId = gr.Id;
        }
        //end of changes made for support ticket 09158078 
        
        if(index != -1)    {
           String val1 = null, val2 = null, val3 = null, val4 = null, val2a = null, val3a = null;
           Integer leng = null; 
           descr = descr.subString(index, descr.length());
           oldDesc = oldDesc.subString(0,index);
           descNewSplit = descr.split('\n');
           // Support ticket fix #09437878 start
           for(integer i = 0 ; i<descNewSplit.size()-1; i++){
               if(descNewSplit[i].contains(':')){
                   if(!descNewSplit[i+1].contains(':')){
                   descNewSplit[i+1] = descNewSplit[i] +' '+ descNewSplit[i+1];
                   descNewSplit.remove(i);
                   i = i-1;
                   }
               }
           }
           descSplit = descNewSplit;
           //descSplit = descr.split('\n');
           //Support ticket fix #09437878 end
           
           System.debug('List Values.');
           for(String d : descSplit)    { 
               if(d.trim() != '' && d.indexOf(':') != -1 && !d.trim().equalsIgnoreCase('Custom fields:'))    {
                   val1 = d.subString(0,d.indexOf(':')).trim();
                   val2 = fieldMap.get(val1);
                   val2a = null;
                   leng = 0;
                   leng = fieldLength.get(val1);
                   if(val2 != null && val2.contains(';'))   {
                       val2a = val2.subString(val2.indexOf(';')+1, val2.length());
                       val2 = val2.subString(0,val2.indexOf(';'));
                       System.Debug('API Name:' + val2 + '  ' + val2a);
                       System.Debug('Field Length:' + leng);
                   }    
                   val3 = d.subString(d.indexOf(':')+1, d.length()).trim();
                   System.debug('Field: ' + val1 + '  API Name: ' + val2 + '  Value: ' + val3);
                   if(val2 != null && val3 != null)    {
                       System.debug('Intializing Field value for: ' + val2);
                       if(val2.equals('Type_of_Materials__c'))    {
                           val4 = cs.Type_of_Materials__c;
                           if(val4 != null)
                               val3 = val3 + ';' + val4;                                       
                       }
                      //start of changes made for support ticket 09157716
                       try
                       {
                            // Support Ticket #09418722 Fix, resolved the mapping issue for make & model field where data was  getting lost  
                            if(val2a != null && val3.contains('&'))   {
                                val3a = val3.subString(val3.indexOf('&')+1,val3.length());
                                val3 = val3.subString(0,val3.indexOf('&')-1);
                                cs.put(val2,val3);
                                if(val3a != null)
                                    cs.put(val2a,val3a); 
                            }
                            else {
                                if(val2.equals('How_Many_Trees__c'))    {
                                    Integer val5 = integer.valueOf(val3);
                                    cs.put(val2,val5);
                                }
                                else    {
                                    if(leng >= val3.length())
                                        cs.put(val2,val3);
                                    else {
                                        cs.Validated_Cases_from_PS__c = TRUE;
                                        cs.OwnerId = gr.Id;
                                        updatedDescSplit.add(d.trim());
                                    }
                                            
                                }          
                            }    
                       }
                       catch(Exception e)
                       {
                            System.debug('Updating updatedDescSplit List with: ' + d.trim()); 
                            cs.Validated_Cases_from_PS__c = TRUE;
                            cs.OwnerId = gr.Id;
                            updatedDescSplit.add(d.trim());
                       }
                       //end of changes made for support ticket 09157716                      
                   }
                   else   {
                      System.debug('Updating updatedDescSplit List with: ' + d.trim()); 
                      updatedDescSplit.add(d.trim());
                   }   
               }    
               /* Support Ticket #09418722 added else part 
                   If text was present in new line after 'Custom Field',it was not flowing from PS to SFDC Comment field.
               */
               else {
                   System.debug('Updating updatedDescSplit List with: ' + d.trim()); 
                   updatedDescSplit.add(d.trim());
               }
            }
        } 
           
        if (updatedDescSplit != null & updatedDescSplit.size() > 0 )    {
            oldDesc += '\n Custom Fields: ';
            String Name = '';
            if(cs.ContactID != null)    {
                List<Contact> con = [Select id, name from Contact where id =: cs.ContactID];
                if(con != null && con.size() != 0)
                    Name = con[0].Name;
            }
            System.debug('Contact Name: ' + Name);    
            for(String temp : updatedDescSplit)    {       
                if(temp.toLowerCase().indexOf('your name') != -1 )    {
                    //if(Name.equals('Anonymous') || Name == '' || Name.equals('PublicStuff User'))   
                        //oldDesc += '\n' + temp;    
                }                              
                else 
                    oldDesc += '\n' + temp;               
            }
        }
       
        if(oldDesc != null && oldDesc.toLowerCase().indexOf('custom fields:') != -1 && oldDesc.toLowerCase().indexOf('custom fields:') + 20 > oldDesc.length())
            oldDesc = oldDesc.subString(0,oldDesc.toLowerCase().indexOf('custom fields:')).trim();
        System.debug('Updating Description: ' + oldDesc);
        cs.Description = oldDesc;
        cs.PublicStuff_Custom_Fields__c = descr.trim();
    }
    
    global void updateDetailsField(Case cs, Group gr)    {
        
        System.debug('IntegrationRelatedTask.updateDetailsField1 Method.');
        String details = '';        
        if(cs.Description == null)
            cs.Description = '';
        if(cs.Media_URL__c != null) 
            details = cs.Media_URL__c + '\n' +  '\r ';
        
        details += cs.Description;    
        List<Required_Streets_Field__c> reqdStFields = Required_Streets_Field__c.getall().values();
        Map<String,String> f = new Map<String,String>();
        
        if( reqdStFields  != null && reqdStFields .size() >0)    {
            for(Required_Streets_Field__c r : reqdStFields )    {
                if(r.Case_Record_Type__c.trim() == cs.Case_Record_Type__c && r.Required__c == true)  
                    f.put(r.API_Name__c.trim(),r.Label__c.trim());
            }
        }
        
        System.debug('Map : ' + f); 
        String variable = null, value = null;
        if(f!= null && f.size()>0)    {
            for(String key : f.keyset())    {
                variable=f.get(key);
                value = String.valueOf(cs.get(key));
                System.debug(key + '  ' + variable + '  ' + value);
                
                // Support Ticket #08867027 Marion asked for all fields value even if it is null
              //  if(value != null && value != '')    
                    details += '\n' + variable + ': ' + value + '. ';
            }
        }
        
        if(cs.PublicStuff_Customer_Details__c != null)
            details += '\n' +  '\r ' + cs.PublicStuff_Customer_Details__c;
            
        if(cs.Ticket__c == null && cs.Streets_request_ID__c == null)    {
            if(details.length() > 500)    {
                integer temp =0, temp2 = 0, length = 450;
                temp = details.substring(0, 465).lastIndexOf('\n');
                temp2 = details.substring(0, 465).lastIndexOf('.');
                temp = ( temp>temp2 ? temp : temp2);
                if(details.length()- temp >  450 && cs.Customer_Request_ID__c == null) 
                    cs.Description.addError('Max Length Exceeded by ' + String.valueOf( details.length() - temp - 450) + ' characters.');
                else if(details.length()- temp >  450 && cs.Customer_Request_ID__c != null) {
                   
                 /*   if(cs.Media_URL__c != null)
                        length -= cs.Media_URL__c.length();
                        
                    if(cs.PublicStuff_Customer_Details__c!= null)
                        length -= cs.PublicStuff_Customer_Details__c.length();    
                        
                    cs.Description = cs.Description.subString(0,length);
                    cs.Validated_Cases_from_PS__c = TRUE;
                    cs.OwnerId = gr.Id;*/
                }   
            }
        }
        cs.Details__c = details;    
    }
        
}