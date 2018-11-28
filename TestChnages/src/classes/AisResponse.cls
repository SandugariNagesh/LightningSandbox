public with sharing class AisResponse {
  public AisFeature[] features;

  public AisResponse(string jsonString) {
    // parse json
    // make features
  }

  /*
    HELPER CLASSES
    for building up an ais response
    REVIEW should these be public? private?
  */

  // the geometry object (a superset of geojson)
  public class AisGeometry {
    public string geocodeType;
    public string type;
    public list<Decimal> coordinates;
  }

  // address properties/attributes. includes service areas.
  // note: there are more props available in the api -- these are just the ones
  // that appear to be used in salesforce.
  public class AisProperties {
    public string streetAddress;
    public string liAddressKey;

    // service areas
    public string rubbishRecycleDay;
    public string centerCityDistict;
    public string councilDistrict2016;
    public string zipCode;
    public string policeDistrict;
  }

  // an individual address
  public class AisFeature {
    public string matchType;
    public AisProperties properties;
    public AisGeometry geometry;
  }


}