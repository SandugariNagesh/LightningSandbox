({
    
    doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location);
        var sURLVariables = sPageURL.split('#');
       // console.log('sURLVariables' +sURLVariables[1])
        
        component.set("v.parentId", sURLVariables[1]);
        
        var action = component.get("c.takeCMX"); 
        action.setParams({recId : sURLVariables[1]})
        //debugger;
        
        component.find("ResidentialOrCommerical").set("v.disabled", true);
        component.find("UnitNumber").set("v.disabled", true);
        component.find("enterAddress").set("v.disabled", true);
        action.setCallback(this, function(response){ 
            var state = response.getState(); 
            
            if(state != "SUCCESS"){ 
                alert('Failed to update record'); 
            } 
            else
            {
                var zoning = response.getReturnValue();
                var retDate = zoning.split('++++');
                var case_obj1 = component.get("v.CaseObj");
                case_obj1.Residential_or_Commerical__c = retDate[0];
                case_obj1.Unit_Number__c = retDate[1];
                component.set("v.CaseObj",case_obj1);
                component.set("v.Address",retDate[2]);
            }
        }); 
        $A.enqueueAction(action);
        
    },
    fLIUI_Button_Clicked : function(component, event, helper) {
        
        var case_obj = component.get("v.CaseObj"); 
        var caseId ;
        var sPageURL = decodeURIComponent(window.location);
        var sURLVariables = sPageURL.split('#');
        var sParameterName;
        var i;
        var newFlag = true;
        
        
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
        
        if(isValidEmail){
            
            if(case_obj.Unit_Number__c == "" && (case_obj.Residential_Property_Type__c == 'Condo' || case_obj.Residential_Property_Type__c == 'Apartment') )
            {
                newFlag = false;
                component.set("v.errUnitNumber", "Value is required");
            }
            
            if(case_obj.Adult_Present_to_Provide_Access_to_Inspe__c == "" && case_obj.Exterior_or_Interior__c == 'Interior' && case_obj.Residential_or_Commerical__c == 'Residential' )
            {
                newFlag = false;
                component.set("v.errAdultPresenttoProvideAccesstoInspe", "Value is required");
            }
            
            if(case_obj.Residential_or_Commerical__c == 'Residential' && case_obj.Residential_Property_Type__c == ""  )
            {
                newFlag = false;
                component.set("v.errResidentialPropertyType", "Value is required");
            }
            
            
            if(newFlag){
                
                
                //  console.log('--->' + sURLVariables[1])
                var action = component.get("c.createCase"); 
                action.setParams({caseObj : case_obj,recName : "Maintenance Residential or Commercial",addrId : sURLVariables[1]}); 
                action.setCallback(this, function(response){ 
                    var state = response.getState(); 
                    
                    if(state != "SUCCESS"){ 
                        alert('Failed to update record'); 
                    } 
                    else
                    {
                        caseId = response.getReturnValue();
                        var dd = caseId.length;
                      //  console.log('---   > ' + dd);
                        if(dd > 2)
                        {
                            
                            if (component.find("fileId").get("v.files") != null) {
                                helper.uploadHelper(component, event);
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
                  //  console.log(case_obj.Running_Water__c);
                }); 
                $A.enqueueAction(action);
            }
        }
        
    } ,
    
    
    New_Button_Clicked : function(component, event, helper) {
     //   console.log('hi');
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
           // console.log(case_obj.Running_Water__c);
        }); 
        $A.enqueueAction(action);
        
        
        
        
        
    },
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
       // console.log('sdfdf');
        helper.show(component,event);
        var files = component.get("v.FileList");
       // console.log('files' +files.length);
        if (files && files.length > 0) {
            
            var file = files[0];
            var reader = new FileReader();
            reader.onloadend = function() {
                
                
                
              //  console.log('ssdf'+fileContents);
                var dataURL = reader.result;
                var content = dataURL.match(/,(.*)$/)[1];
             //   console.log(content[1]);
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