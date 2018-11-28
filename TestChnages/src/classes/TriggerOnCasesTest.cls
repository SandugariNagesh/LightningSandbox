@isTest
//Test class for testing the trigger on cases
private class TriggerOnCasesTest{
   
    //Information Request
    static testMethod void validate1() 
    {      
       Case cas = new Case(Type='Information Request Type',Status='Closed',Subject='Test',Description='Testing using Test Class',Origin='Phone',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas;//insert case      
       test.stopTest(); 
       cas = [SELECT Id,Type,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Reason after inserting new case: '+ cas.Reason); 
       System.assertEquals('Question Answered',cas.Reason); // Test that the trigger correctly updated the Fields
    }
    
    //Graffiti Removal 
    static testMethod void validate2() 
    {      
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Graffiti Removal',Floor__c='3rd or above',Property_Type__c='Pole',Property_Owner__c='Yes',Rail_Corridor__c='No',Powerwash__c='Yes',Surface_Type__c='Brick',Painted_Surface__c='No',Subject='Test',Origin='Phone',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas; //insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Closed',cas.Status);// Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
     //Graffiti Removal  
    static testMethod void validate2b() 
    {      
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Graffiti Removal',Floor__c='3rd or above',Property_Type__c='Pole',Property_Owner__c='No',Rail_Corridor__c='Yes',Powerwash__c='Yes',Surface_Type__c='Brick',Painted_Surface__c='No',Subject='Test',Origin='Phone',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas; //insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Closed',cas.Status);// Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
     //Graffiti Removal  
    static testMethod void validate2c() 
    {      
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Graffiti Removal',Floor__c='3rd or above',Property_Type__c='Pole',Property_Owner__c='No',Rail_Corridor__c='No',Powerwash__c='Yes',Surface_Type__c='Brick',Painted_Surface__c='No',Center_City_District__c='In',Subject='Test',Origin='Phone',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas; //insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Closed',cas.Status);// Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Illegal Dumping 
    /*static testMethod void validate3() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',Case_Record_Type__c ='Illegal Dumping',Is_Trash_on_Street_or_Sidewalk__c='No',Type_of_Materials__c='Construction Materials',Is_Trash_on_Vacant_Lot__c='No',Condition_of_Materials__c='Bagged',Trash_Include_Commercial_Hazardous_Waste__c='Yes',Trash_Include_Household_Hazardous_Waste__c='No',Origin='Phone',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas;//insert case   
       test.stopTest();    
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);
     //  System.assertEquals('Closed',cas.Status); // Test that the trigger correctly updated the Fields
      // System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);*/
   // }
    
    //Abandoned Vehicle  
    static testMethod void validate4() 
    {      
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes();
       Case cas = new Case(Department__c='Police Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Abandoned Vehicle',Is_there_a_busted_steering_column__c ='Yes',Origin='Phone',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas;//insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);
       System.assertEquals('Closed',cas.Status); // Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Rubbish/Recyclable Material Collection  
    static testMethod void validate5() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Rubbish/Recyclable Material Collection',Set_Out_in_Time__c ='No',Origin='Phone',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas;//insert case   
       test.stopTest();    
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);
       System.assertEquals('Closed',cas.Status); // Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Street Light Outage  
    static testMethod void validate6() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Origin='Phone',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_Illuminating_a_Street__c='Yes',Is_the_Light_in_a_Park__c='No',Is_Light_Illuminating_an_Alley__c='No',Problem_Type__c ='On During Day',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);       
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); // Test that the trigger correctly updated the Fields
    }
    
