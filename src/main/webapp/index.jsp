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
<html class="home-bg">
  <head>
    <meta charset="UTF-8">
    <title>CodeU 2019 Shopping Project</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/navigation-loader.js"></script>
    <script src="/js/ui-builder.js"></script>
  </head>
  <body onload="addLoginOrLogoutLinkToNavigation();">
    <%@include file="/WEB-INF/navigation.jsp" %>
      <div class="homepage">
          <div class="welcome-text">
            <h1><strong>Laptop Shop</strong></h1>
            <p>Welcome to the Shop, use our search filter  and compare reviews to find the best laptop for you</p>
          </div>

        <form id="laptop-form"  >
          <div class="options">
            <select name="brand" id="brand">
              <option value="">brand</option>
              <option value="Dell">Dell</option>
              <option value="Macbook Pro">MacBook Pro</option>
              <option value="Thinkpad">Lenovo</option>
            </select>
            <select name="os" id="os">
              <option value="">OS</option>
              <option value="Mac">Mac</option>
              <option value="Windows">Windows</option>
            </select>
            <select name="size" id="size">
              <option value="">size</option>
              <option value="13">13"</option>
              <option value="15">15"</option>
            </select>
            <select name="color" id="color">
              <option value="">color</option>
              <option value="Black">Black</option>
              <option value="Grey">Grey</option>
              <option value="Silver">Silver</option>
            </select>
          </div>
          <input name="description" id="description" type="search" placeholder = "Search for a laptop"/>
            <div class="button" style="vertical-align:middle">
              
              <button onclick="fetchLaptops();return false;"><span>Submit</span></button>
            </div>
          </form>

        <table id="laptop-container" align="center" style = "width:90%" >
        </table>
      </p>
    </div>
  </body>
</html>
