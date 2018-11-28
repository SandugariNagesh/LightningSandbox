({
    helperMethod : function() {
        
    },
    validateAddressMethod : function(component, event, helper){
        var userValue = component.find("levels").get("v.value");//component.find("username").get("v.value");
       // console.log(userValue);
        
        var action = component.get('c.validateAddress');
        var atlasMapURL = '';
        atlasMapURL = 'https://atlas.phila.gov/#/' + userValue + '/property';
       // console.log('atlas ' + atlasMapURL);
        component.set("v.mapURL", atlasMapURL);
        
        action.setParams({
            enteredAddress : userValue
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var responseString;
            if(state == 'SUCCESS')
            {
                
                responseString = response.getReturnValue();
                
                if(responseString != 'Invalid Address')
                {
                    
                    component.set("v.enteredAddressResponse", 'Successful City Address');  
                    // console.log('### line 43');
                    var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
                    var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
                    var sParameterName;
                    var i;
                    
                    for (i = 0; i < sURLVariables.length; i++) {
                        sParameterName = sURLVariables[i].split('='); //to split the key from the value.
                        
                        if (sParameterName[0] === 'Name') { //lets say you are looking for param name - firstName
                            sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
                        }
                    }
                    
                    console.log('sparameter Name : ' + sParameterName[1]);
                    var dept= sParameterName[1].replace(/_/g,'-').toLowerCase();
                    
                    if(dept=='maintenance-residential')
                        dept='maintenance-residential-or-commercial';
                    if(dept=='other' )
                        dept='other-streets';
                    if(dept=='miscellaneous' )
                        dept = 'other-streets';
                    if(dept=='abandoned-automobile' )
                        dept = 'abandoned-vehicle';
                    
                    if(dept == 'graffiti-removal' )
                        dept = 'graffiti';
                    
                    
                    var recType = component.get("v.recordTypeName");
                    // window.location.href='https://edgemile-philly.cs19.force.com/customer/s/pothole#'+responseString;  
                    //  window.location.href='https://edgemile-philly.cs19.force.com/customer/s/'+dept+'#'+responseString;    
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "url": '/'+dept+'#'+responseString
                    });
                    urlEvent.fire();
                }
                else
                {
                    component.set("v.enteredAddressResponse", response.getReturnValue());  
                }
                if(responseString == 'Invalid Address')
                {
                    component.set("v.enteredAddressResponse", 'Address not found. Please enter a valid address for the City of Philadelphia'); 	  
                    //.log(' line # 32');
                }
            }
            else
            {
                //console.log('FAILED');
            }
        });
        $A.enqueueAction(action);
        
        // console.log('### responseString - '+responseString);
        if(responseString == 'Valid Address')
        {
           // console.log('### line 43');
            //window.location.href='https://edgemile-philly.cs19.force.com/customer/s/createrecord/Abandoned_Vehicle';    
        }
        
    },
    
    
    
    validateAddressMethodNew : function(component, event, helper){
        // console.log('test');
        
        var userValue = component.find("username").get("v.value");
        
        var action = component.get('c.validateAddressNew');
        var atlasMapURL = '';
        atlasMapURL = 'https://atlas.phila.gov/#/' + userValue + '/property';
       // console.log('atlas ' + atlasMapURL);
        component.set("v.mapURL", atlasMapURL);
        
        action.setParams({
            enteredAddress : userValue
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var responseString;
            var flag = true;
            if(state == 'SUCCESS')
            {
                component.set("v.Units", response.getReturnValue());  
                
                responseString = response.getReturnValue();
                
                
                if(responseString.length>1)
                {
                    flag = false;
                    var cmpTarget = component.find('changeIt');
                    
                    $A.util.removeClass(cmpTarget, 'multiAdd');
                    component.find("levels").set("v.value",responseString[0]);
                }
                
                if(responseString != 'Invalid Address' && flag)
                {
                    
                    var action = component.get('c.validateAddress');
                    var atlasMapURL = '';
                    atlasMapURL = 'https://atlas.phila.gov/#/' + userValue + '/property';
                 //   console.log('atlas ' + atlasMapURL);
                    component.set("v.mapURL", atlasMapURL);
                    
                    action.setParams({
                        enteredAddress : responseString[0]
                    });
                    
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        var responseString;
                        if(state == 'SUCCESS')
                        {
                            //component.set("v.enteredAddressResponse", response.getReturnValue());  
                            
                            responseString = response.getReturnValue();
                            
                            if(responseString != 'Invalid Address')
                            {
                                
                                
                                
                                component.set("v.enteredAddressResponse", 'Successful City Address');  
                                // console.log('### line 43');
                                var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
                                var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
                                var sParameterName;
                                var i;
                                
                                for (i = 0; i < sURLVariables.length; i++) {
                                    sParameterName = sURLVariables[i].split('='); //to split the key from the value.
                                    
                                    if (sParameterName[0] === 'Name') { //lets say you are looking for param name - firstName
                                        sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
                                    }
                                }
                                
                                // console.log('sparameter Name : ' + sParameterName[1]);
                                var dept= sParameterName[1].replace(/_/g,'-').toLowerCase();
                                
                                if(dept=='maintenance-residential')
                                    dept='maintenance-residential-or-commercial';
                                if(dept=='other' )
                                    dept='other-streets';
                                if(dept=='miscellaneous' )
                                    dept = 'other-streets';
                                if(dept=='abandoned-automobile' )
                                    dept = 'abandoned-vehicle';
                                if(dept == 'graffiti-removal' )
                                    dept = 'graffiti';
                                
                                
                                var recType = component.get("v.recordTypeName");
                                // window.location.href='https://edgemile-philly.cs19.force.com/customer/s/pothole#'+responseString;  
                                // window.location.href='https://edgemile-philly.cs19.force.com/customer/s/'+dept+'#'+responseString;    
                                var urlEvent = $A.get("e.force:navigateToURL");
                                var newUrl = '/'+dept+'#'+responseString;
                                urlEvent.setParams({
                                    "url": newUrl
                                });
                                urlEvent.fire();
                            }
                            else
                            {
                                component.set("v.enteredAddressResponse", response.getReturnValue());  
                            }
                            if(responseString == 'Invalid Address')
                            {
                                component.set("v.enteredAddressResponse", 'Address not found. Please enter a valid address for the City of Philadelphia'); 	  
                              //  console.log(' line # 32');
                            }
                        }
                        else
                        {
                           // console.log('FAILED');
                        }
                    });
                    $A.enqueueAction(action);
                    
                    // console.log('### responseString - '+responseString);
                    if(responseString == 'Valid Address')
                    {
                        //console.log('### line 43');
                    }
                    
                }
                
                if(responseString == 'Invalid Address')
                {
                    component.set("v.enteredAddressResponse", 'Address not found. Please enter a valid address for the City of Philadelphia'); 	  
                }
            }
            else
            {
              //  console.log('FAILED');
            }
        });
        $A.enqueueAction(action);
        
    }
})