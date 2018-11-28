({
    getCaseRecordType : function(component) {
        
        var action = component.get("c.getCaseRecordTypes");
        
        action.setCallback(this, function(data) {
            var state = data.getState();
            if(state == 'SUCCESS')
            {
                component.set("v.listOfRecordTypes", data.getReturnValue());
               // console.log(data.getReturnValue());
            }
            else
            {
                console.log('something went wrong');
            }
        });
        $A.enqueueAction(action);
    }
    
})