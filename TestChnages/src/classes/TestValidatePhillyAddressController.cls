@isTest
public class TestValidatePhillyAddressController {
    
    public class Mock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setBody('{"search_type": "address", "search_params": {}, "query": "1234 market st", "normalized": "1234 MARKET ST", "crs": {"type": "link", "properties": {"type": "proj4", "href": "http://spatialreference.org/ref/epsg/4326/proj4/"}}, "page": 1, "page_count": 1, "page_size": 1, "total_size": 1, "type": "FeatureCollection", "features": [{"type": "Feature", "ais_feature_type": "address", "match_type": "exact", "properties": {"street_address": "1234 MARKET ST", "address_low": 1234, "address_low_suffix": "", "address_low_frac": "", "address_high": null, "street_predir": "", "street_name": "MARKET", "street_suffix": "ST", "street_postdir": "", "unit_type": "", "unit_num": "", "street_full": "MARKET ST", "street_code": 53560, "seg_id": 440394, "zip_code": "19107", "zip_4": "3721", "usps_bldgfirm": "MARKET STREET BLDG", "usps_type": "H", "election_block_id": "24021362", "election_precinct": "0528", "pwd_parcel_id": "542611", "dor_parcel_id": "001S070144", "li_address_key": "410516", "eclipse_location_id": "15495782", "bin": "1496963|1496964|1530931", "zoning_document_ids": ["219-235748", "219-235753", "27-137335", "27-198741"], "pwd_account_nums": ["5356001234001", "5356001234004", "5356001234002", "5356001234003", "5356001234005"], "opa_account_num": "883309050", "opa_owners": ["SEPTA"], "opa_address": "1234 MARKET ST", "center_city_district": "In", "cua_zone": "Bethanna", "li_district": "Central", "philly_rising_area": "Market East", "census_tract_2010": "000500", "census_block_group_2010": "1", "census_block_2010": "1017", "council_district_2016": "1", "political_ward": "5", "political_division": "0528", "state_house_rep_2012": "182", "state_senate_2012": "1", "us_congressional_2012": "1", "planning_district": "Central", "elementary_school": "McCall", "middle_school": "McCall", "high_school": "Franklin HS", "zoning": "CMX-5", "zoning_rco": "15367|15639", "commercial_corridor": "Market East", "historic_district": "", "historic_site": "No", "police_division": "CPD", "police_district": "6", "police_service_area": "063", "rubbish_recycle_day": "WED", "recycling_diversion_rate": 0.229, "leaf_collection_area": "Saturday Bag Dropoff", "sanitation_area": "2", "sanitation_district": "2B", "sanitation_convenience_center": "Strawberry Mansion", "clean_philly_block_captain": "No", "historic_street": "", "highway_district": "3", "highway_section": "3N", "highway_subsection": "3N1", "traffic_district": "1", "traffic_pm_district": "1206", "street_light_route": "13", "lane_closure": "2018-00177", "pwd_maint_district": "3E", "pwd_pressure_district": "EPG", "pwd_treatment_plant": "EAST PARK", "pwd_water_plate": "28A", "pwd_center_city_district": "In", "major_phila_watershed": "Delaware Direct Watershed", "neighborhood_advisory_committee": "", "ppr_friends": "Friends of Louis I Kahn Park", "engine_local": "20", "ladder_local": "23"}, "geometry": {"geocode_type": "pwd_parcel", "type": "Point", "coordinates": [-75.16097658476633, 39.95166165567195]}}]}');
            res.setStatus('OK');
            res.setStatusCode(200);
            return res;
        }
    }
    
    
    static testMethod void validateAddress(){
        
        Test.setMock(HttpCalloutMock.class, new Mock());
        String result = validatePhillyAddressController.validateAddress('1234 Market street');
        Test.setMock(HttpCalloutMock.class, new Mock());
        
    }
    
     static testMethod void validateAddressNew(){
        
        Test.setMock(HttpCalloutMock.class, new Mock());
        List<String> resList = validatePhillyAddressController.validateAddressNew('1234 Market street');
        Test.setMock(HttpCalloutMock.class, new Mock());
        
    }
    
}