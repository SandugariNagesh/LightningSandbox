global with sharing class RevenueGSurveysController {
  
  public String surveyDelete                       {get; set;}
  public String newSurveyName                      {get; set;}
  public List<miniSurvey>allSurveys                {get; set;}
  public String username                           {get; set;}
  public String userId                             {get; set;}
  public String POD                                {get; set;}
  public List<Selectoption>  sitesPicklist         {get; set;} 
  public String surveySite                         {get; set;}
  public String showAddSitesMessage                {get; set;} 
  private String subdomain;
  private boolean useTopLevelDomain;
  
  public String siteInfo  {get; set;}
  
  public RevenueGSurveysController(ApexPages.StandardController stdController){
    username = System.Userinfo.getUserId();    
    setAllSurveys();
    setupSitesPicklist();
    siteInfo = Site.getDomain();
  }
  
  
  private void setupSitesPicklist(){
    List<SurveySitesUtil.SurveySiteInfo> sites = new SurveySitesUtil().getSiteList();
    if (sites.size() > 0) {
        subdomain = sites[0].Subdomain;
    }
    useTopLevelDomain=false;
    String pathPrefix;
    sitesPicklist = new List<Selectoption>();
//    List<Site> sites = [select Name, Subdomain, TopLevelDomain, UrlPathPrefix from Site where Status = 'Active' ];
    //setupDomain(sites);
    setupShowSites(sites.size());
    sitesPicklist.add(new Selectoption('--SELECT SITE--',System.Label.LABS_SF_SELECTSITE ));
    sitesPicklist.add(new Selectoption('Internal',System.Label.LABS_SF_Internal));
    for(SurveySitesUtil.SurveySiteInfo s : sites){
      if(s.prefix == null)
        pathPrefix='EMPTY';
      else
        pathPrefix=s.prefix;
      sitesPicklist.add(new Selectoption(pathPrefix, s.Name));
    }
  }

/*
  private void setupDomain(list <Site> sites){
    String subD;
    String tLevelDomain;
    useTopLevelDomain =false;
    if(sites!=null && sites.size()>0){
      if(sites[0].TopLevelDomain != null && sites[0].TopLevelDomain.length()>0){
        subdomain = sites[0].TopLevelDomain;
        useTopLevelDomain=true;
      }
      else
        subdomain = sites[0].Subdomain;
    }
  }
*/
  private void setupShowSites(Integer i){
    if(i>0){
      showAddSitesMessage = 'false';
    }
    else{
      showAddSitesMessage = 'true';
    }
  }

  private void setAllSurveys(){
   List<RevenueSurvey__c> surveys = [Select Id, Name from RevenueSurvey__c where IsDeleted = false order by Name];
  
   if(allSurveys == null){
      allSurveys = new List<miniSurvey>();
    }
   else{
      allSurveys.clear(); 
    }
   for(RevenueSurvey__c s : surveys){
      allSurveys.add(new miniSurvey(s.Name, s.Id));
    }
  }  
  
  public Pagereference makeNewSurvey(){   
    if(newSurveyName==null){
     POD='';
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.LABS_SF_Survey_Name_Is_Required));
     return null;
    }
    if(surveySite == '--SELECT SITE--'){
     POD='';
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, System.Label.LABS_SF_Survey_Site_Is_Required));
     return null;
    }
    
    
    
    String urlPrefix = setupUrlPrefix(surveySite);
    String domain = setupDomainForSurvey(POD);
    String urlToSave= domain+'/'+urlPrefix+'TakeSurveyForRevenue?';
    if (surveySite == 'Internal')
    {
        urlToSave = URL.getSalesforceBaseUrl().toExternalForm() + '/apex/' + 'TakeSurveyForRevenue?';
    }
    
    RevenueSurvey__c s = new RevenueSurvey__c();
    s.Name = newSurveyName;
    s.URL__c = urlToSave;
    s.Submit_Response__c = 'empty';
    s.thankYouText__c = System.Label.LABS_SF_Survey_Submitted_Thank_you;
    s.Thank_You_Link__c='http://www.salesforce.com';
    try{
     insert s;
     createAnonSurveyTaker(s.Id);
     return new Pagereference('/apex/RevenueSurveyManagerPage?id='+s.Id);
    }catch(Exception e){
      return null;
    }
  }

  private static void createAnonSurveyTaker(String surveyId){
     list <Revenue_Survey_Taken__c> sTakers = [select id from Revenue_Survey_Taken__c where RevenueSurvey__c = :surveyId and Contact__c = null and Case__c = null];
     if(sTakers != null && sTakers.size()>0)
       return;
     Revenue_Survey_Taken__c st = new Revenue_Survey_Taken__c();      
     st.Case__c = null;
     st.RevenueSurvey__c = surveyId;
     st.Contact__c = null;
     insert st;
  }
  
  private String setupDomainForSurvey(String pod){
    if(pod != 'NO_POD' && !useTopLevelDomain && checkSubdomain(subdomain)){
      return 'http://'+subdomain+'.'+pod+'.force.com';
    }
    else if(pod != 'NO_POD' && useTopLevelDomain && checkSubdomain(subdomain)){
      return 'http://'+subdomain+'.'+pod;
    }
    else if(useTopLevelDomain) {
      return 'http://'+subdomain;   
    }
    else{
      return 'http://'+subdomain+'.force.com';
    }
  }
  
  private boolean checkSubdomain(String subdomain){
    if(subdomain == null)
     return false;
    else if (subdomain.contains('developer-edition'))
     return true;
    else
     return false;
  }
  
  private String setupUrlPrefix(String site){
    if(site == null || site=='EMPTY')
     return '';
    else
     return site+'/';
  }

  public Pagereference doSurveyReset(){
    setAllSurveys();
    return null;
  }
  
  static webservice String revenuedeleteSurvey(String deleteId){
    RevenueSurvey__c s= [Select Id, Name from RevenueSurvey__c where Id =:deleteId];
    delete s;
    
    return 'true';
  }

  
  public Class miniSurvey{
    public String sName {get; set;}
    public String sId   {get; set;}
    
    public miniSurvey(String miniName, String miniId){
      sName = miniName;
      sId = miniId;
    } 
      
  }
}