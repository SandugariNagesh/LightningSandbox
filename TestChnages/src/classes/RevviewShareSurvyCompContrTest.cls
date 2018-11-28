@isTest
public class RevviewShareSurvyCompContrTest{
    private static testmethod void testShareSurvey()
    {
        RevenueSurvey__c mySurvey = new RevenueSurvey__c();
        mySurvey.Submit_Response__c = 'empty';  
        insert mySurvey;
        
        RevviewShareSurveyComponentController vss = new RevviewShareSurveyComponentController();
        vss.surveyId = mySurvey.Id;
        
        vss.selectedURLType = 'Chatter';
        System.assertEquals(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + 'TakeSurveyForRevenue?', vss.surveyURLBase);
        System.assertEquals('id=' + mySurvey.Id + '&cId=none&caId=none', vss.surveyURL);
        
        vss.selectedURLType = 'Email Link w/ Contact Merge';
        System.assertEquals('id=' + mySurvey.Id + '&cId={!Contact.Id}&caId=none', vss.surveyURL);
        
        vss.selectedURLType = 'Email Link w/ Contact & Case Merge';
        System.assertEquals('id=' + mySurvey.Id +  '&cId={!Contact.Id}&caId={!Case.id}', vss.surveyURL);
    
        System.assertEquals(true, vss.checkSubdomain('test.developer-edition.salesforce'));
        System.assertEquals(false, vss.checkSubdomain(null));
        System.assertEquals(false, vss.checkSubdomain('test.salesforce.com'));
        
        System.assertEquals('', vss.setupUrlPrefix('EMPTY'));
        
        vss.surveySite = '--SELECT SITE--';
        System.assertEquals(null, vss.surveyURLBase);
    
    }
}