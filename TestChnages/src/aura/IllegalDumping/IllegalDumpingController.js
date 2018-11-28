({
    
    doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location);
        
        var sURLVariables = sPageURL.split('#');
        var case_obj = component.get("v.CaseObj"); 
        
        component.set("v.parentId", sURLVariables[1]);
        
        var action = component.get("c.takePolice"); 
        action.setParams({recId : sURLVariables[1]})
        
        
        component.find("enterAddress").set("v.disabled", true);
        component.find("gisPolice").set("v.disabled", true);
        component.find("gisSanitation").set("v.disabled", true);
        action.setCallback(this, function(response){ 
            var state = response.getState(); 
            
            if(state != "SUCCESS"){ 
                alert('Failed to update record'); 
            } 
            else
            {
                var addrs = response.getReturnValue();
                console.log(addrs);
                var splitString = addrs.split('++++');
                component.set("v.Address",splitString[0]);
                component.set("v.CaseObj.Police_District__c",splitString[1]);
                component.set("v.CaseObj.Sanitation_District__c",splitString[2]);
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
            
            
            if(case_obj.Are_Materials_Hazardous__c == '')
            {
                newFlag = false;
                component.set("v.errIncludesHouseholdHazardousWaste", "Value is required");
            }
            else{
                component.set("v.errIncludesHouseholdHazardousWaste", "");
            }
            
            if(case_obj.Trash_Include_Commercial_Hazardous_Waste__c == '')
            {
                newFlag = false;
                component.set("v.errIstherecommercialhazardousWaste", "Value is required");
            }
            else{
                component.set("v.errIstherecommercialhazardousWaste", "");
            }
            
            if(case_obj.Is_Trash_on_Street_or_Sidewalk__c == '')
            {
                newFlag = false;
                component.set("v.errTrashonStreetorSidewalk", "Value is required");
            }
            else{
                component.set("v.errTrashonStreetorSidewalk", "");
            }
            
            if(case_obj.Is_Trash_on_Vacant_Lot__c == '')
            {
                newFlag = false;
                component.set("v.errTrashonVacantLot", "Value is required");
            }
            else{
                component.set("v.errTrashonVacantLot", "");
            }
            
            
            if(case_obj.Active_Construction__c == '')
            {
                newFlag = false;
                component.set("v.errActiveConstruction", "Value is required");
            }
            else{
                component.set("v.errActiveConstruction", "");
            }
            
            
            if(case_obj.Condition_of_Materials__c == '')
            {
                newFlag = false;
                component.set("v.errConditionofMaterials", "Value is required");
            }
            else{
                component.set("v.errConditionofMaterials", "");
            }
            
            if(case_obj.Type_of_Materials__c == '')
            {
                newFlag = false;
                component.set("v.errTypeofMaterials", "Value is required");
            }
            else{
                component.set("v.errTypeofMaterials", "");
            }
            
            
            if(newFlag)
            {
                
                var action = component.get("c.createCase"); 
                action.setParams({caseObj : case_obj,recName : "Illegal Dumping",addrId : sURLVariables[1]}); 
                action.setCallback(this, function(response){ 
                    var state = response.getState(); 
                    
                    if(state != "SUCCESS"){ 
                        alert('Failed to update record'); 
                    } 
                    else
                    {
                        caseId = response.getReturnValue();
                        var dd = caseId.length;
                        if(dd > 2)
                        {
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
        helper.show(component,event);
        var files = component.get("v.FileList");
        if (files && files.length > 0) {
            
            var file = files[0];
            var reader = new FileReader();
            reader.onloadend = function() {
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