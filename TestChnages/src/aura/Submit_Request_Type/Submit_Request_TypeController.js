({
    doInit : function(component, event, helper) {
        helper.getCaseRecordType(component);
    },
    
    doSomething: function (component, event, helper) {
      
        var allRec = component.get("v.listOfRecordTypes"); 
        var recordName = event.getSource().get("v.label");
        var recordNameforUrl;
      
        for(var index in allRec) { 
            var attr = allRec[index].Name; 
           
            if(attr == recordName)
            {
                recordNameforUrl = allRec[index].DeveloperName;
            }
        }
     

        
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/useraddressinput?Name="+recordNameforUrl
        });
        urlEvent.fire();
    }
    
    
    
})