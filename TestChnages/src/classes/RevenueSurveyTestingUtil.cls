@isTest
public with sharing class RevenueSurveyTestingUtil {
  public String        surveyId       {get; set;}
  public List<String>  questionIds    {get; set;}
  public String          contactId      {get; set;}
  public String        surveyTakerId  {get; set;}
  public String        contactId2     {get; set;}
  
  
  public RevenueSurveyTestingUtil(){
    questionIds = new List<String>();
    createTestSurvey();
    createTestQuestions();
    createTestContact();
    createSurveyTaker();
    createTestResponses();
    
  }
  
  public static TestMethod void testConstructor(){
    SurveyTestingUtil tu = new SurveyTestingUtil();
    System.assert(tu.surveyId != null);
  }
  
  public void createSurveyTaker(){
    Revenue_Survey_Taken__c st = new Revenue_Survey_Taken__c();
    st.Contact__c = contactId;
    st.RevenueSurvey__c  = surveyId;
    st.Taken__c = 'false';
    insert st;
    surveyTakerId = st.Id;
  }
  
  public void createTestSurvey(){
    RevenueSurvey__c s = new RevenueSurvey__c();
    s.Name = 'Testing Survey';
    s.Submit_Response__c = 'empty'; 
    insert s;
    surveyId = s.Id;
  }
  
  public void createTestQuestions(){
    questionIds.add(createQuestion(0));
    questionIds.add(createQuestion(1));
    questionIds.add(createQuestion(2));
    questionIds.add(createQuestion(3));
  }
  
  public String createQuestion(Integer i){
    Revenue_Survey_Question__c q = new Revenue_Survey_Question__c();
    q.Name = 'Testing Question';
    q.RevenueSurvey__c   = surveyId;
    q.Type__c = getType(i);
    q.Choices__c = getChoices();
    q.Question__c = 'Testing Question question';
    q.OrderNumber__c = i;
    q.Required__c = true;
    insert q;
    return q.id;        
  }
  
  
  public void createTestContact() {
    Contact c = new Contact();
    c.LastName = 'Doe';
    c.FirstName = 'John';
    c.Email = 'surveyAppUser@hotmail.com';
    insert c;
    contactId = c.Id;   
    
    Contact c2 = new Contact();
    c2.LastName = 'Doe2';
    c2.FirstName = 'John2';
    c2.Email = 'surveyAppUser2@hotmail.com';
    insert c2;
    contactId2 = c2.Id;   
  }
  
  public String createTestResponses() {
    Revenue_Survey_Question_Response__c r = new Revenue_Survey_Question_Response__c();
    r.Response__c = 'two';
    Revenue_Survey_Question__c sq = [Select id from Revenue_Survey_Question__c where id=: questionIds[1] limit 1];
    r.Revenue_Survey_Question__c = sq.id;
    r.Revenue_SurveyTaker__c = surveyTakerId;
    insert r;
    return 'true';
  }
  
  public String getType(Integer i){
    if      (i==1)
     return 'Multi-Select--Vertical';
    else if (i==2)
     return 'Single Select--Vertical';
    else if (i==3)
     return 'Free Text';
    else
     return 'Single Select--Horizontal';
  }
  public String getChoices(){
    return 'one\ntwo\nthree\n';
  }
  
}