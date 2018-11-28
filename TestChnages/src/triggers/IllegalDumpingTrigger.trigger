trigger IllegalDumpingTrigger on Case (before insert) {
system.debug('** Illegal dumping trigger trigger **');

  for (Case aCase : Trigger.new) {
    if (String.IsNotBlank(aCase.Description)){
          
          if(aCase.Description.contains('Large Crew & Heavy Machinery To Clean Up?: No')){
              aCase.Large_Crew_Heavy_Machinery_To_Clean_Up__c = 'No';
          }
          else if(aCase.Description.contains('Large Crew & Heavy Machinery To Clean Up?: Yes'))
          {
              aCase.Large_Crew_Heavy_Machinery_To_Clean_Up__c = 'Yes';
          }
    }
 
  }
  
}