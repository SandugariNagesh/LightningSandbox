@isTest(seeAllData = true)
//Test class for testing the trigger on cases
private class RateArticleControllerTest {
    public static PageReference pageRef = Page.X311TemplateFAQRatestar;
    //pageref.getParameters().put('artnum', '900003120');
    
      
    
    static testMethod void RateArticleControllerTest1() { 
    pageref.getParameters().put('artnum', '900003120');
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
        RateArticleController c = new RateArticleController ();
        c.rating = 1;
        c.rateArticle1();
        c.rateArticle1();
    }   
    static testMethod void RateArticleControllerTest2() { 
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
        RateArticleController c = new RateArticleController ();
        c.rating = 2;
        c.rateArticle2();
    }
    static testMethod void RateArticleControllerTest3() { 
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
        RateArticleController c = new RateArticleController ();
        c.rating = 3;
        c.rateArticle3();
    }
    static testMethod void RateArticleControllerTest4() { 
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
        RateArticleController c = new RateArticleController ();
        c.rating = 4;
        c.rateArticle4();
    }
    static testMethod void RateArticleControllerTest5() { 
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
        RateArticleController c = new RateArticleController ();
        c.rating = 5;
        c.rateArticle5();
    }
    static testMethod void RateArticleControllerTest6() { 
        Test.setCurrentPage(pageRef);
        apexpages.currentpage().getparameters().put('artnum', '900003120');
         ApexPages.KnowledgeArticleVersionStandardController ctl = new ApexPages.KnowledgeArticleVersionStandardController(new FAQ1__kav());
    
        RateArticle__c articleRate = new RateArticle__c  (rating__c = 1,Article_Number__c = '900003120');
      /*articleRate.rating__c = 1;
      articleRate.Article_Number__c = '900003120';
      */
      insert articleRate;
        RateArticleController c1 = new RateArticleController (ctl);
    
    }   
}