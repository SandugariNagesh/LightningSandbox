@isTest(SeeAllData=true)
public class x311TemplateControllerSample_test{

      static testmethod void x311Template(){       
           FAQ1__kav a=new FAQ1__kav ();
           a.Title='test apex';
           a.Summary='test from apex';
           a.URLName='Test';
           insert a;
           
      ApexPages.StandardController sc=new ApexPages.StandardController(a);    
           x311TemplateControllerSample Temp=new x311TemplateControllerSample(sc);
           Temp.redirectSubscribe();
           Temp.rateArticleRedirect();
           Temp.logCase();
           Temp.kbLogCase();
   
  }
  
 }