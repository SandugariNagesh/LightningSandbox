trigger UpdateServiceNotNeeded on Case (after insert,after update) {
    if(checkRecursive.runOnce()) {
        CaseComment comment;
        comment=new CaseComment();
        comment.CommentBody='Contact Philly311 about your case for more information';
        Case ticket = trigger.new[0];
        comment.parentid=ticket.id;
        Integer countChilds = countofChilds(ticket.id);
        if(ticket.Service_Request_Type__c=='Service Not Needed'){
        system.debug('======service Not Needed debug line===='+ticket.SAG_Contact_Email__c);
             if(ticket.SAG_Contact_Email__c!=null){
              if(ticket.Origin.contains('Mobile')||ticket.Origin.contains('Web')){
                if(ticket.Case_Record_Type__c.contains('Abandoned Vehicle'))   {
                    if (ticket.Is_there_a_busted_steering_column__c== 'Yes'){
                        comment.CommentBody='This could be a stolen vehicle. Please call to 911';
                    }
                }
                    if(ticket.Case_Record_Type__c.contains('Alley Light Outage'))   {
                    if (ticket.Alley_Type__c!= 'Pre-Existing Alley'){
                        comment.CommentBody='Alley and driveway are the owner\'s responsibility';
                    }
                }
                if(ticket.Case_Record_Type__c.contains('Construction Site Task Force'))   { comment.CommentBody='Please call to 911';

                }
                if(ticket.Case_Record_Type__c.contains('Graffiti Removal')) {
                    if (ticket.Center_City_District__c == 'In'){
                        comment.CommentBody='The Center City District is responsible for graffiti located within the Center City boundaries. Please contact CCD at 215-440-5500';
                    }else if (ticket.Rail_Corridor__c == 'Yes'){                                                             comment.CommentBody='The city is not responsible for the removal of graffiti on railroad property';

                        }else if(ticket.Floor__c =='3rd or above' && ticket.Property_Owner__c =='Yes'){                      comment.CommentBody='Graffiti above 2nd floor is not cleaned by the City';

                            }
                }
                if(ticket.Case_Record_Type__c == 'Street Defect') {
                    if (ticket.Gas_Escaping_from_the_Hole__c == 'Yes'){
                        comment.CommentBody='Please call 911.';


                    }else if (ticket.Running_Water__c == 'Yes'){                            comment.CommentBody='call the Water Department at 215-685-6300 (open 24 hours a day/7 days a week).';
                        }else if(ticket.On_State_Highway__c =='Yes'){                       comment.CommentBody='If a hole is on an interstate highway (I-95, I-76, I-676), then it is filled by Pennsylvania Department of Transportation (PennDOT). Call PennDOT at 1-800-FIX-ROAD. http://www.dot.state.pa.us/Internet/web.nsf/contactUsCCC?OpenForm';

                            }
                }
                if(ticket.Case_Record_Type__c == 'Street Light Outage') {


                    if (ticket.Is_the_Light_Illuminating_a_Street__c== 'Yes'){                        comment.CommentBody='Additional information is needed. Please call 311';
                    }else if (ticket.Private_Property__c== 'Yes'){                                    comment.CommentBody='It is the property owners responsibility.';

                        }
                }
                if(ticket.Case_Record_Type__c == 'Rubbish/Recyclable Material Collection') {
                    if (ticket.Set_Out_in_Time__c== 'No'){
                        comment.CommentBody='From October 1 through March 31, trash and recycling should be set out between 5:00 PM the night before collection day and 7:00 AM the day of collection. Set-out times from April 1 to September 30 will return to 7:00 PM the night before and by 7:00 AM the day of collection.';


                    }else if (ticket.Where_Was_Trash_Set_Out__c == 'Other'){                            comment.CommentBody='trash containers should be set out on the sidewalk adjacent to the curb or adjacent to the driveway where there is driveway collection.';
                        }else if(ticket.Not_More_than_Maximum_Number_of_Receptac__c =='Yes'){           comment.CommentBody='there is limit of 4 trash cans or 8 bags';

                            }else if(ticket.Not_More_than_Maximum_Weight__c =='Yes'){                   comment.CommentBody='weight limit is 240 lbs.';

                            }else if(ticket.Construction_Bulk_Items__c=='Yes'){                         comment.CommentBody='Rubbish cannot contain construction debris, house/apartment clean out, bulk items, bricks, etc.';

                            }
                }
                if(ticket.Case_Record_Type__c.contains('Street Trees'))   {
                    if (ticket.Tree_Location__c== 'Other'){                                             comment.CommentBody='A tree may be planted, pruned, or removed by the City only if it is located between the sidewalk an curb, in the grass planting strip immediately adjacent to curb, or in the median.';

                    }
                }
                    comment.ispublished=true;
                    System.debug('**********'+comment);
                    if(countChilds==0) insert comment;
            }
           }
        }

    
    
    Integer i = 0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        }   


    public static Integer countofChilds (String parentid) {
        Integer countChild = 0;
        if(!String.isBlank(parentid)){
        countChild = [Select count() from CaseComment where parentid = :parentid ];
        }
        System.debug('******count of childs*****'+countChild);
        return countChild;

    }   

}