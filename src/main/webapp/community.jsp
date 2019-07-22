<!DOCTYPE html>
<html>
  <head>
    <title>Shopper Reviews</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/ui-builder.js"></script>

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

    <script>

      /** Fetches users and adds them to the page. */
      function fetchUserList(){
        const url = '/user-list';
        fetch(url).then((response) => {
          return response.json();
        }).then((users) => {
          const list = document.getElementById('list');
          list.innerHTML = '';

          users.forEach((user) => {
           const userListItem = buildUserListItem(user);
           list.appendChild(userListItem);
          });
        });
      }

      /**
       * Builds a list element that contains a link to a user page, e.g.
       * <li><a href="/user-page.html?user=test@example.com">test@example.com</a></li>
       */
      function buildUserListItem(user){
        const userLink = document.createElement('a');
        userLink.setAttribute('href', '/user-page.jsp?user=' + user);
        userLink.appendChild(document.createTextNode(user));
        const userListItem = document.createElement('th');
        userListItem.appendChild(userLink);
        const userDiv = document.createElement('tr');
        userDiv.appendChild(userListItem);
        return userDiv;
      }
          /** Fetches data and populates the UI of the page. */
      function buildUI(){

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
          fetchUserList();
          createMap();
      }
  </script>

  </head>
  <body onload="buildUI()">
    <%@include file="/WEB-INF/navigation.jsp" %>
    <div class="community" id="content">
      <h1>Shopper Reviews</h1>
      <p>Here is a list of every user who has posted a review. Click on a user email to see their history of reviews: </p>
      <hr class="type_3">
      <table id="list" align="left" >
      </table>
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

      <div>
        <p>Find out where you can conveniently buy laptops</p>
      </div>
    </div>


  <div id="map"></div>

  </body>
</html>