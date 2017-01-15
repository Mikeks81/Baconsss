$(document).on('turbolinks:load', function() {
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
                var pos = {
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

    initMap();
});
