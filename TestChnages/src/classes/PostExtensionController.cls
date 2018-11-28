public with sharing class PostExtensionController {
    
    public string key1{get;set;}
    public String exception1 {get; set;}
    
    public PostExtensionController(PostMethodImplementationController controller) {
        key1 = ApexPages.currentPage().getParameters().get('key'); 
        
        //Support Ticket # 091909892
        //Added variable to show the exception message to the User, thrown while creation of API Key
        exception1 = ApexPages.currentPage().getParameters().get('error');
    }
}