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
    <title>User Page</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/user-page.css">
    <script src="/js/user-page-loader.js"></script>
    <script src="/js/ui-builder.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
  </head>
  <body onload="buildUI();">
    <%@include file="navigation.jsp" %>
    <h1 id="page-title">User Page</h1>

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
  <form action="/about" method="POST">
    <textarea name="about-me" placeholder="about me" rows=4 required></textarea>
    <br/>
    <input type="submit" value="Submit">
  </form>
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
