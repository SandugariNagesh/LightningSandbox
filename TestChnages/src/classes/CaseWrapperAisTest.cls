@isTest
private class CaseWrapperAisTest {
  static testMethod void testRegeocode() {
    // create mock case id list
    String[] caseIdList =  new String[]{
                             '5001600000dngq5AAA',
                             '5001600000dngqKAAQ'
                           };

    // test
    CaseWrapperAis.regeocode(caseIdList);
  }
}