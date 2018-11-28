@Istest
Public class SurveyManagerControllerTest{

static testmethod void SurveyManagerMethod()
{

Survey__c s=new Survey__c();
s.name='Test';
s.Submit_Response__c='TestResponse';
Insert s;

ApexPages.StandardController sc = new ApexPages.StandardController(s);

 SurveyManagerController a=new SurveyManagerController(sc);
 
 a.getEditCSS();


}
}