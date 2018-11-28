@isTest
public class TestCustomCaseController {
    
    static testMethod void callcreateCase(){
        
        
        Community_Case__c  commCase = new Community_Case__c();
        commCase.zoning__c = 'CMX-5';
        commCase.Unit_Number__c = 'APT 5';
        commCase.Street_Address__c = '1234 Market Street'; 
        insert commCase;
        
        
        Case caseObj = new Case();
        caseObj.Has_a_Utility_Company_Worked_at_Location__c = 'No';
        caseObj.System_ID__c = commCase.Id;
        caseObj.Origin = 'Web';
        caseObj.ByPass_VR_WF__c = true;
        
        CustomCaseController.createCase(caseObj, 'Maintenance Residential or Commercial', commCase.Id);
        CustomCaseController.saveChunk(commCase.Id, 'Philly', 'blah blah', 'TXT', '');
        CustomCaseController.takeCMX(commCase.Id);
        CustomCaseController.takePolice(commCase.Id);
        String add =  CustomCaseController.takeAddress(commCase.Id);
        System.assertEquals('1234 Market Street', add);
        
        
        
        Case caseObj1 = new Case();
        caseObj1.Has_a_Utility_Company_Worked_at_Location__c = 'No';
        caseObj1.System_ID__c = commCase.Id;
        caseObj1.Origin = 'Web';
        caseObj1.ByPass_VR_WF__c = true;
        insert caseObj1;
        
        update commCase;
    }
}