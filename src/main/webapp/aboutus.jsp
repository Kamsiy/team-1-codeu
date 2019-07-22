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
  </head>
  <body>
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
