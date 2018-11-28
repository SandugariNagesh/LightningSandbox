@isTest
public class RevenueSurveyAndQuestionControllerTest{

  /*****SurveyAndQuestionController****/
   //test constructor and calls within it
  private static TestMethod void testCreateQuestionController(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);
    Apexpages.Standardcontroller std;
    RevenueSurveyAndQuestionController cqc = new RevenueSurveyAndQuestionController(std);
    cqc.addQuestion();
    cqc.getNewQuestionNum();
    cqc.makeNewQuestionLink();
    System.assert(cqc.surveyId == tu.surveyId);
  }
  
  //test constructor and calls within it
  private static TestMethod void testEditQuestion(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);
    Apexpages.Standardcontroller std;
    RevenueSurveyAndQuestionController cqc = new RevenueSurveyAndQuestionController(std);
    cqc.editQuestion();
    cqc.questionReference = tu.questionIds[0];
    cqc.editQuestion();
    cqc.questionReference = tu.questionIds[1];
    cqc.editQuestion();
    cqc.questionReference = tu.questionIds[2];
    cqc.editQuestion();
    cqc.questionReference = tu.questionIds[3];
    System.assert(cqc.editQuestion()==null);
    
  }
  
   //test the saving of new questions
  private static TestMethod void testsaveAndNewQuestion(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);
    Apexpages.Standardcontroller std;
    RevenueSurveyAndQuestionController cqc = new RevenueSurveyAndQuestionController(std);
    //test saving new question
    cqc.qQuestion = 'THIS IS A NEW QUESTION';
    cqc.qChoices = '1\\n2\\n3\\3';
    cqc.qRequired=true;
    cqc.questionType='Single Select--Vertical';
    cqc.saveAndNewQuestion();
    System.assertEquals(5, cqc.getNewQuestionNum());
    //edit existing question
    RevenueSurveyAndQuestionController cqcI = new RevenueSurveyAndQuestionController(std);
    cqcI.questionReference = tu.questionIds[0];
    cqcI.editQuestion();
    cqcI.qQuestion = 'THIS IS A NEW QUESTION THAT IS EXTRA LONG SO THE NAME SHORTENING CALL WILL BE USED, THIS SHOULD BE LONG ENOUGH NOW THIS IS A NEW';
    cqcI.qChoices = '1\\n2\\n3\\3';
    cqcI.qRequired=true;
    cqcI.questionType='Single Select--Vertical';
    cqcI.saveAndNewQuestion();
    System.assertEquals(5, cqcI.getNewQuestionNum());
  }
  
  private static TestMethod void testsavesaveQuestion(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);
    Apexpages.Standardcontroller std;
    RevenueSurveyAndQuestionController cqc = new RevenueSurveyAndQuestionController(std);
    //test saving new question
    cqc.qQuestion = 'THIS IS A NEW QUESTION';
    cqc.qChoices = '1\\n2\\n3\\3';
    cqc.qRequired=true;
    cqc.questionType='Single Select--Vertical';
    cqc.controllerSavQuestion();
    System.assertEquals(5, cqc.getNewQuestionNum());
    //edit existing question
    RevenueSurveyAndQuestionController cqcI = new RevenueSurveyAndQuestionController(std);
    cqcI.questionReference = tu.questionIds[0];
    cqcI.editQuestion();
    cqcI.qQuestion = 'THIS IS A NEW QUESTION THAT IS EXTRA LONG SO THE NAME SHORTENING CALL WILL BE USED, THIS SHOULD BE LONG ENOUGH NOW';
    cqcI.qChoices = '1\\n2\\n3\\3';
    cqcI.qRequired=true;
    cqcI.questionType='Single Select--Vertical';
    cqcI.controllerSavQuestion();
    System.assertEquals(5, cqcI.getNewQuestionNum());
  }
  
   //test constructor and calls within it
  private static TestMethod void testPreviewQuestion(){
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);
    Apexpages.Standardcontroller std;
    RevenueSurveyAndQuestionController cqc = new RevenueSurveyAndQuestionController(std);
    
    cqc.questionReference = tu.questionIds[0];
    cqc.editQuestion();
    cqc.previewQuestion();

    cqc.questionReference = tu.questionIds[1];
    cqc.editQuestion();
    cqc.previewQuestion();
    
    cqc.questionReference = tu.questionIds[2];
    cqc.editQuestion();
    System.assert(cqc.previewQuestion()==null);
    
    cqc.questionReference = tu.questionIds[3];
    cqc.editQuestion();
    System.assert(cqc.previewQuestion()==null);
    
  }

  private static Testmethod void testUpdateSurveyName() {
      RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
      Apexpages.currentPage().getParameters().put('id',tu.surveyId);  
      Apexpages.Standardcontroller stc; 
      RevenueSurveyAndQuestionController vsc = new RevenueSurveyAndQuestionController(stc);
      vsc.surveyName = 'new name';
      system.assert(vsc.updateSurveyName() == null);
      
  }
  
    private static Testmethod void testupdateSurveyThankYouAndLink() {
    RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
    Apexpages.currentPage().getParameters().put('id',tu.surveyId);  
    Apexpages.Standardcontroller stc; 
    RevenueSurveyAndQuestionController vsc = new RevenueSurveyAndQuestionController(stc);
    vsc.surveyThankYouText = 'new stuff';
    vsc.surveyThankYouURL = 'more new stff';
    system.assert(vsc.updateSurveyThankYouAndLink()==null);
  }
  
   private static Testmethod void testRefreshQuestionList() {
      RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
      Apexpages.currentPage().getParameters().put('id',tu.surveyId);
      Apexpages.Standardcontroller stc; 
      RevenueSurveyAndQuestionController vsc = new RevenueSurveyAndQuestionController(stc);
      vsc.getAQuestion();
      
      // Retrieve questions for this survey 
      List<Revenue_Survey_Question__c> sq = new List<Revenue_Survey_Question__c>();
      sq = [Select id, orderNumber__c from Revenue_Survey_Question__c];
      
      // get question with orderNumber 1
      Revenue_Survey_Question__c first = [Select id, orderNumber__c from Revenue_Survey_Question__c Where orderNumber__c =: 1 and RevenueSurvey__c =: tu.surveyId];
      System.assert(first.orderNumber__c == 1 );    
     
      // Specify the new order
      vsc.newOrderW = vsc.allQuestions[2].id + ',' +
      vsc.allQuestions[0].id + ',' +
      vsc.allQuestions[1].id + ',' +
      vsc.allQuestions[3].id + ',';
      
      vsc.updateOrderList();
            
      // Verify that the question with order 1 is not the same as the one retrieved previously
      Revenue_Survey_Question__c second = [Select id, orderNumber__c from Revenue_Survey_Question__c Where orderNumber__c =: 1 and RevenueSurvey__c =: tu.surveyId];
      System.assert(second.id != first.id);
      
      // update the question list, and make sure it has been modified as well
      vsc.refreshQuestionList();
    System.assert(vsc.allQuestions[1].id != first.id);
      
  }
  
   private static TestMethod void testDeleteQuestion() {
      RevenueSurveyTestingUtil tu = new RevenueSurveyTestingUtil();
      Apexpages.currentPage().getParameters().put('id',tu.surveyId);
      Apexpages.Standardcontroller stc; 
      RevenueSurveyAndQuestionController vsc = new RevenueSurveyAndQuestionController(stc);
      
      
      // Get a question to delete
      Revenue_Survey_Question__c sq = [Select id, orderNumber__c from Revenue_Survey_Question__c Where orderNumber__c =: 1 and RevenueSurvey__c =: tu.surveyId];
      vsc.questionReference = sq.Id;
      vsc.deleteRefresh();
      
      Revenue_Survey_Question__c sq2 = [Select id, orderNumber__c from Revenue_Survey_Question__c Where orderNumber__c =: 1 and RevenueSurvey__c =: tu.surveyId];
      System.assert(sq.Id != sq2.Id);

      
  }
}