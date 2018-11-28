public class SubmitRequestTypeOptionsController {
    
    @AuraEnabled
    public static List<recordType> getCaseRecordTypes()
    {
        /* list<recordType> recordTypeList = [SELECT id, name, developername FROM recordType WHERE sObjectType = 'Case' AND isActive = true];
if(!recordTypeList.isEmpty()){
return recordTypeList;
}
*/
        List<recordType> recList = new List<recordType>();
        List<SelectOption> recordTypes = new List<SelectOption>();
        List<Id> idList = new List<Id>();
        for(RecordTypeInfo info: case.SObjectType.getDescribe().getRecordTypeInfos()) {
            if(info.isAvailable()) {
                String rec =  info.getName();
                System.debug('rec : ' + info.getRecordTypeId());
                String recId = info.getRecordTypeId();
                if(recId != null && !recId.contains('AAA'))
                {
                    recordType rt = new recordType();
                    rt.Name = info.getName();
                    rt.DeveloperName = info.name;
                idList.add(recId);
                }
            }
        }
        if(idList.size()>0)
        {
            System.debug('recList : ' + recList);
           for(recordType rt : [SELECT Name, Developername, Description FROM recordType WHERE Id IN :idList] )
           {
               if(rt.Name == 'Maintenance Residential or Commercial')
                   rt.Name = 'Maintenance Residential'; 
               if(rt.Name == 'Street Defect')
               {
                   rt.Name = 'Pothole';
                   rt.DeveloperName = 'Pothole';
               }
              recList.add(rt);
           }
            return recList;
        }
        else
        {
            return null;
        }
    }
}