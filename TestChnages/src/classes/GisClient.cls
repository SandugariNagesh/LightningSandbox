global class GisClient {
  @RemoteAction
    global static List<Case> QueryByRadius(String recordType, Double x, Double y, Double radiusFeet) {
        //system.debug('recordType: ' + recordType);
        //system.debug('x: ' + x);
        //system.debug('y: ' + y);
    //system.debug('radiusFeet: ' + radiusFeet);

        ID recordTypeId = ID.ValueOf(recordType);
        //system.debug('recordTypeId: ' + recordTypeId);

    // convert to miles
        Double radiusMiles = radiusFeet / 5280;
        //system.debug('radiusMiles: ' + radiusMiles);

        // run query
        List<Case> cases = [
            SELECT Id, CaseNumber,  Service_Request_Type__c,  Subject, Street__c, Centerline__longitude__s, Centerline__latitude__s
            FROM Case
            WHERE
        Centerline_2272x__c != null AND
            Centerline_2272y__c != null AND
            Centerline__Longitude__s != null AND
            Centerline__Latitude__s != null AND
            RecordTypeId = :recordTypeId AND
            IsClosed = false AND
            DISTANCE(Centerline__c, GEOLOCATION(:y, :x), 'mi') < :radiusMiles
        ];

    return cases;
    }
}