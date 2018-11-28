public class CustomCaseController {
    
    @AuraEnabled
    Public static String createCase(Case caseObj,String recName,String addrId){
        RecordType rt = [SELECT Id FROM RecordType WHERE Name = : recName];
        System.debug('caseObj' +caseObj);
        caseObj.RecordTypeId = rt.id;
        caseObj.System_ID__c = addrId;
        caseObj.status ='New';
        if(caseObj.Has_a_Utility_Company_Worked_at_Location__c == 'No')
        {
            caseObj.Utility_Company__c = '';
        }
        try{
            insert caseObj;
        }
        catch(Exception e)
        {
            System.debug('Something went wrong ' + e.getMessage());
        }
        String idString = '';
        if(caseObj.id != null)
        {
            idString = caseObj.id;
        }
        
        return idString;        
    }
    
    
  /*  @AuraEnabled
    public static Id uploadFile(String fileName, String base64Data, String contentType) { 
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment a = new Attachment();
        a.parentId = 'a0029000002qwdAAAQ';
        
        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType; 
        insert a;
        System.debug(a.Id);
        return a.Id;
    }*/
    
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks   
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
        
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        
        insert oAttachment;
        
        Community_Case__c cc = [SELECT Id, Has_Attachments__c FROM Community_Case__c WHERE Id =:parentId];
        cc.Has_Attachments__c = true;
        update cc;
        
        
        return oAttachment.Id;
        
        
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        
        update a;
    }
    
    @AuraEnabled
    Public static String takeCMX(String recId){
        String cmx = 'Residential';
        String unitNumber = '';
        Community_Case__c c = new Community_Case__c();
        c = [SELECT Id, zoning__c, Unit_Number__c,Street_Address__c FROM Community_Case__c WHERE Id =:recId];
        if(c != null)
        {
            if(c.zoning__c == 'CMX-5')
            {
                cmx = 'Commercial';
            }
            if(c.Unit_Number__c !=null)
                unitNumber = c.Unit_Number__c;
            
            cmx = cmx + '++++'+unitNumber+ '++++'+c.Street_Address__c;
        }
        return cmx;
        
    }
    
    @AuraEnabled
    Public static String takeAddress(String recId){
        
        String addr = '';
        
        Community_Case__c c = new Community_Case__c();
        c = [SELECT Id, zoning__c, Unit_Number__c,Street_Address__c FROM Community_Case__c WHERE Id =:recId];
        if(c != null)
        {
            addr = c.Street_Address__c;
        }
        return addr;
        
    }
    
     @AuraEnabled
    Public static String takePolice(String recId){
        
        String police = '';
        
        Community_Case__c c = new Community_Case__c();
        c = [SELECT Id, zoning__c, Unit_Number__c, Street_Address__c, Police_District__c,Sanitation_District__c  FROM Community_Case__c WHERE Id =:recId];
        if(c != null)
        {
            police = c.Street_Address__c + '++++' + c.Police_District__c + '++++' + c.Sanitation_District__c  ;
        }
        return police;
        
    }
    
}