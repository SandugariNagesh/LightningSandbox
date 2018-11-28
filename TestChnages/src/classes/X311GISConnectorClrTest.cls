@Istest(seealldata=true)
public class X311GISConnectorClrTest{

Static testMethod void X311GISConnectorMethode(){


        Case c=new Case();
        c.Subject='Test'; 
        c.Street__c='TestStreet';
        c.Centerline__longitude__s=1;
        c.Centerline__latitude__s=1;
        c.Centerline_2272x__c =10;
        c.Centerline_2272y__c=12;
        c.Origin='Email';
          Insert c;


    Id stExam = Schema.SObjectType.case.getRecordTypeInfosByName().get('Graffiti Removal').getRecordTypeId();
     
     GISCaseRT__c a=new GISCaseRT__c();
     a.RecordTypeDevName__c=stExam ;
     a.name='Test';
     insert a;
     
     X311GISConnectorClr.getGeoCodeSpec('address',stExam );
      
      
      }
      Static testMethod void X311GISConnectorMethode1(){

     Id stExam = Schema.SObjectType.case.getRecordTypeInfosByName().get('Graffiti Removal').getRecordTypeId();
             
     X311GISConnectorClr.ViewPort wrapper =new X311GISConnectorClr.ViewPort();
     X311GISConnectorClr.GeoCodeData geo=new X311GISConnectorClr.GeoCodeData();
     X311GISConnectorClr.CasePoint casep=new X311GISConnectorClr.CasePoint();
     
    
     /* wrapper.xmin=2696048.3928769524;
      wrapper.xmax=2696048.3928769524;
      wrapper.ymin=239540.29761598285;
      wrapper.ymax=239540.29761598285;
      
      Case cs = [
                SELECT  Id, CaseNumber, Subject, Street__c, Centerline__longitude__s, Centerline__latitude__s 
                  FROM  Case 
                   WHERE Centerline_2272x__c != null 
                   AND  Centerline_2272y__c != null
                   AND  Centerline_2272x__c >=2696048.3928769524 AND Centerline_2272x__c <= 2696048.3928769524 
                   AND  Centerline_2272y__c >= 239540.29761598285 AND Centerline_2272y__c <= 239540.29761598285
                   AND  Centerline__Longitude__s != null 
                   AND  Centerline__Latitude__s != null
                   AND  RecordTypeId = :stExam 
                   AND  IsClosed=false limit 1];
                   
                   system.debug('============================================'+cs);
            
            Casep.x = cs.Centerline__longitude__s;
            Casep.y = cs.Centerline__latitude__s;
            Casep.id = cs.Id;
            Casep.label = cs.CaseNumber;
            Casep.Description = cs.Street__c + ' : ' + cs.Subject; */
            
      
      
      
      
       X311GISConnectorClr.Query(stExam,wrapper);

       Case c=new Case();
        c.Subject='Test'; 
        c.Street__c='TestStreet';
        c.Centerline__longitude__s=1;
        c.Centerline__latitude__s=1;
        c.Centerline_2272x__c =10;
        c.Centerline_2272y__c=12;
        c.Origin='Email';
        c.RecordTypeId=stExam;
        c.Floor__c='test';
        try{
          insert c;
          
          }catch(exception e)
          {
          
          }
          



      
      }
      Static testMethod void X311GISConnectorMethode3(){


        Case c=new Case();
        c.Subject='Test'; 
        c.Street__c='TestStreet';
        c.Centerline__longitude__s=1;
        c.Centerline__latitude__s=1;
        c.Centerline_2272x__c =10;
        c.Centerline_2272y__c=12;
        c.Origin='Email';
        try{
          Insert c;
          }
          catch(exception e){
          }
          
          
                   
                   
           
               RecordType rt = [SELECT Id FROM RecordType WHERE sObjectType = 'case' AND Name = 'Miscellaneous' limit 1];
        
             Id stExam = Schema.SObjectType.case.getRecordTypeInfosByName().get('Graffiti Removal').getRecordTypeId();

     
              X311GISConnectorClr.QueryByRadius(stExam,2,2,2);

      
      }



         
         
         

}