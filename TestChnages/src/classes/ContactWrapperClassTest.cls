@isTest(SeeAllData = false)
public class ContactWrapperClassTest {

    public static void testData(){
        Profile p = [Select id, Name from Profile where Name IN ('City Council Partner Logins') LIMIT 1];
      //  User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,
       //                    TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
       // Insert u1;
        Account philly = new Account(name = 'City of Philadelphia');
        insert philly;
        Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email2@gmail.com', Email3__c='email3@gmail.com',Email4__c='email4@gmail.com',Email5__c='email5@gmail.com');
        insert c;
    }
    
    public static testMethod void AccountNameUpdateTest() {
       testData();
       User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
      // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
       System.runAs(u){
            
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email6@gmail.com', Email2__c = 'email7@gmail.com', Email3__c='email8@gmail.com',Email4__c='email9@gmail.com',Email5__c='email10@gmail.com'); 
            Insert(c);
            Contact updatedCon=[Select Account.Name from contact where Id=:c.id];
            System.assertEquals('City of Philadelphia', updatedCon.Account.Name);
       }    
       
    }

    public static testMethod void UniqueEmailTest(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email@gmail.com', Email2__c = 'email@gmail.com', Email3__c='email1@gmail.com',Email4__c='email2@gmail.com',Email5__c='email3@gmail.com');
  //          Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
  //          Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
  //          Contact c3 = new Contact(FirstName = 'ANON', LastName = 'ANON');
  //          Contact c4 = new Contact(LastName = 'ANON ANON');
  //          List<Contact> cList = new List<Contact>();
  //          cList.add(c);
  //          cList.add(c1);
  //          cList.add(c2);
  //          cList.add(c3);
  //          cList.add(c4);
  //          Insert(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Unique Email-id need to be entered!'));
            }
        }    
    }
    
    public static testMethod void UniqueEmailTest1(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email@gmail.com',Email4__c='email2@gmail.com',Email5__c='email3@gmail.com');
  //          Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
  //          Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
  //          Contact c3 = new Contact(FirstName = 'ANON', LastName = 'ANON');
  //          Contact c4 = new Contact(LastName = 'ANON ANON');
  //          List<Contact> cList = new List<Contact>();
  //          cList.add(c);
  //          cList.add(c1);
  //          cList.add(c2);
  //          cList.add(c3);
  //          cList.add(c4);
  //          Insert(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Unique Email-id need to be entered!'));
            }
        }    
    }
    
    public static testMethod void UniqueEmailTest2(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email2@gmail.com',Email4__c='email@gmail.com',Email5__c='email3@gmail.com');
  //          Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
  //          Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
  //          Contact c3 = new Contact(FirstName = 'ANON', LastName = 'ANON');
  //          Contact c4 = new Contact(LastName = 'ANON ANON');
  //          List<Contact> cList = new List<Contact>();
  //          cList.add(c);
  //          cList.add(c1);
  //          cList.add(c2);
  //          cList.add(c3);
  //          cList.add(c4);
  //          Insert(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Unique Email-id need to be entered!'));
            }
        }    
    }    
    
     public static testMethod void UniqueEmailTest3(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email2@gmail.com',Email4__c='email3@gmail.com',Email5__c='email@gmail.com');
  //          Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
  //          Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
  //          Contact c3 = new Contact(FirstName = 'ANON', LastName = 'ANON');
  //          Contact c4 = new Contact(LastName = 'ANON ANON');
  //          List<Contact> cList = new List<Contact>();
  //          cList.add(c);
  //          cList.add(c1);
  //          cList.add(c2);
  //          cList.add(c3);
  //          cList.add(c4);
  //          Insert(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Unique Email-id need to be entered!'));
            }
        }    
    }    
    
    public static testMethod void EmailUserRepititionTest(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
        try   
           {          
            Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
            Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
              Insert(c1);
              Insert(c2);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Unique Email-id need to be entered!'));
            }
        }    
    }
    
    public static testMethod void ANONTest1(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            
            try
            {
            Contact con = new Contact(FirstName = 'ANON', LastName = 'ANON');
            Insert(con);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Contact Name Not Permissible'));
            }
        }    
    }    
    
    public static testMethod void ANONTest2(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {

            Contact c3 = new Contact(LastName = 'ANON ANON');
  
            Insert(c3);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Contact Name Not Permissible'));
            }
        }    
    }

    public static testMethod void ANONTest3(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
           try
            {
            Contact c = new Contact(FirstName = 'Ishant', LastName = 'Sharma', Email='Testing@gmail.com');
            Insert(c);
            c.Email='anonymous@publicstuff.com';
            update(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('You Dont Have Permission To Update This Contact'));
            }
        }    
    }
    
     public static testMethod void BulkTest(){
        testData();
        User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
       // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
        System.runAs(u){
            try
            {
            Contact c = new Contact(FirstName = 'Robin', LastName = 'Sharma', Email='email@gmail.com');
            Contact c1 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com', Email2__c = 'email1@gmail.com', Email3__c='email1@gmail.com',Email4__c='email1@gmail.com',Email5__c='email1@gmail.com');
            Contact c2 = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email1@gmail.com');
            Contact c3 = new Contact(FirstName = 'ANON', LastName = 'ANON');
            Contact c4 = new Contact(LastName = 'ANON ANON');
            List<Contact> cList = new List<Contact>();
            cList.add(c);
            cList.add(c1);
            cList.add(c2);
            cList.add(c3);
            cList.add(c4);
            Database.Insert(cList);
            }
            catch(System.DMLException e)
            {
            System.Assert(e.getMessage().contains('Insert failed'));
            }
        }    
    }
    
     public static testMethod void AccountNameForPartnerTest() {
       testData();
      // User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
      User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council Partner Logins' and isActive =true LIMIT 1];
       System.runAs(u1){
            
            Contact c = new Contact(FirstName = 'Saurav', LastName = 'Sharma', Email='email6@gmail.com', Email2__c = 'email7@gmail.com', Email3__c='email8@gmail.com',Email4__c='email9@gmail.com',Email5__c='email10@gmail.com'); 
            Insert(c);
            Contact updatedCon=[Select Account.Name from contact where Id=:c.id];
            System.assertEquals('City of Philadelphia', updatedCon.Account.Name);
       }    
       
    }
    
    
     public static testMethod void NullTest() {
       testData();
       User u = [SELECT ID, UserName FROM User WHERE Profile.Name ='SFDC Administrators' and isActive =true LIMIT 1];
      // User u1 = [SELECT ID, UserName FROM User WHERE Profile.Name ='City Council' and isActive =true LIMIT 1];
       System.runAs(u){
            try
            {
            Contact c = new Contact(); 
            Insert(c);
            }
            catch(Exception e)
            {
            System.Assert(e.getMessage().contains('Attempt to de-reference a null object'));         
            }
       }    
       
    }           
}