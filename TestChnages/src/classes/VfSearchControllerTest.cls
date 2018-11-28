@isTest
private class VfSearchControllerTest {
    static testMethod void validateDataCategoryGroupInfo(){
        DataCategoryGroupInfo[] dataCategoryGroupInfo =
        DataCategoryUtil.getInstance().getAllCategoryGroups();
        VfSearchController vfSearchControllerObj = new VfSearchController();
        System.assertEquals(vfSearchControllerObj.getDataCategoryGroupInfo().size(),
        dataCategoryGroupInfo.size());
    }
    static testMethod void testClassVariables() {
        VfSearchController vfSearchControllerObj = new VfSearchController();
        vfSearchControllerObj.refreshSearchResult();
        System.assertEquals(vfSearchControllerObj.getCurrentPageNumber(),1.0);
        vfSearchControllerObj.next();
        System.assertEquals(vfSearchControllerObj.getCurrentPageNumber(),1.0);
        vfSearchControllerObj.previous();
        System.assertEquals(vfSearchControllerObj.getCurrentPageNumber(),1.0);
        System.assertEquals(vfSearchControllerObj.getPrevRequired(),false);
        System.assertEquals(vfSearchControllerObj.getNextRequired(),false);
    }
    static testMethod void validateCategoryKeyword() {
        VfSearchController vfSearchControllerObj = new VfSearchController();
        DataCategoryGroupInfo[] categoryGroups =
        DataCategoryUtil.getInstance().getAllCategoryGroups();
        String categoryCondition = '';
        for (DataCategoryGroupInfo categoryGroup : categoryGroups) {
            ApexPages.currentPage().getParameters().put('categoryType_'+categoryGroup.getName(),'All');
            if(categoryCondition==''){
                categoryCondition=categoryCondition+categoryGroup.getName() + ':' +
                System.currentPageReference().getParameters().Get('categoryType_'+categoryGroup.getName());
            }else {
                categoryCondition=categoryCondition + ',' +categoryGroup.getName() + ':' +
                System.currentPageReference().getParameters().Get('categoryType_'+categoryGroup.getName());
            }
        }
        System.assertEquals(categoryCondition, vfSearchControllerObj.getCategoryKeyword());
   }
}