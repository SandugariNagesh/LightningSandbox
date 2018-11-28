@isTest
public class PostMethodImplementationControllerTest{
    
    static testMethod void myUniteTest() {
       Test.startTest();
        PostMethodImplementationController PostMthdCntr = new PostMethodImplementationController();
        PostMthdCntr.orgainzation='Test';
        PostMthdCntr.appName = 'test';
        PostMthdCntr.productUrl = 'asdqwe'; 
        PostMthdCntr.firstName = 'Test';
        PostMthdCntr.lastName = 'Test';
        PostMthdCntr.email = 'asdas@as.as';
        PostMthdCntr.phone = '12313413';
        PostMthdCntr.url = '';
        PostMthdCntr.key = '';
        
        PageReference pageref = PostMthdCntr.save();
       Test.stopTest();
    }
    static testMethod void myUniteTest2() {
        Test.startTest();
        APIkey_Register__c apiKey = new APIkey_Register__c() ;
        apiKey.App_Name_Open311__c = 'Test';
        apiKey.Email_Open311__c = 'asdas@as.as';
        apiKey.First_Name_Open311__c = 'Test';
        apiKey.Last_Name_Open311__c = 'Test';
        apiKey.Organization_Open311__c = 'Test';
        apiKey.Phone_Open311__c = 12313413;
        apiKey.url_Open311__c = 'asdqwe';
        Insert(apiKey);
        
        PostMethodImplementationController PostMthdCntr = new PostMethodImplementationController();
            PostMthdCntr.orgainzation='Test';
        PostMthdCntr.appName = 'test';
        PostMthdCntr.productUrl = 'asdqwe'; 
        PostMthdCntr.firstName = 'Test';
        PostMthdCntr.lastName = 'Test';
        PostMthdCntr.email = 'asdas@as.as';
        PostMthdCntr.phone = '12313413';
        PostMthdCntr.url = '';
        PostMthdCntr.key = '';    
                PageReference pageref = PostMthdCntr.save();
                PostExtensionController PostExtCntr = new PostExtensionController(PostMthdCntr); 
        Test.stopTest();
    }
}