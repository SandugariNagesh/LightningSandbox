({
    
    doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location);
        var sURLVariables = sPageURL.split('#');
        
        component.set("v.parentId", sURLVariables[1]);
        var cssTarget = component.find('fileId');
        $A.util.addClass(cssTarget, 'borderClass');
        
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
    Submit_Clicked : function(component, event, helper) {
        
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
            
            var flag = true;
            var OnInterstateHighway = component.find("OnInterstateHighwayCmp");
            var OnInterstateHighwayvalue = OnInterstateHighway.get("v.value");
            
            if ( OnInterstateHighwayvalue == "") {
                component.set("v.errOnInterstateHighway", "Value is required");
                flag = false;
            } else {
                component.set("v.errOnInterstateHighway", null);
            }
            
            var RunningWaterfromhole = component.find("RunningWaterfromholeCmp");
            var RunningWaterfromholevalue = RunningWaterfromhole.get("v.value");
            
            if ( RunningWaterfromholevalue == "") {
                component.set("v.errRunningWaterfromhole", "Value is required");
                flag = false;
            } else {
                component.set("v.errRunningWaterfromhole", null);
            }
            
            
            var HasaUtilityCompanybeenrecentlywork = component.find("HasaUtilityCompanybeenrecentlyworkCmp");
            var HasaUtilityCompanybeenrecentlyworkvalue = HasaUtilityCompanybeenrecentlywork.get("v.value");
            
            if ( HasaUtilityCompanybeenrecentlyworkvalue == "") {
                component.set("v.errHasaUtilityCompanybeenrecentlywork", "Value is required");
                flag = false;
            } else {
                component.set("v.errHasaUtilityCompanybeenrecentlywork", null);
            }
            
            var UtilityCompany = component.find("UtilityCompanyCmp");
            var UtilityCompanyvalue = UtilityCompany.get("v.value");
            
            if ( UtilityCompanyvalue == "" && HasaUtilityCompanybeenrecentlyworkvalue != 'No') {
                component.set("v.errUtilityCompany", "Value is required");
                flag = false;
            } else {
                component.set("v.errUtilityCompany", null);
            }
            
            if(flag){
                
                
                var case_obj = component.get("v.CaseObj"); 
                var newFlag = false;
                
                {
                    var caseId ;
                    
                    
                    var sPageURL = decodeURIComponent(window.location);
                    var sURLVariables = sPageURL.split('#');
                    
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
                            var dd = caseId.length;
                            if(dd > 2)
                            {
                                if (component.find("fileId").get("v.files") != null) {
                                    
                                    helper.uploadHelper(component, event);
                                } else {
                                    
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
                       // console.log(case_obj.Running_Water__c);
                    }); 
                    $A.enqueueAction(action);
                }
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
                    }
                    else{
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
    validationCall : function(component, event, helper) {
        console.log(event.getSource().get("v.value"));
        var utility = event.getSource().get("v.value");
        var cmpTarget = component.find('changeIt');
        var newTarget = component.find('addBlock');
        
        if(utility == 'No')
        {
            $A.util.addClass(cmpTarget, 'changeMe');
            $A.util.addClass(newTarget, 'addit');
            
        }
        if(utility == 'Yes')
        {
            $A.util.removeClass(cmpTarget, 'changeMe');
            $A.util.removeClass(newTarget, 'addit');
        }
    },
    
    showMessage: function(component, event, helper) {
        var case_obj = component.get("v.CaseObj"); 
        
        console.log(case_obj.On_State_Highway__c);
        if(case_obj.On_State_Highway__c == "Yes")
        {
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/caseresponcemessage?message#OnStateHighWay"
            });
            urlEvent.fire();
        }
        
        if(case_obj.Running_Water__c == "Yes")
        {
            
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/caseresponcemessage?message#RunningWater"
            });
            urlEvent.fire();
        }
        
        
        if(case_obj.Utility_Company__c != "" && case_obj.Utility_Company__c != 'Not Known')
        {
            
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/caseresponcemessage?message#UtilityCompany"
            });
            urlEvent.fire();
        }
    }
    
    
})