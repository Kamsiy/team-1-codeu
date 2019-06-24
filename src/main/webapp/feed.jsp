<!DOCTYPE html>
<html>
<head>
  <title>Message Feed</title>
  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/user-page.css">
  <script>
    // Fetch messages and add them to the page.
    function fetchMessages(){
      const url = '/feed';
      fetch(url).then((response) => {
        return response.json();
      }).then((messages) => {
        const messageContainer = document.getElementById('message-container');
        if(messages.length == 0){
         messageContainer.innerHTML = '<p>There are no posts yet.</p>';
        }
        else{
         messageContainer.innerHTML = '';
        }
        messages.forEach((message) => {
         const messageDiv = buildMessageDiv(message);
         messageContainer.appendChild(messageDiv);
        });
      });
    }

    // Fetch data and populate the UI of the page.
    function buildUI(){
     fetchMessages();
    }
  </script>
  <script src="/js/ui-builder.js"></script>
</head>
<body onload="buildUI()">
<%@include file="navigation.jsp" %>
<div id="content">
  <h1>Message Feed</h1>
  <hr/>
  <div id="message-container">Loading...</div>
</div>
</body>
</html>