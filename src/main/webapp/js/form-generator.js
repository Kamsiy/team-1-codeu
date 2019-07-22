function checkSelection(){
  var categories = document.getElementById("merchant_form");
  var selected = categories.options[categories.selectedIndex].text; 
  console.log(selected, categories)
  generateForm(selected)
}

function generateForm(type){
  var form = document.getElementsByTagName('form')[0];
  if(type == "Laptops"){
    var options = document.getElementsByTagName('select')[0];
    var button = document.getElementsByTagName('button')[0];
    form.removeChild(options);
    form.removeChild(button);

    // append elements to new form
    var tagList = ['Name', 'Size', 'OS', 'Brand', 'Color'];
    createFormRows(tagList, form);
  }

  // add submission button
  createFormElement('input', null, form, null)
  var button = document.getElementsByTagName('input')[5];
  button.type = 'submit';
  button.className = 'button';
  button.value = 'Submit';
}

function createFormRows(names, parent){
  console.log(names);
  for(var i = 0; i < names.length; i++){
    var newParent = createFormElement('div', null, parent, null)
    console.log(newParent)
    createFormElement('span', names[i], newParent, null)
    createFormElement('input', null, newParent, names[i])
  }
}


function createFormElement(tag, text, parent, id){
  // if null, its an input field, else its a label
  var element;
  if(text != null){
    element = document.createElement(tag);
    console.log(element);
    element.appendChild(document.createTextNode(text));
    parent.appendChild(element);
  } else{
    element = document.createElement(tag);
    console.log(element);
    element.id = id;
    parent.appendChild(element);
  }
  return element;
} 