({
	Submit_Clicked : function(component, event, helper) {
         var sPageURL = decodeURIComponent(window.location);
       // console.log('sPageURL' +sPageURL)
        var sURLVariables = sPageURL.split('/');
       // console.log('sURLVariables' +sURLVariables);
        var passvalue;
        for(var i in sURLVariables) { 
            var passvalue = sURLVariables[i];
            
        } 
      
        
         var urlEvent = $A.get("e.force:navigateToURL");
                            urlEvent.setParams({
                                "url": "/useraddressinput?Name="+passvalue
                            });
                            urlEvent.fire();
		
	}
})