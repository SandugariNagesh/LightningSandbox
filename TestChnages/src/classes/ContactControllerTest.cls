@isTest(SeeAllData=true) 
public class ContactControllerTest{
    
    static testMethod void ContactControllertest(){
        user user1 = [SELECT Id,name FROM User WHERE ContactId != null and isActive = true limit 1];
        Contact objContact = [SELECT Name FROM Contact LIMIT 1];
        
        System.runAs(user1){
        
        ApexPages.StandardController sc = new ApexPages.StandardController(objContact);

        ContactController conCtr = new  ContactController(sc);
        PageReference conpage = ContactController.controller1();    
    } }
    
}