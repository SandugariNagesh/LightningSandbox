//Address validation Controller for Community Lightning Component
public class validatePhillyAddressController
{
    @AuraEnabled
    public static String validateAddress(String enteredAddress)
    {
        String ipstring= UserInfo.getSessionId() ;
        System.debug('Ip address - '+ ipstring);
        if(enteredAddress != null)
        {
            String encodedEnteredAddress = EncodingUtil.URLENCODE(enteredAddress,'UTF-8').replace('+', '%20');
            
            String url = 'http://api.phila.gov/ais_doc/v1/search/';
            //String url = 'http://api.phila.gov/ais_doc/v1/addresses/';
            url += encodedEnteredAddress ;
            url += '?gatekeeperKey=6ba4de64d6ca99aa4db3b9194e37adbf';
            //            url += '?include_units&gatekeeperKey=6ba4de64d6ca99aa4db3b9194e37adbf';
            HttpRequest req = new HttpRequest();
            System.debug('## - '+url);
            req.setEndPoint(url);
            req.setMethod('GET');
            
            
            Http http = new Http();
            HttpResponse resp = http.send(req);
            String addressAPIResponse =  resp.getBody();
            
            System.debug('addressAPIResponse - '+ addressAPIResponse );
            
            if(resp.getStatusCode() == 200)
            {
                try{
                    JSON2Apex addressNodes = new JSON2Apex(System.JSON.createParser(addressAPIResponse ));
                    if(addressNodes != null)
                    {
                        Community_Case__c commCase = new Community_Case__c();
                        
                        if(addressNodes.features[0].properties.center_city_district != null)
                            commCase.Center_City_District__c = addressNodes.features[0].properties.center_city_district;
                        
                        if(addressNodes.features[0].properties.zip_code != null)
                            commCase.Zip_Code__c = addressNodes.features[0].properties.zip_code ;
                        
                        
                        //1    
                        if(addressNodes.features[0].properties.council_district_2016 != null)
                            commCase.Council_District_No__c = addressNodes.features[0].properties.council_district_2016;
                        
                        //2
                        if(addressNodes.features[0].properties.police_district != null)
                            commCase.Police_District__c = addressNodes.features[0].properties.police_district;
                        
                        //3
                        if(addressNodes.features[0].properties.rubbish_recycle_day != null)
                            commCase.Pickup_Day__c = addressNodes.features[0].properties.rubbish_recycle_day;
                        
                        
                        //4
                        if(addressNodes.features[0].properties.sanitation_district != null)
                            commCase.Sanitation_District__c = addressNodes.features[0].properties.sanitation_district;
                        
                        //5
                        if(addressNodes.features[0].properties.philly_rising_area != null)
                            commCase.PhillyRising__c = addressNodes.features[0].properties.philly_rising_area;
                        
                        //6
                        if(addressNodes.features[0].properties.ladder_local != null)
                            commCase.Ladder_Local__c = addressNodes.features[0].properties.ladder_local;        
                        
                        //7
                        if(addressNodes.features[0].properties.engine_local != null)
                            commCase.Engine_Local__c = addressNodes.features[0].properties.engine_local;  
                        
                        if(addressNodes.features[0].geometry.coordinates != null)
                        {
                            commCase.lat__c = addressNodes.features[0].geometry.coordinates[1]+'';  
                            commCase.long__c = addressNodes.features[0].geometry.coordinates[0]+'';  
                        }
                        
                        
                        if(addressNodes.features[0].properties != null)
                        {
                            commCase.normalized__c = addressNodes.features[0].properties.street_address;
                            commCase.zoning__c = addressNodes.features[0].properties.zoning;
                            commCase.Unit_Number__c = addressNodes.features[0].properties.unit_type +' '  + addressNodes.features[0].properties.unit_num;
                        }
                        
                        
                        
                        commCase.Street_Address__c = enteredAddress;
                        
                        if(commCase != null)
                        {
                            insert commCase;
                            
                            if(commCase.id != null)
                            {
                                return commCase.id;
                            }   
                        }
                    }
                }
                
                
                catch(Exception ee){
                    return 'Invalid Address';
                }
                
                if(resp.getBody().contains('Could not find any addresses matching query'))
                {
                    return 'Invalid Address';    
                }
                
            }
            
        }
        
        return 'Invalid Address';
        
    }
    
    
    
    
    @AuraEnabled
    public static List<String> validateAddressNew(String enteredAddress)
    {
        List<String> errList = new List<String>();
        String ipstring= UserInfo.getSessionId() ;
        System.debug('Ip address - '+ ipstring);
        if(enteredAddress != null)
        {
            String encodedEnteredAddress = EncodingUtil.URLENCODE(enteredAddress,'UTF-8').replace('+', '%20');
            
            String url = 'http://api.phila.gov/ais_doc/v1/search/';
            //String url = 'http://api.phila.gov/ais_doc/v1/addresses/';
            url += encodedEnteredAddress ;
            //  url += '?gatekeeperKey=6ba4de64d6ca99aa4db3b9194e37adbf';
            url += '?include_units&gatekeeperKey=6ba4de64d6ca99aa4db3b9194e37adbf';
            HttpRequest req = new HttpRequest();
            System.debug('## - '+url);
            req.setEndPoint(url);
            req.setMethod('GET');
            
            
            Http http = new Http();
            HttpResponse resp = http.send(req);
            String addressAPIResponse =  resp.getBody();
            
            System.debug('addressAPIResponse - '+ addressAPIResponse );
            List<String> strList = new List<String>();
            List<String> strListtosend = new List<String>();
            strList = addressAPIResponse.split('street_address');
            strList.remove(0);
            for(String str : strList)
            {
                if(!str.contains('#'))
                {
                    String street = str.substringBetween('\": \"', '\",');
                    strListtosend.add(street);
                    String city	 = str.substringBetween('\"center_city_district\": \"', '\",');
                    System.debug('--'+street+'-----------'+city);
                }
            }
            if(strListtosend.size()>0)
            {
                return strListtosend;
            }
            
            if(resp.getBody().contains('Could not find any addresses matching query'))
            {
                String err = 'Invalid Address'; 
                errList.add(err);
                return errList;    
            }
        }
        
        String err = 'Invalid Address'; 
        errList.add(err);
        return errList; 
        
    }
}