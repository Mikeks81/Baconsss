$(document).on('turbolinks:load', function() {
    var activeToggle = $('#user-name-title a');
    activeToggle.text("Finding your location..."),
    pos = "";

    function initMap() {

        // start location is Kensington...
        var startLocation = {
            lat: 39.9809171,
            lng: -75.1316623
        };
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: startLocation
        });
        // var marker = new google.maps.Marker({
        //     position: startLocation,
        //     map: map
        // });
        // var infoWindow = new google.maps.InfoWindow({map: map});
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                 pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                // infoWindow.setPosition(pos);
                // infoWindow.setContent('Location found.');

                map.setCenter(pos);
                map.setZoom(15);
                var marker = new google.maps.Marker({
                    position: pos,
                    map: map
                });
                activeToggle.text("Activate Notifications");
            }, function() {
                // handleLocationError(true, infoWindow, map.getCenter());
                console.error("There was a problem obtaining location through geolocation service");
            });
        } else {
            console.log("Browser doesn't support Geolocation.");
            // Browser doesn't support Geolocation
            // handleLocationError(false, infoWindow, map.getCenter());
        }
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
    }

    // write function that gets the user ID from somewhere and fires an ajax call to created a row in the Location Table for that user with the lat and long from var pos.
    $('#toggle_notifications').on('click', function(e){
      var userId = $(this).attr('data-user');
      var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
      $.ajax({
        url: "/users/" + userId + "/locations",
        type: 'post',
        data: {authenticity_token: AUTH_TOKEN, location: {latitude: pos.lat,
                           longitude: pos.lng}},
        success: function(){
          console.log("success");
        },
        error: function(){
          console.log("fail");
        }
      });
    });


    initMap();
});
