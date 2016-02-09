$(document).ready(function() {
  
  function createSidebarLi(json){
    return json.sidebar;
  };
  // this is causing the sidebar <li> to zoom the map into a funny place and stay there upon hitting the back button. I've removed the zoom, setMap, and panTo functions for now to fix it. to do: come back and make this work correctly
  function bindLiToMarker($li, marker){
    $li.on('click', function(){
      // handler.getMap().setZoom(14);
      // marker.setMap(handler.getMap()); //because clusterer removes map property from marker
      // marker.panTo();
      google.maps.event.trigger(marker.getServiceObject(), 'click');
    })
  };

  function createSidebar(json_array){
    console.log("it made a sidebar!")
    _.each(json_array, function(json){
      var $li = $( createSidebarLi(json) );
      $li.appendTo('#sidebar_container');
      bindLiToMarker($li, json.marker);
    });
  };

  handler = Gmaps.build('Google', { markers: { maxRandomDistance: null } });

  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    var facilities_list = $('#facilities_list').val();
    var json_array = [JSON.parse(facilities_list)];

    console.log(facilities_list);
    console.log(json_array)
    // addMarkers won't accept my json_array properly... why not?
    markers = handler.addMarkers(JSON.parse(facilities_list));
    
    _.each(json_array, function(json, index){
      json.marker = markers[index];
    });

    createSidebar(JSON.parse(facilities_list));
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });
});
