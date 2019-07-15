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
    <title>CodeU 2019 Shopping Project</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/navigation-loader.js"></script>
    <script src="/js/ui-builder.js"></script>
  </head>
  <body onload="addLoginOrLogoutLinkToNavigation();">
    <%@include file="/WEB-INF/navigation.jsp" %>
      <div class="homepage">
        <h1>Shop</h1>
        <p>Welcome to the Shop, enter an item to get started</p>
        <form>
          <input type="search" placeholder = "Search for an item" />
          <input type="submit" value="Submit" class="button">
        </form>
    </div>
  </body>
</html>
