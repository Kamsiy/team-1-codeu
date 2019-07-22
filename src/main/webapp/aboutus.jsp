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
<html class="about-bg">
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
                        '/user-page.html?user=' + loginStatus.username, 'Shopper Page')));

                    navigationElement.appendChild(
                        createListItem(createLink('/logout', 'Logout')));
                  } else {
                    navigationElement.appendChild(
                        createListItem(createLink('/login', 'Shopper Page')));
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
      addLoginOrLogoutLinkToNavigation();
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
    <%@include file="/WEB-INF/navigation.jsp" %>
    <div class="about-style">
      <h1>Our Team</h1>
      <h2>Eleanor</h2>
      <ul>
        <p>
          Hey, I&apos;m Eleanor. I&apos;m responsible for the design of the website (HTML/CSS) and the shopping content filter, which used datastore to keep the laptop specifier results and also make the navigation work. For fun, I enjoy drawing and painting.
        </p>
      </ul>
      <h2>Antara</h2>
      <ul>
        <p>
          Hi, I am Antara. I am an incoming junior studying computer engineering at Johns Hopkins University. I worked on the Google Maps and datastore portion of Laptop Shop. My sister told me I&apos;d never finish codeU on time because I procrastinate so much. I told her, &quot; Just you wait!&quot;  
        </p>
      </ul>
      <h2>Kamsi</h2>
      <ul>
        <p>
          Hi, i&apos;m kamsi. I&apos;m a sophomore at iowa state university. I worked on the customer reviews part of the project. I follow a lot of sports; I play a lot  of soccer and basketball in my free time.
        </p>
      </ul>
      <h2>Kevin</h2>
      <ul>
        <p>
          Hi, I&apos;m Kevin! I&apos;m a software engineer at Google, where I work for Google Maps. For fun I enjoy creative coding, hanging out with my cat, and exploring the hiking trails around California!
        </p>
      </ul>

      <center><img src="/css/gphoto.png" alt="Group Photo" class="center"></center>
<!--
      <div>
        <p>Find out where you can conveniently buy laptops</p>
      </div>
    </div>


    <div class="homepage">
          <div class="welcome-area" id="welcome">

            <div class="header-text">
          
                <div class="container">
                    <div class="row">
                        <div class="offset-xl-3 col-xl-6 offset-lg-2 col-lg-8 col-md-12 col-sm-12">
                              <h1></h1>
                        </div>
                    </div>
                </div>
            </div>

          </div>
      </div>
  <div id="map"></div>
-->
  </body>
</html>
