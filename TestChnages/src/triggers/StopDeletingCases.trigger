//This trigger is to restrict delete case for everyone except Raju Kona and Graham Quinn. 
//Please dont disable with out consulting us.

trigger StopDeletingCases on Case (before Delete) {
System.debug('userInfo.getUserId() :' + userInfo.getUserId());
    if(userInfo.getUserId() != '00516000007QGLuAAO' && userInfo.getUserId() != '005G0000003WA0fIAG'){
       for (Case c : Trigger.old) {
       c.addError('Please "CLOSE" the Case. Dont DELETE.');
        }
    }
}