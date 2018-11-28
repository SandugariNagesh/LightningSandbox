@isTest
public class UpdateServiceNotNeededTest {
    public static testMethod void createCase (){
        
        CaseComment comment;
        comment=new CaseComment();
        comment.CommentBody='TEST';
        
        
        
    Contact cc=new Contact();
    cc.LastName='test';
    cc.Email='miguel123test.a.santana@phila.gov';
    insert cc;
        Case c = new Case();
        comment.parentid=c.id;
        c.ContactId=cc.id;
        c.Street__c = '1234 Market St';
        c.Case_Record_Type__c = 'Graffiti Removal';
        c.Center_City_District__c = 'In';
        //c.Contact.Email = 'miguel.a.santana@phila.gov';
        c.Service_Request_Type__c = 'Service Not Needed';
        c.Subject='Test';
        //c.SAG_Contact_Email__c='miguel.a.santana@phila.gov';
        c.Origin= 'Web';
        c.Case_Record_Type__c='Abandoned Vehicle';
        c.Is_there_a_busted_steering_column__c='Yes';
        test.starttest();
        GISAPIMock x=new GISAPIMock('https://www.google.com');
       Test.setMock(HttpCalloutMock.class,x);

        insert c;
        checkRecursive.run=true;
            c.Case_Record_Type__c='Graffiti Removal';
            c.Center_City_District__c = 'In';
            update c;
        checkRecursive.run=true;
            c.Case_Record_Type__c='Alley Light Outage';
            c.Alley_Type__c='New Alley';
            update c;
        checkRecursive.run=true;
            c.Case_Record_Type__c='Rubbish/Recyclable Material Collection';
        c.Set_Out_in_Time__c= 'No';
            update c;
            checkRecursive.run=true;
            c.Case_Record_Type__c='Street Defect';
            c.Gas_Escaping_from_the_Hole__c='Yes';
            
            update c;
        //checkRecursive.run=true;
         //   c.Case_Record_Type__c='Abandoned Bike';
          //  update c;
                //checkRecursive.run=true;
            //c.Case_Record_Type__c='Abandoned Bike';
            //update c;

        system.debug('=======fff==='+c.SAG_Contact_Email__c);
        test.stoptest();
       
       
//        cases.add(c);
   
    
   
         }
}