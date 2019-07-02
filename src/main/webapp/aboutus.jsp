<!--
Copyright 2019 Google Inc.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>About Us</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/ui-builder.js"></script>

    <script>
	    
      /** Fetches data and populates the UI of the page. */
      function addLoginOrLogoutLinkToNavigation(){
            const navigationElement = document.getElementById('navigation');
            fetch('/login-status')
                .then((loginStatus) => {
                  if (loginStatus.isLoggedIn) {
                    navigationElement.appendChild(createListItem(createLink(
                        '/user-page.html?user=' + loginStatus.username, 'Your Page')));

                    navigationElement.appendChild(
                        createListItem(createLink('/logout', 'Logout')));
                  } else {
                    navigationElement.appendChild(
                        createListItem(createLink('/login', 'Your Page')));
                    navigationElement.appendChild(
                        createListItem(createLink('/logout', 'Logout')));
                  }
                });
      }
    </script>
	 </script>
  <title>Team 1's Location</title>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTkxwf49JuT_CpGMbV4OHYMTQjp8BT0nE"></script>
  <script>
    let map;	  
    /* Editable marker that displays when a user clicks in the map. */
    let editMarker;	  
    function createMap(){
      map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 38.5949, lng: -94.8923},
        zoom: 4
      });
      // When the user clicks in the map, show a marker with a text box the user can edit.
      map.addListener('click', (event) => {
        createMarkerForEdit(event.latLng.lat(), event.latLng.lng());
      });
      fetchMarkers();
	  addLandmark(map, 40.807048, -73.961038, 'Eleanor', 'Eleanor is currently in NYC') 
      addLandmark(map, 33.063655, -96.771746, 'Antara', 'Antara is currently in Dallas') 
      addLandmark(map, 42.026411, -93.643472, 'Kamsi', 'Kamsi is in Iowa');
	  addLandmark(map, 37.422200, -122.083682, 'Kevin', 'Kevin is working in Mountain View')
    }
	  
    /** Fetches markers from the backend and adds them to the map. */
    function fetchMarkers(){
      fetch('/markers').then((response) => {
        return response.json();
      }).then((markers) => {
        markers.forEach((marker) => {
         createMarkerForDisplay(marker.lat, marker.lng, marker.content)
        });
      });
    }
    
    /** Adds a marker that shows an info window when clicked. */ 
    function addLandmark(map, lat, lng, title, description){ 
      const marker = new google.maps.Marker({ 
        position: {lat: lat, lng: lng}, 
        map: map, 
        title: title 
      }); 
      const infoWindow = new google.maps.InfoWindow({ 
        content: description 
      }); 
      marker.addListener('click', function() { 
        infoWindow.open(map, marker); 
      }); 
    }
	  
    /** Creates a marker that shows a read-only info window when clicked. */
    function createMarkerForDisplay(lat, lng, content){
      const marker = new google.maps.Marker({
        position: {lat: lat, lng: lng},
        map: map
      });
      var infoWindow = new google.maps.InfoWindow({
        content: content
      });
      marker.addListener('click', () => {
        infoWindow.open(map, marker);
      });
    }
	  
    /** Sends a marker to the backend for saving. */
    function postMarker(lat, lng, content){
      const params = new URLSearchParams();
      params.append('lat', lat);
      params.append('lng', lng);
      params.append('content', content);
      fetch('/markers', {
        method: 'POST',
        body: params
      });
    }
	  
    /** Creates a marker that shows a textbox the user can edit. */
    function createMarkerForEdit(lat, lng){
      // If we're already showing an editable marker, then remove it.
      if(editMarker){
       editMarker.setMap(null);
      }
      editMarker = new google.maps.Marker({
        position: {lat: lat, lng: lng},
        map: map
      });
      const infoWindow = new google.maps.InfoWindow({
        content: buildInfoWindowInput(lat, lng)
      });
      // When the user closes the editable info window, remove the marker.
      google.maps.event.addListener(infoWindow, 'closeclick', () => {
        editMarker.setMap(null);
      });
      infoWindow.open(map, editMarker);
    }
	  
    /** Builds and returns HTML elements that show an editable textbox and a submit button. */
    function buildInfoWindowInput(lat, lng){
      const textBox = document.createElement('textarea');
      const button = document.createElement('button');
      button.appendChild(document.createTextNode('Submit'));
      button.onclick = () => {
        postMarker(lat, lng, textBox.value);
        createMarkerForDisplay(lat, lng, textBox.value);
        editMarker.setMap(null);
      };
      const containerDiv = document.createElement('div');
      containerDiv.appendChild(textBox);
      containerDiv.appendChild(document.createElement('br'));
      containerDiv.appendChild(button);
      return containerDiv;
    }
  </script>
  <style>
    #map{
      width: 500px;
      height: 500px;
    }
  </style>
  </head>
  <body onload="createMap();">
  <h1>Team 1 Map</h1>
  <div id="map"></div>
  <p>Find out where Team 1 is, or click on the map and enter your location to save your hometown!</p>
    <%@include file="/WEB-INF/navigation.jsp" %>
    <h1>About Our Team</h1>
    <h2>Eleanor</h2>
    <ul>
      <li>Summer Feelz: Sunny, Work, Eternity</li>
      <li>Aspirational Hobby: Filmmaking</li>
      <li>Ask me About: Investments in Stocks</li>
    </ul>
    <h2>Antara</h2>
    <ul>
      <li>Summer Feelz: napping til noon </li>
      <li>Aspirational Hobby: cooking, reading, and traveling. </li>
      <li>Ask me About: Dallas sports teams and being a RA! </li>
    </ul>
    <h2>kamsi</h2>
    <ul>
      <li>Summer Feelz: sleeping, soccer, skating</li>
      <li>Aspirational Hobby: Tennis</li>
      <li>Ask me About: anime, music, videogames, sports</li>
    </ul>
    <h2>Kevin</h2>
    <ul>
      <li>Summer Feelz: porch hammock coding</li>
      <li>Aspirational Hobby: professional cat photography</li>
      <li>Ask me About: creative coding, especially Processing and P5.js!</li>
    </ul>
  </body>
</html>
