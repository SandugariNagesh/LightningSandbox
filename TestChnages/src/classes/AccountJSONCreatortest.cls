@isTest 
public class AccountJSONCreatortest 
{
 static testMethod void testMethod1() 
 {
 Account testAccount = new Account();
 testAccount.Name='Test Account' ;
 insert testAccount;

 Test.StartTest(); 
  ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
 // myControllerExtension testAccPlan = new myControllerExtension(sc);

  PageReference pageRef = Page.Account_JSON ; // Add your VF page Name here
  pageRef.getParameters().put('AccName', String.valueOf(testAccount.Name));
  Test.setCurrentPage(pageRef);
  AccountJSONCreator accJson = new AccountJSONCreator ();  
  string accjonstr = accJson.getJSON(); 
  //testAccPlan.save(); call all your function here
 Test.StopTest();
 }
}