/*
 * This file contains helper functions that build various UI elements. Make sure this file is
 * loaded before you try to use these functions in other JavaScript files.
 */

/**
 * Builds an element that displays the message.
 * @param {Message} message
 * @return {Element}
 */
function buildMessageDiv(message) {
  const headerDiv = document.createElement('div');
  headerDiv.classList.add('message-header');
  headerDiv.appendChild(document.createTextNode(
      message.user + ' - ' + new Date(message.timestamp)));

  const bodyDiv = document.createElement('div');
  bodyDiv.classList.add('message-body');
  bodyDiv.innerHTML = message.text;

  const messageDiv = document.createElement('div');
  messageDiv.classList.add('message-div');
  messageDiv.appendChild(headerDiv);
  messageDiv.appendChild(bodyDiv);

  return messageDiv;
}

function buildLaptopDiv(laptop){
  const imgDiv = document.createElement('th');
  imgDiv.classList.add('laptop-body');
  var brand = laptop.brand;
  if(laptop.os == 'mac'){
    brand = laptop.os;
  }
  imgDiv.innerHTML = '<img src=/css/'+brand+laptop.size
        +laptop.color + laptop.os+'.jpg alter='
        +laptop.description+' style="width:60px;height:60px;">'; 

  const bodyDiv = document.createElement('th');
  bodyDiv.classList.add('laptop-body');
  bodyDiv.innerHTML = laptop.description; 
  const priceDiv = document.createElement('th');
  priceDiv.classList.add('laptop-price');
  priceDiv.innerHTML = '$'+laptop.price; 
  const laptopDiv = document.createElement('tr');
  laptopDiv.classList.add('laptop-div');
  laptopDiv.appendChild(imgDiv);
  laptopDiv.appendChild(bodyDiv);
  laptopDiv.appendChild(priceDiv);
  return laptopDiv;
}

/** Fetches messages and add them to the page. */
function fetchLaptops() {
  addLoginOrLogoutLinkToNavigation(); 
  var brand = document.getElementById('brand').value;
  var os = document.getElementById('os').value;
  var size = document.getElementById('size').value;
  var color = document.getElementById('color').value;
  var description = document.getElementById('description').value;
  var url = '/laptops?'+'brand='+brand+'&os='+os+'&size='+size+
        '&color='+color+'&description='+description;
  fetch(url)
      .then((response) => {
        return response.json();
      })
      .then((laptops) => {
        const laptopContainer = document.getElementById('laptop-container');
        if (laptops.length == 0) {
          laptopContainer.innerHTML = '<p>no laptop in shop yet.</p>';
        } else {
          laptopContainer.innerHTML = '';
        }
        laptops.forEach((laptop) => {
          const laptopDiv = buildLaptopDiv(laptop);
          laptopContainer.appendChild(laptopDiv);
        });
      });
}

/**
 * Creates an li element.
 * @param {Element} childElement
 * @return {Element} li element
 */
function createListItem(childElement) {
  const listItemElement = document.createElement('li');
  listItemElement.appendChild(childElement);
  return listItemElement;
}

/**
 * Creates an anchor element.
 * @param {string} url
 * @param {string} text
 * @return {Element} Anchor element
 */
function createLink(url, text) {
  const linkElement = document.createElement('a');
  linkElement.appendChild(document.createTextNode(text));
  linkElement.href = url;
  return linkElement;
}

function buildShop(){
  addLoginOrLogoutLinkToNavigation(); 
  /* fetchLaptops(); */

}
