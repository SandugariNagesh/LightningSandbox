({
    
    doInit : function(component, event, helper) {
        var sPageURL = decodeURIComponent(window.location);
        //  console.log('sPageURL' +sPageURL)
        var sURLVariables = sPageURL.split('#');
        //  console.log('sURLVariables' +sURLVariables[1])
        
        component.set("v.parentId", sURLVariables[1]);
        
        
        var action = component.get("c.takeAddress"); 
        action.setParams({recId : sURLVariables[1]})
        // debugger;
        
        
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
        
        //================email validation========================
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
            
            
            
            //================email validation========================
            // console.log('hi');
            var case_obj = component.get("v.CaseObj"); 
            
            var caseId ;
            
            
            var sPageURL = decodeURIComponent(window.location);
            //  console.log('sPageURL' +sPageURL)
            var sURLVariables = sPageURL.split('#');
            //  console.log('sURLVariables' +sURLVariables[1])
            
            var sParameterName;
            var i;
            
            
            
            //   console.log('--->' + sURLVariables[1])
            var action = component.get("c.createCase"); 
            action.setParams({caseObj : case_obj,recName : "Other (Streets)",addrId : sURLVariables[1]}); 
            action.setCallback(this, function(response){ 
                var state = response.getState(); 
                
                if(state != "SUCCESS"){ 
                    alert('Failed to update record'); 
                } 
                else
                {
                    if (component.find("fileId").get("v.files") != null) {
                        helper.uploadHelper(component, event);
                    } else {
                        //alert('Please Select a Valid File');
                    }
                    caseId = response.getReturnValue();
                    var dd = caseId.length;
                    //      console.log('---   > ' + dd);
                    if(dd > 2)
                    {
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
                //console.log(case_obj.Running_Water__c);
            }); 
            $A.enqueueAction(action);
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
      //  console.log('sdfdf');
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