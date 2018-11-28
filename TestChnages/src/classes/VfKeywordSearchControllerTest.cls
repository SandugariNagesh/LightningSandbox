@isTest(seeAlldata=true)
public class VfKeywordSearchControllerTest{

    static testMethod void vfKeywordSearchControllertest(){

        KnowledgeArticleVersion kav = [SELECT Id, title, UrlName, LastPublishedDate,LastModifiedById FROM KnowledgeArticleVersion limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(kav);
        vfKeywordSearchController vfKeywordSchCntr = new vfKeywordSearchController(sc);
        vfKeywordSearchController vfKeywordSchCntr1 = new vfKeywordSearchController();      
        System.assertEquals( vfKeywordSchCntr.getPrevRequired(),false);
        System.assertEquals( vfKeywordSchCntr.getCurrentPageNumber(),1);
        PageReference pageref = vfKeywordSchCntr.Next();
        PageReference prevpageref = vfKeywordSchCntr.previous();
        vfKeywordSchCntr.getNextRequired();
        system.debug(vfKeywordSchCntr.searchstring);
        system.debug(vfKeywordSchCntr.articlesList);
        system.debug(vfKeywordSchCntr.hiddenInput);

    }
}