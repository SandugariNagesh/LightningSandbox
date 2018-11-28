trigger TaskIsPublishedForRevenue on Task (Before insert) {
for (Task t: trigger.new){
        if (t.Status == 'Completed'){
        string userProfileId = userInfo.getProfileID();
          if (userProfileId =='00e1M000000S8iUQAS' || userProfileId =='00e1M000000S8iZQAS') {
            t.IsVisibleInSelfService = TRUE;
            }
        }
    }
}