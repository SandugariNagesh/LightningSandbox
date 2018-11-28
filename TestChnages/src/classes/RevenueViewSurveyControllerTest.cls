@istest
private class RevenueViewSurveyControllerTest{
    //------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------//
    private static Testmethod void testViewSurveyController() {
        RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        RevenueViewSurveyController vsc = new RevenueViewSurveyController(stc); 
        RevviewShareSurveyComponentController vsscc = new RevviewShareSurveyComponentController();
        vsc.init();
        RevenueViewSurveyController vsc1 = new RevenueViewSurveyController(vsscc); 
        //vsc.ViewSurveyController(vsscc);
        System.assert(vsc.allQuestionsSize == 4);
        System.assert(tu.surveyId != null);
    

        vsc.submitResults();
       /* for (Question q : vsc.allQuestions)
        {
            q.selectedOption = String.valueof(2);
            q.choices = String.valueof(2);
            q.selectedOptions = new List<String>();
            q.selectedOptions.add(String.valueof(2));
            vsc.submitResults();
        }
        System.assertEquals(true, vsc.thankYouRendered);
*/

        //test something
    }


    private static Testmethod void testUpdateSurveyName() {
        RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        RevenueViewSurveyController vsc = new RevenueViewSurveyController(stc);
        vsc.surveyName = 'new name';
        system.assert(vsc.updateSurveyName() == null);

    }


    private static Testmethod void testupdateSurveyThankYouAndLink() {
        RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        RevenueViewSurveyController vsc = new RevenueViewSurveyController(stc);
        vsc.surveyThankYouText = 'new stuff';
        vsc.surveyThankYouURL = 'more new stff';
        system.assert(vsc.updateSurveyThankYouAndLink()==null);
    }

    
    private static Testmethod void testrefreshQuestionList() {
        RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
        Apexpages.currentPage().getParameters().put('id',tu.surveyId);
        Apexpages.Standardcontroller stc;
        RevenueViewSurveyController vsc = new RevenueViewSurveyController(stc);
        system.assert(vsc.refreshQuestionList() == null);
    }

}