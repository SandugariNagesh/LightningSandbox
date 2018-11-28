@isTest
public class FeedbackExtensionTest{

    static testMethod void FeedbackExtensionTest(){
        ApexPages.StandardController sc;
        FeedbackExtension fx = new FeedbackExtension(sc);
        fx.getWeeksByDateProductUser();
        fx.getFeedbackWeeks();
    }
}