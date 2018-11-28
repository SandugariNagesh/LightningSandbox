GIS.map = (function () {
  var map,
      spiderfier,
      geocodeMarker,
      relatedMarkers,
      POPUP_OPTIONS = {
        minWidth: 130,
      };

  return {
    init: function () {
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

      // DEBUG
      // map.on('zoomend', function (e) {
      //   console.log('zoomend', e.target.getZoom());
      // });

      // add gsg city basemap with labels
      // REVIEW add labels separately?
      L.esri.tiledMapLayer({
        url: '//tiles.arcgis.com/tiles/fLeGjb7u4uXqeF9q/arcgis/rest/services/CityBasemap_Slash/MapServer',
        maxZoom: 22,
      }).addTo(map);

      // create spiderfier (this is an object that expands, aka "spiderfies"
      // overlapping map markers when clicked on)
      spiderfier = new OverlappingMarkerSpiderfier(map);

      spiderfier.addListener('click', function (marker) {
        var popup = marker.popup;
        popup.setLatLng(marker.getLatLng());
        map.openPopup(popup);
      });

      // listen for relate clicks
      $(document).on('click', '.relate-link', GIS.map.handleRelateClick);
    },

    zoomTo: function (x, y, level) {
      level = level || 18;
      map.setView([y, x], level);
    },

    colorMarker: function (lat, lng, color) {
      var AVAILABLE_COLORS = [
        'blue',
        'red',
        'green',
        'orange',
        'yellow',
        'violet',
        'grey',
        'black',
      ];

      // lower case, just in case
      color = color.toLowerCase();

      if (!AVAILABLE_COLORS.includes(color)) {
        throw 'Leaflet marker not available for color: ' + color;
      }

      var iconUrl = '//cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-' + color + '.png',
          icon = new L.Icon({
          iconUrl: iconUrl,
          shadowUrl: '//cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41],
          }),
          marker = new L.marker([lat, lng], {icon: icon});

      // console.log('marker', marker);

      return marker;
    },

    removeMarkers: function () {
      if (geocodeMarker) {
        map.removeLayer(geocodeMarker);
      }

      _.forEach(relatedMarkers, function (relatedMarker) {
        map.removeLayer(relatedMarker);
      });

      geocodeMarker = null;
      relatedMarkers = [];
    },

    addGeocodeMarker: function (x, y, address) {
      // console.log('add geocode marker', x, y);

      GIS.map.removeMarkers();

      geocodeMarker = this.colorMarker(y, x, 'yellow');

      var popupContent = '\
            <div>\
          <strong>' + address + '</strong>' + '\
        </div>\
        <div>\
          <a href="http://cityatlas.phila.gov/#/' + address + '/" target="_blank">\
            Internal Map For SF Users <span class="fa fa-external-link"></span>\
          </a>\
        </div>\
		<div>\
          <a href="https://atlas.phila.gov/#/' + address + '/" target="_blank">\
            External Map For Partners Users <span class="fa fa-external-link"></span>\
          </a>\
        </div>\
          ',
          popup = new L.Popup(POPUP_OPTIONS).setContent(popupContent);

      geocodeMarker.popup = popup;
      geocodeMarker.addTo(map);
      spiderfier.addMarker(geocodeMarker);
    },

    addRelatedMarkers: function (relateds) {
      // console.log('add related markers', relateds);

      _.forEach(relateds, function (related) {
		var serviceType = related.Service_Request_Type__c;	
        var lat = related.Centerline__Latitude__s,
            lng = related.Centerline__Longitude__s,
            marker = GIS.map.colorMarker(lat, lng, 'blue'),
            // description = related.description,
            // popup = description + '<br><a href="#" class="related-link">Relate</a>';
            caseId = related.Id,
            caseNumber = related.CaseNumber,
            caseType = related.Subject,
            address = related.Street__c,
            popupContent = '\
              <div>' +
                '<strong>' + address + ' : ' + caseType + ' - ' + serviceType + '</strong>\
              </div>\
              <div>\
                 Case #<a target="_blank" href="//philly311.my.salesforce.com/' + caseId + '" target="_blank">' + caseNumber + '</a>' +
              '</div>\
              <div>\
                <a class="relate-link"\
                   href="#"\
                   data-case-id="' + caseId + '" \
                   data-case-number="' + caseNumber + '"\
                 >\
                  Relate\
                </a>\
              </div>\
            ';

        marker.popup = new L.Popup(POPUP_OPTIONS)
                              .setContent(popupContent);

        marker.addTo(map);
        spiderfier.addMarker(marker);
        relatedMarkers.push(marker);
      });
    },

    handleRelateClick: function (e) {
      // console.log('handle relate click', e);

      // get ids
      var $link = $(this),
          caseId = $link.attr('data-case-id'),
          caseNumber = $link.attr('data-case-number'),
          caseObj = {
            id: caseId,
            num: caseNumber
          };

      // to "relate" one case to another, we set the parent id to the related's
      // case id.
      GIS.saveGeodata(caseObj);

      alert('This case has been related to case #' + caseNumber + '.');
    },
  };
})();

// call initMap on dom ready
$(GIS.map.init);
