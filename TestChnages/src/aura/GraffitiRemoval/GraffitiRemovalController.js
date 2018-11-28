({
    
    doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location);
        var sURLVariables = sPageURL.split('#');
        
        component.set("v.parentId", sURLVariables[1]);
        
        var action = component.get("c.takeAddress"); 
        action.setParams({recId : sURLVariables[1]})
        
        component.find("enterAddress").set("v.disabled", true);
        action.setCallback(this, function(response){ 
            var state = response.getState(); 
            
            if(state != "SUCCESS"){ 
                alert('Failed to update record'); 
            } 
            else
            {
                var addrs = response.getReturnValue();
                component.set("v.Address",addrs);
            }
        }); 
        $A.enqueueAction(action);
        
    },
    fLIUI_Button_Clicked : function(component, event, helper) {
        
        var isValidEmail = true; 
        var emailField = component.find("EMail");
        var emailFieldValue = emailField.get("v.value");
        var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;  
        
        if(!$A.util.isEmpty(emailFieldValue)){   
            if(emailFieldValue.match(regExpEmailformat)){
                emailField.set("v.errors", [{message: null}]);
                $A.util.removeClass(emailField, 'slds-has-error');
                isValidEmail = true;
            }else{
                $A.util.addClass(emailField, 'slds-has-error');
                emailField.set("v.errors", [{message: "Please Enter a Valid Email Address"}]);
                isValidEmail = false;
            }
        }
        
        if(isValidEmail)
        {
            
            var case_obj = component.get("v.CaseObj"); 
            var caseId ;
            
            
            var sPageURL = decodeURIComponent(window.location);
            var sURLVariables = sPageURL.split('#');
            
            var sParameterName;
            var i;
            var newFlag = true;
            if(case_obj.Floor__c == '')
            {
                newFlag = false;
                component.set("v.errFloor", "Value is required");
            }
            else{
                component.set("v.errFloor", "");
            }
            
            if(case_obj.Painted_Surface__c == '')
            {
                newFlag = false;
                component.set("v.errPaintedSurface", "Value is required");
            }
            else{
                component.set("v.errPaintedSurface", "");
            }
            
            
            
            if(case_obj.Surface_Type__c == '')
            {
                newFlag = false;
                component.set("v.errSurfaceType", "Value is required");
            } else{
                component.set("v.errSurfaceType", "");
            }
            
            if(case_obj.Paint_Color__c == '')
            {
                newFlag = false;
                component.set("v.errPaintColor", "Value is required");
            } else{
                component.set("v.errPaintColor", "");
            }
            
            if(case_obj.Property_Type1__c == '')
            {
                newFlag = false;
                component.set("v.errPropertyType", "Value is required");
            } else{
                component.set("v.errPropertyType", "");
            }
            
            if(case_obj.Rail_Corridor__c == '')
            {
                newFlag = false;
                component.set("v.errRailCorridor", "Value is required");
            } else{
                component.set("v.errRailCorridor", "");
            }
            
            if(case_obj.Powerwash__c == '')
            {
                newFlag = false;
                component.set("v.errPowerwash", "Value is required");
            } else{
                component.set("v.errPowerwash", "");
            }
            
            if(case_obj.Property_Owner__c == '')
            {
                newFlag = false;
                component.set("v.errPropertyOwner", "Value is required");
            } else{
                component.set("v.errPropertyOwner", "");
            }
            
            if(case_obj.Painted_Surface__c == 'No' && case_obj.Powerwash__c != 'Yes' )
            {
                newFlag = false;
                component.set("v.errPowerwash", "If Painted Surface is No, then Powerwash must be Yes.");
            } else{
                component.set("v.errPowerwash", "");
            }
            
            if(case_obj.Painted_Surface__c == 'Yes' && case_obj.Paint_Color__c == '' )
            {
                newFlag = false;
                component.set("v.errPaintedSurface", "The Paint Color field must be populated if Painted Surface is Yes.");
            } else{
                component.set("v.errPaintedSurface", "");
            }
            
            
            
            
            if(newFlag)
            {
                var action = component.get("c.createCase"); 
                action.setParams({caseObj : case_obj,recName : "Graffiti Removal",addrId : sURLVariables[1]}); 
                action.setCallback(this, function(response){ 
                    var state = response.getState(); 
                    
                    if(state != "SUCCESS"){ 
                        alert('Failed to update record'); 
                    } 
                    else
                    {
                        caseId = response.getReturnValue();
                        var dd = caseId.length;
                        console.log('---   > ' + dd);
                        debugger;
                        if(dd > 2)
                        {
                            console.log(component.find("fileId").get("v.files"));
                            if (component.find("fileId").get("v.files") != null) {
                                helper.uploadHelper(component, event);
                            } else {
                                //alert('Please Select a Valid File');
                            }
                            var urlEvent = $A.get("e.force:navigateToURL");
                            urlEvent.setParams({
                                "url": "/case/"+caseId+"/detail"
                            });
                            urlEvent.fire();
                        }
                        else
                        {
                            component.set("v.message", "Something went wrong, try again");
                        }
                    }
                    console.log(case_obj.Running_Water__c);
                }); 
                $A.enqueueAction(action);
            }
        }
    } ,
    
    
    /*New_Button_Clicked : function(component, event, helper) {
        console.log('hi');
        var case_obj = component.get("v.CaseObj"); 
        
        var caseId ;
        
        var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
        var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
        var sParameterName;
        var i;
        
        var action = component.get("c.createCase"); 
        action.setParams({caseObj : case_obj,recName : "Street Defect",addrId : sURLVariables[1]}); 
        action.setCallback(this, function(response){ 
            var state = response.getState(); 
            
            if(state != "SUCCESS"){ 
                alert('Failed to update record'); 
            } 
            else
            {
                caseId = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/useraddressinput?Name=Pothole"
                });
                urlEvent.fire();
                
            }
            console.log(case_obj.Running_Water__c);
        }); 
        $A.enqueueAction(action);
        
        
        
        
        
    },*/
    handleUploadFinished : function(component, event, helper) {
        
        
        var uploadedFiles = event.getParam("files");
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "File "+uploadedFiles[0].name+" Uploaded successfully."
        });
        toastEvent.fire();
        
    },
    handleUploadFinished: function (cmp, event) {
        
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);
    },
    
    
    
    onFileUploaded:function(component,event,helper){
        console.log('sdfdf');
        helper.show(component,event);
        var files = component.get("v.FileList");
        console.log('files' +files.length);
        if (files && files.length > 0) {
            
            var file = files[0];
            var reader = new FileReader();
            reader.onloadend = function() {
                
                
                
                console.log('ssdf'+fileContents);
                var dataURL = reader.result;
                var content = dataURL.match(/,(.*)$/)[1];
                console.log(content[1]);
                helper.upload(component, file, encodeURIComponent(fileContents), function(answer) {
                    if (answer) {
                        helper.hide(component,event);
                        // Success
                    }
                    else{
                        // Failure
                    }
                });
            }
            reader.readAsDataURL(file);
        }
        else{
            helper.hide(component,event);
        }
    },
    
    
    
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
    
    
})