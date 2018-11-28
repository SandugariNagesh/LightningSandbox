public class JSON2Apex {

    public class Geometry {
        public String geocode_type {get;set;} 
        public String type_Z {get;set;} // in json: type
        public List<Double> coordinates {get;set;} 

        public Geometry(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'geocode_type') {
                            geocode_type = parser.getText();
                        } else if (text == 'type') {
                            type_Z = parser.getText();
                        } else if (text == 'coordinates') {
                            coordinates = arrayOfDouble(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Geometry consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public String search_type {get;set;} 
    public Search_params search_params {get;set;} 
    public String query {get;set;} 
    public String normalized {get;set;} 
    public Crs crs {get;set;} 
    public Integer page {get;set;} 
    public Integer page_count {get;set;} 
    public Integer page_size {get;set;} 
    public Integer total_size {get;set;} 
    public String type_Z {get;set;} // in json: type
    public List<Features> features {get;set;} 

    public JSON2Apex(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'search_type') {
                        search_type = parser.getText();
                    } else if (text == 'search_params') {
                        search_params = new Search_params(parser);
                    } else if (text == 'query') {
                        query = parser.getText();
                    } else if (text == 'normalized') {
                        normalized = parser.getText();
                    } else if (text == 'crs') {
                        crs = new Crs(parser);
                    } else if (text == 'page') {
                        page = parser.getIntegerValue();
                    } else if (text == 'page_count') {
                        page_count = parser.getIntegerValue();
                    } else if (text == 'page_size') {
                        page_size = parser.getIntegerValue();
                    } else if (text == 'total_size') {
                        total_size = parser.getIntegerValue();
                    } else if (text == 'type') {
                        type_Z = parser.getText();
                    } else if (text == 'features') {
                        features = arrayOfFeatures(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    public class Search_params {

        public Search_params(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        {
                            System.debug(LoggingLevel.WARN, 'Search_params consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Properties_Z {
        public String street_address {get;set;} 
        public Integer address_low {get;set;} 
        public String address_low_suffix {get;set;} 
        public String address_low_frac {get;set;} 
        public Object address_high {get;set;} 
        public String street_predir {get;set;} 
        public String street_name {get;set;} 
        public String street_suffix {get;set;} 
        public String street_postdir {get;set;} 
        public String unit_type {get;set;} 
        public String unit_num {get;set;} 
        public String street_full {get;set;} 
        public Integer street_code {get;set;} 
        public Integer seg_id {get;set;} 
        public String zip_code {get;set;} 
        public String zip_4 {get;set;} 
        public String usps_bldgfirm {get;set;} 
        public String usps_type {get;set;} 
        public String election_block_id {get;set;} 
        public String election_precinct {get;set;} 
        public String pwd_parcel_id {get;set;} 
        public String dor_parcel_id {get;set;} 
        public String li_address_key {get;set;} 
        public String eclipse_location_id {get;set;} 
        public String bin {get;set;} 
        public List<String> zoning_document_ids {get;set;} 
        public List<String> pwd_account_nums {get;set;} 
        public String opa_account_num {get;set;} 
        public List<String> opa_owners {get;set;} 
        public String opa_address {get;set;} 
        public String center_city_district {get;set;} 
        public String cua_zone {get;set;} 
        public String li_district {get;set;} 
        public String philly_rising_area {get;set;} 
        public String census_tract_2010 {get;set;} 
        public String census_block_group_2010 {get;set;} 
        public String census_block_2010 {get;set;} 
        public String council_district_2016 {get;set;} 
        public String political_ward {get;set;} 
        public String political_division {get;set;} 
        public String state_house_rep_2012 {get;set;} 
        public String state_senate_2012 {get;set;} 
        public String us_congressional_2012 {get;set;} 
        public String planning_district {get;set;} 
        public String elementary_school {get;set;} 
        public String middle_school {get;set;} 
        public String high_school {get;set;} 
        public String zoning {get;set;} 
        public String zoning_rco {get;set;} 
        public String commercial_corridor {get;set;} 
        public String historic_district {get;set;} 
        public String historic_site {get;set;} 
        public String police_division {get;set;} 
        public String police_district {get;set;} 
        public String police_service_area {get;set;} 
        public String rubbish_recycle_day {get;set;} 
        public Double recycling_diversion_rate {get;set;} 
        public String leaf_collection_area {get;set;} 
        public String sanitation_area {get;set;} 
        public String sanitation_district {get;set;} 
        public String sanitation_convenience_center {get;set;} 
        public String clean_philly_block_captain {get;set;} 
        public String historic_street {get;set;} 
        public String highway_district {get;set;} 
        public String highway_section {get;set;} 
        public String highway_subsection {get;set;} 
        public String traffic_district {get;set;} 
        public String traffic_pm_district {get;set;} 
        public String street_light_route {get;set;} 
        public String lane_closure {get;set;} 
        public String pwd_maint_district {get;set;} 
        public String pwd_pressure_district {get;set;} 
        public String pwd_treatment_plant {get;set;} 
        public String pwd_water_plate {get;set;} 
        public String pwd_center_city_district {get;set;} 
        public String major_phila_watershed {get;set;} 
        public String neighborhood_advisory_committee {get;set;} 
        public String ppr_friends {get;set;} 
        public String engine_local {get;set;} 
        public String ladder_local {get;set;} 

        public Properties_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'street_address') {
                            street_address = parser.getText();
                        } else if (text == 'address_low') {
                            address_low = parser.getIntegerValue();
                        } else if (text == 'address_low_suffix') {
                            address_low_suffix = parser.getText();
                        } else if (text == 'address_low_frac') {
                            address_low_frac = parser.getText();
                        } else if (text == 'address_high') {
                            address_high = parser.readValueAs(Object.class);
                        } else if (text == 'street_predir') {
                            street_predir = parser.getText();
                        } else if (text == 'street_name') {
                            street_name = parser.getText();
                        } else if (text == 'street_suffix') {
                            street_suffix = parser.getText();
                        } else if (text == 'street_postdir') {
                            street_postdir = parser.getText();
                        } else if (text == 'unit_type') {
                            unit_type = parser.getText();
                        } else if (text == 'unit_num') {
                            unit_num = parser.getText();
                        } else if (text == 'street_full') {
                            street_full = parser.getText();
                        } else if (text == 'street_code') {
                            street_code = parser.getIntegerValue();
                        } else if (text == 'seg_id') {
                            seg_id = parser.getIntegerValue();
                        } else if (text == 'zip_code') {
                            zip_code = parser.getText();
                        } else if (text == 'zip_4') {
                            zip_4 = parser.getText();
                        } else if (text == 'usps_bldgfirm') {
                            usps_bldgfirm = parser.getText();
                        } else if (text == 'usps_type') {
                            usps_type = parser.getText();
                        } else if (text == 'election_block_id') {
                            election_block_id = parser.getText();
                        } else if (text == 'election_precinct') {
                            election_precinct = parser.getText();
                        } else if (text == 'pwd_parcel_id') {
                            pwd_parcel_id = parser.getText();
                        } else if (text == 'dor_parcel_id') {
                            dor_parcel_id = parser.getText();
                        } else if (text == 'li_address_key') {
                            li_address_key = parser.getText();
                        } else if (text == 'eclipse_location_id') {
                            eclipse_location_id = parser.getText();
                        } else if (text == 'bin') {
                            bin = parser.getText();
                        } else if (text == 'zoning_document_ids') {
                            zoning_document_ids = arrayOfString(parser);
                        } else if (text == 'pwd_account_nums') {
                            pwd_account_nums = arrayOfString(parser);
                        } else if (text == 'opa_account_num') {
                            opa_account_num = parser.getText();
                        } else if (text == 'opa_owners') {
                            opa_owners = arrayOfString(parser);
                        } else if (text == 'opa_address') {
                            opa_address = parser.getText();
                        } else if (text == 'center_city_district') {
                            center_city_district = parser.getText();
                        } else if (text == 'cua_zone') {
                            cua_zone = parser.getText();
                        } else if (text == 'li_district') {
                            li_district = parser.getText();
                        } else if (text == 'philly_rising_area') {
                            philly_rising_area = parser.getText();
                        } else if (text == 'census_tract_2010') {
                            census_tract_2010 = parser.getText();
                        } else if (text == 'census_block_group_2010') {
                            census_block_group_2010 = parser.getText();
                        } else if (text == 'census_block_2010') {
                            census_block_2010 = parser.getText();
                        } else if (text == 'council_district_2016') {
                            council_district_2016 = parser.getText();
                        } else if (text == 'political_ward') {
                            political_ward = parser.getText();
                        } else if (text == 'political_division') {
                            political_division = parser.getText();
                        } else if (text == 'state_house_rep_2012') {
                            state_house_rep_2012 = parser.getText();
                        } else if (text == 'state_senate_2012') {
                            state_senate_2012 = parser.getText();
                        } else if (text == 'us_congressional_2012') {
                            us_congressional_2012 = parser.getText();
                        } else if (text == 'planning_district') {
                            planning_district = parser.getText();
                        } else if (text == 'elementary_school') {
                            elementary_school = parser.getText();
                        } else if (text == 'middle_school') {
                            middle_school = parser.getText();
                        } else if (text == 'high_school') {
                            high_school = parser.getText();
                        } else if (text == 'zoning') {
                            zoning = parser.getText();
                        } else if (text == 'zoning_rco') {
                            zoning_rco = parser.getText();
                        } else if (text == 'commercial_corridor') {
                            commercial_corridor = parser.getText();
                        } else if (text == 'historic_district') {
                            historic_district = parser.getText();
                        } else if (text == 'historic_site') {
                            historic_site = parser.getText();
                        } else if (text == 'police_division') {
                            police_division = parser.getText();
                        } else if (text == 'police_district') {
                            police_district = parser.getText();
                        } else if (text == 'police_service_area') {
                            police_service_area = parser.getText();
                        } else if (text == 'rubbish_recycle_day') {
                            rubbish_recycle_day = parser.getText();
                        } else if (text == 'recycling_diversion_rate') {
                            recycling_diversion_rate = parser.getDoubleValue();
                        } else if (text == 'leaf_collection_area') {
                            leaf_collection_area = parser.getText();
                        } else if (text == 'sanitation_area') {
                            sanitation_area = parser.getText();
                        } else if (text == 'sanitation_district') {
                            sanitation_district = parser.getText();
                        } else if (text == 'sanitation_convenience_center') {
                            sanitation_convenience_center = parser.getText();
                        } else if (text == 'clean_philly_block_captain') {
                            clean_philly_block_captain = parser.getText();
                        } else if (text == 'historic_street') {
                            historic_street = parser.getText();
                        } else if (text == 'highway_district') {
                            highway_district = parser.getText();
                        } else if (text == 'highway_section') {
                            highway_section = parser.getText();
                        } else if (text == 'highway_subsection') {
                            highway_subsection = parser.getText();
                        } else if (text == 'traffic_district') {
                            traffic_district = parser.getText();
                        } else if (text == 'traffic_pm_district') {
                            traffic_pm_district = parser.getText();
                        } else if (text == 'street_light_route') {
                            street_light_route = parser.getText();
                        } else if (text == 'lane_closure') {
                            lane_closure = parser.getText();
                        } else if (text == 'pwd_maint_district') {
                            pwd_maint_district = parser.getText();
                        } else if (text == 'pwd_pressure_district') {
                            pwd_pressure_district = parser.getText();
                        } else if (text == 'pwd_treatment_plant') {
                            pwd_treatment_plant = parser.getText();
                        } else if (text == 'pwd_water_plate') {
                            pwd_water_plate = parser.getText();
                        } else if (text == 'pwd_center_city_district') {
                            pwd_center_city_district = parser.getText();
                        } else if (text == 'major_phila_watershed') {
                            major_phila_watershed = parser.getText();
                        } else if (text == 'neighborhood_advisory_committee') {
                            neighborhood_advisory_committee = parser.getText();
                        } else if (text == 'ppr_friends') {
                            ppr_friends = parser.getText();
                        } else if (text == 'engine_local') {
                            engine_local = parser.getText();
                        } else if (text == 'ladder_local') {
                            ladder_local = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Properties_Z consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Crs {
        public String type_Z {get;set;} // in json: type
        public Properties properties {get;set;} 

        public Crs(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type_Z = parser.getText();
                        } else if (text == 'properties') {
                            properties = new Properties(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Crs consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Features {
        public String type_Z {get;set;} // in json: type
        public String ais_feature_type {get;set;} 
        public String match_type {get;set;} 
        public Properties_Z properties {get;set;} 
        public Geometry geometry {get;set;} 

        public Features(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'type') {
                            type_Z = parser.getText();
                        } else if (text == 'ais_feature_type') {
                            ais_feature_type = parser.getText();
                        } else if (text == 'match_type') {
                            match_type = parser.getText();
                        } else if (text == 'properties') {
                            properties = new Properties_Z(parser);
                        } else if (text == 'geometry') {
                            geometry = new Geometry(parser);
                        } else {
                            System.debug(LoggingLevel.WARN, 'Features consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public class Properties {
        public String href {get;set;} 
        public String type_Z {get;set;} // in json: type

        public Properties(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'href') {
                            href = parser.getText();
                        } else if (text == 'type') {
                            type_Z = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Properties consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    
    public static JSON2Apex parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new JSON2Apex(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    

    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }






    private static List<Double> arrayOfDouble(System.JSONParser p) {
        List<Double> res = new List<Double>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getDoubleValue());
        }
        return res;
    }








    private static List<Features> arrayOfFeatures(System.JSONParser p) {
        List<Features> res = new List<Features>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Features(p));
        }
        return res;
    }


}