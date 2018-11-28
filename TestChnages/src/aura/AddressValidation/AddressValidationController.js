({
   doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
        var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
        var sParameterName;
        var i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('='); //to split the key from the value.

            if (sParameterName[0] === 'firstName') { //lets say you are looking for param name - firstName
                sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
            }
        }
  
    },
	myAction : function(component, event, helper) {
		
	}, 
    handleClick : function(component, event, helper)
    {
        var userValue = component.find("levels").get("v.value");
       // console.log(userValue);
        if(userValue != null)
        {
            helper.validateAddressMethod(component, event, helper);
        }
        else
        {
        helper.validateAddressMethodNew(component, event, helper);
            }
    },
     searchEvents: function(component, event, helper) {
    //  console.log(event.getParams().keyCode);
      if(event.getParams().keyCode == 13){
        helper.validateAddressMethodNew(component, event, helper);
      }
   },
    onSelectChange: function(component, event, helper) {
        //  helper.validateAddressMethod(component, event, helper);
    }

})