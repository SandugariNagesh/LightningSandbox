({
	myAction : function(component, event, helper) {
		
	},
    
    jsLoaded: function(component, event, helper) {
    /*  var map = L.map('map', {zoomControl: false, tap: false})
                  .setView([37.784173, -122.401557], 14);
      L.tileLayer(
       'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
       {
              attribution: 'Tiles © Esri'
       }).addTo(map);
      component.set("v.map", map); */
         var MAP_OPTIONS = {
            // center over city hall
            center: [39.952388, -75.1658127],
            minZoom: 11,
            zoom: 15,
          };

      // create map
      map = L.map('map', MAP_OPTIONS);

      // move zoom control to bottom-right, a la google
      map.zoomControl.setPosition('bottomright');

      map.attributionControl.addAttribution('City of Philadelphia | CityGeo');

      L.tileLayer({
        url: '//tiles.arcgis.com/tiles/fLeGjb7u4uXqeF9q/arcgis/rest/services/CityBasemap_Slash/MapServer',
        maxZoom: 22,
      }).addTo(map);

   /*   // create spiderfier (this is an object that expands, aka "spiderfies"
      // overlapping map markers when clicked on)
      spiderfier = new OverlappingMarkerSpiderfier(map);

      spiderfier.addListener('click', function (marker) {
        var popup = marker.popup;
        popup.setLatLng(marker.getLatLng());
        map.openPopup(popup);
      });

      // listen for relate clicks
      $(document).on('click', '.relate-link', GIS.map.handleRelateClick);*/
        component.set("v.map", map); 
  }
    
    

})