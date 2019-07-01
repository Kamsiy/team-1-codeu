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
  </head>
  <body>
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