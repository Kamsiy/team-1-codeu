<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>CodeU 2019 Shopping Project</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/navigation-loader.js"></script>
    <script src="/js/ui-builder.js"></script>
    <script src="/js/form-generator.js"></script>
  </head>
  <body onload="addLoginOrLogoutLinkToNavigation();">
    <%@include file="/WEB-INF/navigation.jsp" %>
    <div class="container" id="merchant-page"> 
      <h1> Merchant Submission form </h1>
      <p> Enter an item to add to sell on the platform </p>
      <form>
        <select id="merchant_form">
          <option value="" disabled selected>Select a Category</option>
          <option value="Laptop">Laptops</option>
        </select>
        <button type="button" onclick="checkSelection()">Next</button>
      </form>
    </div>
  </body>
</html>
