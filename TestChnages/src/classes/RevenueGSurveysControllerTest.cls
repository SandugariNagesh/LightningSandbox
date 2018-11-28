@isTest
public class RevenueGSurveysControllerTest{

  private static TestMethod void testGSurveysController(){
    RevenueSurveyTestingUtil tu = new   RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('uId', Userinfo.getUserId());
    Apexpages.Standardcontroller stc;
    RevenueGSurveysController sc = new RevenueGSurveysController(stc);
    System.assert(sc.allSurveys.size()>0);
  } 
  
  private static TestMethod void testMakeNewSurvey(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('uId', Userinfo.getUserId());
    Apexpages.Standardcontroller stc;
    RevenueGSurveysController sc = new RevenueGSurveysController(stc);
    System.assert(sc.makeNewSurvey()==null);
    sc.surveySite = '--SELECT SITE--';
    sc.newSurveyName = 'TestMakeNewSurvey';
    system.assert(sc.makeNewSurvey()==null);
    sc.surveySite = 'blah';
    System.assert(sc.makeNewSurvey()!=null);
    sc.doSurveyReset();     
  }
  
    private static TestMethod void testDeleteSurvey(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('uId', Userinfo.getUserId());
    Apexpages.Standardcontroller stc;
    RevenueGSurveysController sc = new RevenueGSurveysController(stc);
    System.assertEquals(RevenueGSurveysController.revenuedeleteSurvey(tu.surveyId),'true');
  }

}