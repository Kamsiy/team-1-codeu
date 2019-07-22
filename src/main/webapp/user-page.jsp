<!DOCTYPE html>
<html class="ShopperPage">
  <head>
    <title>User Page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/user-page.css">
    <script src="/js/navigation-loader.js"></script>
    <script src="/js/user-page-loader.js"></script>
    <script src="/js/ui-builder.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
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
                buildUI();


      }
    </script>
  </head>
  <body onload="addLoginOrLogoutLinkToNavigation();">
    <%@include file="/WEB-INF/navigation.jsp" %>
          <div class="welcome-area" id="welcome">

            <div class="header-text">
                <div class="container">
                    <div class="row">
                        <div class="offset-xl-3 col-xl-6 offset-lg-2 col-lg-8 col-md-12 col-sm-12">
                                <h1 id="page-title">Shopper Page</h1>
                        </div>
                    </div>
                </div>
            </div>



    <form id="message-form" action="/messages" method="POST" class="hidden">
      Enter a new message:
      <br/>
      <textarea name="text" id="message-input"></textarea>
      <br/>
   <input type="submit" value="Submit">
    </form>
    <hr/>

    <div id="message-container">Loading...</div>

    <div id="about-me-container">Loading...</div>
  <div id="about-me-form" class="hidden">
  </div>  
  
  <script>
     function fetchAboutMe(){
  const url = '/about?user=' + parameterUsername;
  fetch(url).then((response) => {
    return response.text();
  }).then((aboutMe) => {
     const aboutMeContainer = document.getElementById('about-me-container');
     if(aboutMe == ''){
    aboutMe = 'This user has not entered any information yet.';
     }
           aboutMeContainer.innerHTML = aboutMe;
  });
      }

  </script>

  </body>
</html>
