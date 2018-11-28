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
    
    Submit_Button_Clicked : function(component, event, helper) {
        
        var case_obj = component.get("v.CaseObj"); 
        var caseId ;
        
        var sPageURL = decodeURIComponent(window.location);
        var sURLVariables = sPageURL.split('#');
        
        var sParameterName;
        var i;
        
        
      
        var action = component.get("c.createCase"); 
        action.setParams({caseObj : case_obj,recName : "Abandoned Vehicle",addrId : sURLVariables[1]}); 
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
                    if (component.find("fileId").get("v.files")!= null) {
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
        }); 
        $A.enqueueAction(action);
        
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
                helper.upload(component, file, encodeURIComponent(fileContents), function(answer) {
                    if (answer) {
                        helper.hide(component,event);
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