   //Street Light Outage
    static testMethod void validate7() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Is_the_Light_Illuminating_a_Street__c='Yes',Is_the_Light_in_a_Park__c='Yes',Origin='Phone',Is_the_Light_a_Traffic_Signal__c='No',Is_Light_Illuminating_an_Alley__c='No',Problem_Type__c = 'On During Day',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case 
       test.stopTest();      
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);       
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); // Test that the trigger correctly updated the Fields
    }
    
   //Street Light Outage
    static testMethod void validate8() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Is_Light_Illuminating_an_Alley__c='Yes',Is_the_Light_Illuminating_a_Street__c='Yes',Origin='Phone',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Problem_Type__c = 'On During Day',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='1200 yerkes',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case   
       test.stopTest();    
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);       
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); // Test that the trigger correctly updated the Fields
    }
    
   //Street Light Outage
    static testMethod void validate9() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Is_the_Light_Illuminating_a_Street__c='Yes',Origin='Phone',Is_Light_Illuminating_an_Alley__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Problem_Type__c = 'On During Day',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }
    
    //Street Light Outage
     static testMethod void validate10() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Private_Property__c='Yes',Origin='Phone',Is_Light_Illuminating_an_Alley__c='Yes',Is_the_Light_Illuminating_a_Street__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Problem_Type__c = 'On During Day',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }
    
   //Street Light Outage
    static testMethod void validate11() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Origin='Phone',Is_Light_Illuminating_an_Alley__c='No',Problem_Type__c = 'Other',Is_the_Light_Illuminating_a_Street__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Is_Light_on_Public_Property__c='No',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case    
       test.stopTest();   
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Street Light(Other)',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields
    }
    
    static testMethod void validate12() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Street Light Outage',Is_Light_Illuminating_an_Alley__c='No',Origin='Phone',Problem_Type__c = 'On During Day',Is_the_Light_Illuminating_a_Street__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Is_Light_on_Public_Property__c='No',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case     
       test.stopTest();  
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Street Light Outage',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields
    }
    
   //Street Light Outage
    static testMethod void validate13() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       PS_Fields_Mapping__c p = new PS_Fields_Mapping__c(Name='Are you the property Owner?',Field_Name__c='Are you the property Owner?',Value__c='Property_Owner__c');
       insert p;
       Required_Streets_Field__c r = new Required_Streets_Field__c(Name='Problem_Type__c',Case_Record_Type__c ='Street Light Outage',Department__c='Streets Department',Label__c='Problem Type',Required__c = TRUE,API_Name__c='Problem_Type__c');
       insert r;
       Case cas = new Case(Case_Record_Type__c ='Street Light Outage',ByPass_VR_WF__c=TRUE,Is_Light_Illuminating_an_Alley__c='No',Origin='Phone',Problem_Type__c = 'Bulb Hanging',Is_the_Light_Illuminating_a_Street__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Is_Light_on_Public_Property__c='No',Hazardous__c='No',Subject='Test',Description='Testing using Test Class Custom fields:',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Department__c='Streets Department',Customer_request_id__c='314145');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case      
       test.stopTest(); 
       cas = [SELECT Id,Service_Request_Type__c,Hazardous__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('New',cas.Status);
       System.assertEquals('Yes',cas.Hazardous__c);  // Test that the trigger correctly updated the Fields
    }
    
   //Rubbish/Recyclable Material Collection
    static testMethod void validate14() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes();        
       Case cas = new Case(Department__c='Streets Department',ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Rubbish/Recyclable Material Collection',Origin='Phone',Is_Trash_in_a_Wastebasket__c ='Yes',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Reason); 
       test.startTest();
       insert cas;//insert case 
       test.stopTest();      
       cas = [SELECT Id,Service_Request_Type__c,Status FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);
       System.assertEquals('Closed',cas.Status); // Test that the trigger correctly updated the Fields
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
   //Street Light Outage
    static testMethod void validate15() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Street Light Outage',Customer_request_id__c='314145',Origin='Phone',Is_Light_Illuminating_an_Alley__c='No',Problem_Type__c = 'On During Day',Is_the_Light_Illuminating_a_Street__c='No',Is_the_Light_a_Traffic_Signal__c='No',Is_the_Light_in_a_Park__c='No',Is_Light_on_Public_Property__c='No',Hazardous__c='No',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Department__c='Streets Department');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();
       CaseComment com = new CaseComment(CommentBody='Test',ParentId=cas.id);
       insert com;     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Street Light Outage',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields
    }
    
    static testMethod void validate16() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Fire Residential or Commercial',Origin='Phone',Service_Request_Type__c='Fire Residential',Customer_request_id__c='314145',Unit_Number__c='1st',L_I_District__c='Test',L_I_Address__c='21 N Juniper st',Subject='Test',Description='Testing using Test Class',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Hazardous_Materials_Spill__c='No',Specific_Location_of_Fire_Code_Violation__c='Test',Residential_or_Commerical__c='Residential',Residential_Property_Type__c='House',Centerline_2272x__c=45.23,Centerline_2272y__c=53.21);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Fire Residential',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
    
    /* static testMethod void validate17() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes();         
       Contact c = new Contact ( LastName = 'ANON');
       insert c;
       Case cas = new Case(contactid=c.id,ByPass_VR_WF__c=TRUE,Department__c = 'License & Inspections',Case_Record_Type__c ='Building Force',Building_Collapsing__c ='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
        
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }*/
    
    static testMethod void validate18() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact ( LastName = 'ANON'); 
       insert c; 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=c.id,Case_Record_Type__c ='Emergency Air Conditioning',Residential_Windows_Inoperable__c='No',How_Many_Days_Without_Air_Conditioning__c= 2,Health_Care_Facility_Name__c ='Test',Name_if_Not_Verified__c='Test',L_I_Address__c='21 N Juniper st',L_I_District__c='Test',Heat_Emergency__c='No',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Nursing_Personal_Care_Home_Hospital__c='No',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }
    //NAgesh
    ///////////////////***************////////////////////
            //Daycare Residential or Commercial
    public static testmethod void vaidationdaycare(){
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Daycare Residential or Commercial',Origin='Phone',Service_Request_Type__c='Daycare Commercial',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Hazardous_Materials_Spill__c='No',Residential_or_Commerical__c='Commercial',Daycare_Business_Name__c = 'Test', One_or_Two_Family_Dwelling__c = 'Yes',  Hours_of_Operation__c = 'Test', Violation_Type_Daycare__c = 'Maintenance',  Family_Daycare_License__c = 'No',Food_Preparation_and_Service_License__c = 'No',L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Daycare Commercial',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
        
    }
    //No Heat (Residential)
   static testMethod void validateNoHeat() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='No Heat (Residential)',Origin='Phone',Service_Request_Type__c='No Heat (Residential)',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Residential_or_Commerical__c='Residential',Residential_Property_Type__c = 'Apartment',Unit_Number__c= '3 floor' ,Heat_Type__c = 'Electric',Number_of_Days_Without_Heat__c= 2,Owner_Name__c='Fake',Owner_Address__c='fake',Owner_Phone_Number__c='1234',L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('No Heat (Residential)',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
    //Tree Dangerous
   static testMethod void validateTreeDang() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Tree Dangerous',Origin='Phone',Service_Request_Type__c='Tree Dangerous',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Life_Threatening_Condition__c='No',Tree_Between_Sidewalk_and_Curb__c = 'No',Tree_on_Side_Street__c='No',Tree_on_Power_Lines_No_Smoke_Fire__c = 'No',Blocked_Street_Sidewalk_Home_Access__c = 'No',On_Property_of_Person_Making_Report__c = 'No',Overgrown_or_Aready_Fallen__c = 'No',Growing_in_Vacant_Building__c='No',Branches_Break_Easily__c='Yes',Leaves_in_Spring_and_Summer__c='No',Animals_Living_in_Tree__c ='No',Dead_or_Alive_Tree__c='Dead',How_Many_Trees__c = 1, L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Tree Dangerous',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
    //Zoning Business
   static testMethod void validateZoningBuss() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Zoning Business',Origin='Phone',Service_Request_Type__c='Zoning Business',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Request_Type__c = 'Towing Company complaint',Property_Improperly_Used_as_Residential__c = 'Yes',Commercial_or_Residential__c='Commercial',Current_Property_Use__c='Test',Business_Hours_of_Operation__c='Test',Business_Type__c='Test',Sign_on_Street_Pole_Median_or_Curb__c='No',Sign_Location__c='Test',Honor_Box_Outside_Regulated_Area__c='No',Honor_Box_Improperly_Maintained__c='No',Seeking_Refund_for_Vehicle_Not_Released__c='No',Towing_Business_Name__c='Test',Location_Vehicle_Towed_From__c='Test',Towing_Fees_Complaint__c='Test',Towing_Company_Hours_of_Operation__c='Test',Zoning_Permit_text__c='Test',Zoning_License__c='Test', L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Zoning Business',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }

    //Zoning Residential
   static testMethod void validateZoningRes() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Zoning Residential',Origin='Phone',Service_Request_Type__c='Zoning Residential',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Property_Type_multi__c = 'Single Home',Owner_Occupied__c='No', L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Zoning Residential',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
    //Vacant Lot Clean-Up
   static testMethod void validateVacantLot() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c = 'Vacant Lot Clean-Up',Origin='Phone',Service_Request_Type__c='Vacant Lot Clean-Up',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Lot_Type__c = 'Vacant lot',Are_there_any_other_issues_with_the_lot__c='No',Is_this_a_tree_issue__c='No',  L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Vacant Lot Clean-Up',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
     //License Residential
   static testMethod void validateLicResd() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='License Residential',Origin='Phone',Service_Request_Type__c='License Residential',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',License_to_Rent__c='Yes',Property_Owner_Name__c='HABA HOMES LP',Zoning_Permit__c='No',Property_Owner_Contact_Information__c='HABA HOMES LP',Property_Type__c='Rented House',Apartment_Number__c='1 Floor',  L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('License Residential',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }

    ////////////////////****************////////////////
    //Daycare Residential or Commercial
   static testMethod void validate37() {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact con = new Contact(LastName='ANON',email='test@test.com');
       test.startTest();
       insert con;//insert contact 
       Case cas = new Case(Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,contactid=con.id,Case_Record_Type__c ='Daycare Residential or Commercial',Origin='Phone',Service_Request_Type__c='Daycare Commercial',Customer_request_id__c='314145',Subject='Test',Description='Testing using Test Class',Street__c='1234 MARKET ST',Customer_Declined__c=true,Translator_Required__c='No',Hazardous_Materials_Spill__c='No',Residential_or_Commerical__c='Commercial',Daycare_Business_Name__c = 'Test', One_or_Two_Family_Dwelling__c = 'Yes',  Hours_of_Operation__c = 'Test', Violation_Type_Daycare__c = 'Maintenance',  Family_Daycare_License__c = 'No',Food_Preparation_and_Service_License__c = 'No',L_I_District__c = 'Central',L_I_Address__c = '1234 MARKET ST',Centerline_2272x__c=2694269.2024061074,Centerline_2272y__c=236009.40634746553);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);  
       System.assertEquals('Daycare Commercial',cas.Service_Request_Type__c);  // Test that the trigger correctly updated the Fields        
    }
    
    //Police Complaint
    static testMethod void validate19() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Police Complaint',ByPass_VR_WF__c=TRUE,Physical_or_Verbal_Abuse__c='No Abuse',Streets_Dept_Complaint__c='No',Abandoned_Vehicle_Complaint__c='No',Fire_Dept_or_EMS_Complaint__c='No',Incident_Date_and_Time__c='15 march 7 am',Officer_Breaking_Law__c='No',Follow_Up_Contact__c='No',City_of_Philadelphia_Police__c='Yes',Complaint_or_Compliment__c='Compliment',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }
    
    //Smoke Detector
    static testMethod void validate20() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Smoke Detector',ByPass_VR_WF__c=TRUE,Philadelphia_Resident__c='No',New_Request__c='No',Residence_Type__c='Single Family House',Owner_Occupied_Property__c='No',Access_Provided_by_Adult__c='No',Disabilities_Language_Information__c='Test',Installation_Time__c='Test',FloorSmokeDetector__c=2,Front_or_Back__c='Back',Engine__c='Test',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
    }
    
    //Boarding Room House
    static testMethod void validate21() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact (LastName = 'ANON');
       insert c;
       Case cas = new Case(Department__c = 'License & Inspections',contactid=c.id,ByPass_VR_WF__c=TRUE,Case_Record_Type__c ='Boarding Room House',Customer_is_a_Tenant__c = 'No',Property_Owner_Phone_Number__c='1234567890',L_I_District__c ='21 N JUNIPER ST',Rental_License__c='Yes',Zoning_Permit__c='Yes',Number_of_Unrelated_Tenants__c=2,Does_Owner_Reside_at_Property__c='No',Property_Owner_Name__c='Test',L_I_Address__c='Test',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case  
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
       Case cas2 = new Case(contactid=c.id,Department__c = 'License & Inspections',ByPass_VR_WF__c=TRUE,Service_Request_Type__c='Boarding Room House',Case_Record_Type__c ='Boarding Room House',Rental_License__c='No',Zoning_Permit__c='No',Number_of_Unrelated_Tenants__c=2,Does_Owner_Reside_at_Property__c='No',Property_Owner_Name__c='Test',L_I_Address__c='Test',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       insert cas2; 
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.assertEquals('Boarding Room House',cas2.Service_Request_Type__c); 
       test.stopTest();     
    }
    
    //Building construction
    static testMethod void validate22() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes();
       Contact c = new Contact (LastName = 'ANON'); 
       insert c; 
       Case cas = new Case(ByPass_VR_WF__c=TRUE,Department__c = 'License & Inspections',contactid=c.id,Case_Record_Type__c ='Building Construction',Description='test',Contractor_Company_Name__c = 'Test',Sparking_Wires_or_Illegal_Hookups__c = 'No',Storage_Shed_Location__c='Front',Paved_Area_to_Create_Parking_Space__c = 'No',Fence_Height_Feet__c='4',Fence_Location__c='Front',Type_of_Work_Being_Done__c='Zoning',Fence_Paved_Area_or_Shed__c='Fence',Valid_Permit__c='Unsure',Unsafe_Conditions__c='No',Where_is_Work_Being_Done__c='test',Day_of_Week_Work_Being_Done__c='test',L_I_District__c='Test',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',L_I_Address__c='Test',Customer_Declined__c=true,Translator_Required__c='No',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case  
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c); 
       cas.Fence_Height_Feet__c='5';
       cas.Type_of_Work_Being_Done__c='Building';      
       update cas;//update case 
       cas.Type_of_Work_Being_Done__c='Plumbing';
       update cas;//update case      
       cas.Type_of_Work_Being_Done__c='Electrical';
       cas.Sparking_Wires_or_Illegal_Hookups__c = 'No';
       update cas;//update case   
       cas.Type_of_Work_Being_Done__c='Zoning';
       update cas;//update case  
       test.stopTest();     
    }
    
    //Sanitation / Dumpster Violation
    static testMethod void validate23() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Sanitation / Dumpster Violation',ByPass_VR_WF__c=True,Is_Trash_on_Curb_Now__c='No',Violation_Type__c='Sanitation',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Inlet Cleaning
    static testMethod void validate24() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Water Department (PWD)',Case_Record_Type__c ='Inlet Cleaning',Heavy_Rain__c='Yes',Subject='Test',Origin='Phone',ByPass_VR_WF__c=True,Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Salting
    static testMethod void validate25() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Salting',Problem_Type__c='Icy Road Surface',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Icy Road Surface',cas.Service_Request_Type__c);
       cas.Problem_Type__c = 'Snow Removal';
       cas.Service_Request_Type__c='Snow Removal';
       update cas;
       System.assertEquals('Snow Removal',cas.Service_Request_Type__c);        
       test.stopTest();     
    }
    
    //Traffic Signal Emergency
    static testMethod void validate26() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Traffic Signal Emergency',Request_for_New_Traffic_Signal__c='Yes',Subject='Test',Origin='Phone',ByPass_VR_WF__c=True,Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
       cas.Service_Request_Type__c = 'Traffic (Other)';
       cas.Signal_Type__c= 'Signal Other';
       cas.Request_for_New_Traffic_Signal__c = 'No';
       cas.Request_to_Modify_Traffic_Signal_Operati__c='No';
       cas.Blocked_by_Tree_Branches_or_Foliage__c='No';
       cas.Problem_Type__c='All Out';
       update cas;
       System.assertEquals('Traffic (Other)',cas.Service_Request_Type__c);        
       test.stopTest();     
    }
    
     //Street Trees
    static testMethod void validate27() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Street Trees',ByPass_VR_WF__c=True,Tree_in_Alley_Frontyard_or_Backyard__c='Yes',Property_Owner_Street_Trees__c='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
     //Street Paving
    static testMethod void validate28() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Street Paving',ByPass_VR_WF__c=True,Resurfacing_Request__c='No',Resurfacing_defect__c='No',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Stop Sign Repair
    static testMethod void validate29() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Stop Sign Repair',ByPass_VR_WF__c=True,Not_Visible__c='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Newsstand Outdoor Cafe
    static testMethod void validate30() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Department__c = 'Streets Department',Case_Record_Type__c ='Newsstand Outdoor Cafe',ByPass_VR_WF__c=True,On_the_City_s_Public_Right_Of_Way__c='No',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       insert cas;//insert case  
       test.stopTest();     
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
    }
    
    //Infestation Residential and License Residential
    static testMethod void validate31() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact ( LastName = 'ANON');
       insert c; 
       Case cas = new Case(Department__c='License & Inspections',contactid=c.id,Case_Record_Type__c ='Infestation Residential',Unit_Number__c='Test',Infestation_Type__c='Roaches',Tenant_in_Single_Family_Dwelling__c='No',Report_Type__c='Property Occupied by a Tenant',Residential_Property_Type__c ='House',L_I_District__c='Test',L_I_Address__c ='21 N Juniper st',ByPass_VR_WF__c=True,Residential_or_Commerical__c='Commercial',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
       Case cas2 = new Case(Case_Record_Type__c ='License Residential',ByPass_VR_WF__c=True,License_to_Rent__c='Yes',Zoning_Permit__c='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213);
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.debug('Status after inserting new case: '+ cas2.Status);     
       System.assertEquals('Service Not Needed',cas2.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas2.Status);  
       System.assertEquals('Service Not Needed',cas2.Service_Request_Type__c); 
       test.stopTest();     
   
    }
    
    //Other Dangerous and Tree Dangerous
    static testMethod void validate32() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact (LastName = 'ANON'); 
       insert c;//insert contact
       Case cas = new Case(Department__c = 'License & Inspections',contactid=c.id,Case_Record_Type__c ='Other Dangerous',Under_Construction_or_Demolition__c='No',Structure_Type__c='Garage',L_I_District__c='Test',L_I_Address__c='21 N Juniper st',Structure_Collapsing__c='Yes',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
       Case cas2 = new Case(contactid=c.id,Department__c = 'License & Inspections',Case_Record_Type__c ='Tree Dangerous',ByPass_VR_WF__c=True,Tree_on_Power_Lines_No_Smoke_Fire__c='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345'); 
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.assertEquals('Service Not Needed',cas2.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas2.Status);  
       System.assertEquals('Service Not Needed',cas2.Service_Request_Type__c);
       test.stopTest();     
       
    }
    
    
     //Maintenance Residential or Commercial and No Heat Residential
    static testMethod void validate33() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact ( LastName = 'ANON'); 
       insert c;//insert contact
       Case cas = new Case(Department__c = 'License & Inspections',contactid=c.id,Case_Record_Type__c ='Maintenance Residential or Commercial',Exterior_or_Interior__c='Interior',Property_Owner_Name__c='Fake',Property_Owner_Contact_Information__c='Fake',Residential_Property_Type__c='House',Unit_Number__c='1st',Problem_Location_at_House_or_Unit__c='Front',Is_Customer_the_Property_Owner__c='No',L_I_District__c='Test',L_I_Address__c='21 N Juniper st',Residential_or_Commerical__c='Residential',Drainage_Problem__c='Yes',Flooded_Residential_Basement__c='Yes',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status);     
       System.assertEquals('Service Not Needed',cas.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas.Status);  
       System.assertEquals('Maintenance Residential',cas.Service_Request_Type__c);
       Case cas2 = new Case(contactid=c.id,Department__c = 'License & Inspections',Case_Record_Type__c ='No Heat (Residential)',ByPass_VR_WF__c=True,Residential_or_Commerical__c='Commercial',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345'); 
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.assertEquals('Service Not Needed',cas2.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas2.Status);  
       System.assertEquals('Service Not Needed',cas2.Service_Request_Type__c);
       test.stopTest();     
       
    }    
    
    //Vacant House or Commercial and Zoning Business
    static testMethod void validate34() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact (LastName = 'ANON'); 
       insert c;//insert contact
       Case cas = new Case(Department__c = 'License & Inspections',contactid=c.id,Case_Record_Type__c ='Vacant House or Commercial',Unsafe_Violations__c='No',Valid_License__c='No',Property_Open_to_Trespass_on_First_or_Gr__c='Front',Access_to_Rear_of_Property_for_Inspectio__c='No',How_to_Access_Rear_of_Property__c='Test',L_I_District__c='Test',L_I_Address__c='21 N JUNIPER ST',Residential_or_Commerical__c='Residential',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Residential_or_Commerical__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.assertEquals('Vacant House',cas.Service_Request_Type__c);
       cas.Residential_or_Commerical__c='Commercial';
       update cas;
       Case casUp=[SELECT Id,Service_Request_Type__c,Residential_or_Commerical__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.assertEquals('Vacant Commercial',casUp.Service_Request_Type__c);
       Case cas2 = new Case(contactid=c.id,Department__c = 'License & Inspections',Case_Record_Type__c ='Zoning Business',ByPass_VR_WF__c=True,Sign_on_Street_Pole_Median_or_Curb__c='Yes',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345'); 
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.assertEquals('Service Not Needed',cas2.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas2.Status);  
       System.assertEquals('Service Not Needed',cas2.Service_Request_Type__c);
       test.stopTest();     
       
    }  
    
    //Parks Recreation safety and Maintenance and Street Defect
    static testMethod void validate35() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact ( LastName = 'ANON'); 
       insert c;//insert contact
       Case cas = new Case(Department__c = 'Streets Department',contactid=c.id,Case_Record_Type__c ='Street Defect',Running_Water__c='Yes',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.assertEquals('Service Not Needed',cas.Service_Request_Type__c);
       cas.Running_Water__c='No';
       cas.Crack_in_Street_Depression_or_a_Hole_i__c='Depression';
       update cas;
       Case casUp =[SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id]; 
       System.assertEquals('Depression',casUp.Service_Request_Type__c);      
       Case cas2 = new Case(Department__c = 'Parks & Recreation',Case_Record_Type__c ='Parks and Rec Safety and Maintenance',ByPass_VR_WF__c=True,Reported_to_911__c='No',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345'); 
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];
       System.assertEquals('Service Not Needed',cas2.Reason); // Test that the trigger correctly updated the Fields
       System.assertEquals('Closed',cas2.Status);  
       System.assertEquals('Emergency',cas2.Service_Request_Type__c);
       test.stopTest();     
       
    }    
    
    //Building Dangerous and Zoning Residential
    static testMethod void validate36() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Contact c = new Contact ( LastName = 'ANON'); 
       insert c;//insert contact
       Case cas = new Case(Department__c = 'License & Inspections',contactid=c.id,Case_Record_Type__c ='Building Dangerous',Building_Collapsing__c='No',Under_Construction_or_Demolition__c='No',Emergency_Repairs_for_Facade__c='No',Location_of_Dangerous_Condition__c='Exterior',Vacant_or_Occupied__c='Vacant',Residential_or_Commerical__c='Residential',L_I_District__c='test',L_I_Address__c='test',House_or_Apartment_Complex__c='House',Single_or_Multi_Family__c='Single',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345',Description='Custom Fields: Is the building occupied or vacant?: Occupied What is the dangerous condition?: dangerous condition Where is the dangerous condition located on the property?: rear Your Name & Contact Number: Saurav & +918861516144');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       test.startTest();
       
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       Case cas2 = new Case(contactid=c.id,Department__c = 'License & Inspections',Case_Record_Type__c ='Zoning Residential',Property_Type_multi__c='Duplex',Owner_Occupied__c='No',L_I_District__c='test',L_I_Address__c='test',ByPass_VR_WF__c=True,Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Centerline_2272x__c=123.123,Centerline_2272y__c=213.213,Customer_Request_Id__c='12345'); 
       insert cas2;
       cas2 = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas2.Id];     
       test.stopTest();    
     
     }
    
    
    static testMethod void validateStreet1() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Case_Record_Type__c ='Salting',Problem_Type__c='Icy Road Surface',Subject='Test',Origin='Phone',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Description='Test',Department__c='Streets Department',Type='Service Request Type');
       System.debug('Reason before inserting new case: ' + cas.Service_Request_Type__c); 
       //test.startTest();
       insert cas;//insert case 
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       System.debug('Status after inserting new case: '+ cas.Status); 
       System.assertEquals('Icy Road Surface',cas.Service_Request_Type__c);
       cas.Problem_Type__c = 'Snow Removal';
       cas.Service_Request_Type__c='Snow Removal';
       cas.Streets_Request_Id__c = '1234';
       cas.Status = 'Open';
       update cas;
       test.startTest();
       System.assertEquals('Snow Removal',cas.Service_Request_Type__c);         
       cas.Status = 'New';
       update cas;
       cas.Status = 'In-Progress';
       update cas;
       cas.Status = 'Open';
       update cas; 
       cas.Status = 'Closed';
       update cas;
       cas.Status = 'In-Progress';
       update cas;        
       test.stopTest();     
    }
    
    static testMethod void sample() 
    {            
       GISMock.Bootstrap(); 
       GISMock.SetAnswer1200Yerkes(); 
       Case cas = new Case(Type='Information Request Type',Status='In-Progress',Street__c='21 N Juniper st',Customer_Declined__c=true,Translator_Required__c='No',Origin='Phone',Subject='Test',Description='Testing using Test Class');
       test.startTest();
       insert cas;//insert case       
       test.stopTest();
       cas = [SELECT Id,Service_Request_Type__c,Status,Reason FROM Case WHERE Id =:cas.Id];
       cas.Status='New';
       update cas;
    }
    
    static testMethod void closeChildCase() {
        //GISMock.Bootstrap();
        
        XedeTestData testData = new XedeTestData('GISTestData');

        Test.setMock(HttpCalloutMock.class, new GISAPIMock(new string[] { 
            testData.find('Address1'), 
            testData.find('Topic1'),
            testData.find('ServiceAreasCourtyard'),
            testData.find('Projection1'),
            testData.find('YerkesAddress'), 
            testData.find('YerkesTopics'), 
            testData.find('YerkesServiceAreas'),
            testData.find('YerkesProject')
        }));
        
        RecordType rt = [ select id, name, developerName from RecordType where developerName = 'Miscellaneous' limit 1 ];
        
        Case aParentCase = new Case(
            Street__c = '1234 Parent Street',
            Description = 'Parent Case',
            Customer_Declined__c=true,
            Translator_Required__c='No',
            Subject = 'Parent Subject',
            Origin='Phone',
            RecordTypeId = rt.Id
        );
        
        test.startTest();
        insert aParentCase;
        
        Case aChildCase = new Case(
            Street__c = '1234 Child Street',
            Description = 'Child Case',
            Subject = 'Child Subject',
            Origin='Phone',
            Customer_Declined__c=true,
            Translator_Required__c='No',
            ParentId = aParentCase.id,
            RecordTypeId = rt.Id
        );
        
        insert aChildCase;
        
        test.stopTest();
        
        Case aCase = [ select id, status from case where id = :aChildCase.id ];
        //system.assertEquals('Closed', aCase.status);
    }
}