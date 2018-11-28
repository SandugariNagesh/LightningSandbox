({
	execute : function(component, event, helper) {
            // TODO: Review the migrated code
		if ('{!TEXT($User.UserType)}' == 'Standard') 
{
  if (''+component.get('v.Profile.Name')+'' == 'SFDC Administrators' || ''+component.get('v.User.Name')+'' == 'Maryelis Santiago') 
  {
helper.gotoURL(component, '/apex/SmokeDetectorPDF?id='+component.get('v.sObjectInfo.Id')+'');
  } else {
    alert('You do not have the permission to Generate PDF. Please contact your administrator');
  }
} else {
  if (''+component.get('v.User.Department')+'' == 'Fire Department') 
  {
helper.gotoURL(component, '/internal/SmokeDetectorPDF?id='+component.get('v.sObjectInfo.Id')+'');
  } else {
    alert('You do not have the permission to Generate PDF. Please contact your administrator');
  }
}

            $A.get("e.force:closeQuickAction").fire();   
	}
})