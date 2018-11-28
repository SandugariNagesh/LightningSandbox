/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class AutomationWrapper {
    global sf4twitter.AutomationWrapper.Result results {
        get;
        set;
    }
    global Boolean testMode {
        get;
        set;
    }
    global AutomationWrapper() {

    }
    global void SendToFacebook(sf4twitter__Fcbk_Page__c p, String msg) {

    }
    global void SendToTwitter(sf4twitter__Twitter_Account__c ta, String msg) {

    }
    webService static String doFcbkPageSearch(Id fcbkPageId, Integer page) {
        return null;
    }
    global Integer doGlobalFcbkPageSearch(Id fcbkPageId, Integer page) {
        return null;
    }
    global Integer doGlobalSearchAccount(Id taId, Integer page) {
        return null;
    }
    global Integer doGlobalSearchKeyword(Id tsId, Integer Page) {
        return null;
    }
    webService static String doSearchAccount(Id taId, Integer Page) {
        return null;
    }
    webService static String doSearchKeyword(Id tsId, Integer Page) {
        return null;
    }
global class Result {
    global Integer caseCommentsCreated {
        get;
        set;
    }
    global Integer casesCreated {
        get;
        set;
    }
    global Integer contactsCreated {
        get;
        set;
    }
    global Integer conversationsCreated {
        get;
        set;
    }
    global Integer errorCode {
        get;
        set;
    }
    global String errorMsg {
        get;
        set;
    }
    global Integer leadsCreated {
        get;
        set;
    }
    global String xml {
        get;
        set;
    }
    global Result() {

    }
}
global class Sf4TwitterException extends Exception {
}
}
