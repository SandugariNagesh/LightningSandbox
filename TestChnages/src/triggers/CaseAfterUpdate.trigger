Trigger CaseAfterUpdate on Case (after insert, after update) {
  system.debug('** CaseAfterUpdate.trigger **');

  String[] caseIds = new String[]{};

  for (Case aCase : Trigger.new) {
    if (
      String.IsNotBlank(aCase.street__c) &&
      (
        aCase.Centerline_2272x__c == 0 ||
        aCase.Centerline_2272y__c == 0 ||
        aCase.Centerline_2272x__c == null ||
        aCase.Centerline_2272y__c == null
      ) &&
      // exclude l&i escalations
          aCase.Case_Record_Type__c != 'LI Escalation' &&
      // exclude cases created via email
          aCase.Origin != 'Email' &&
      // exclude Information Request
          aCase.Case_Record_Type__c != 'Information Request' &&
      // exclude Revenue Escalation
          aCase.Case_Record_Type__c != 'Revenue Escalation' 
      ) {
      caseIds.add(aCase.id);
    }
  }

  // system.debug(caseIds);

 //  CaseWrapper.ConvertCenterlineTo2272(caseIds);

   CaseWrapperAis.regeocode(caseIds);
}