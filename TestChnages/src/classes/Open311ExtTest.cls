@isTest
public class Open311ExtTest{
    
    public Static TestMethod void makeCalloutTest(){
        String baseUrl,par, meth;
        
        baseUrl = 'https://philadelphia.secure.force.com/apps/services/apexrest/v2/services/json' ;
        par = 'testRun';
        meth = 'GeoSerList';
        Test.StartTest();
        Open311Ext O311 = new  Open311Ext();
        Open311Ext.makeCallout(baseUrl, par, meth); 
         System.debug('URl - '+Open311Ext.url);
         System.debug('URl - '+Open311Ext.params );
         System.debug('URl - '+Open311Ext.method ); 
         System.debug('URl - '+Open311Ext.result ); 
        Test.stopTest();        
        
    } 

}