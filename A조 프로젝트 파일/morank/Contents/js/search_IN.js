function doDisplay1(){

  var text = document.getElementById("horror");
  var text2 = document.getElementById("comedy");
  var text3 = document.getElementById("mello");

  if(text.style.display == 'none'){
      text.style.display = 'block';
      text2.style.display = 'none';
      text3.style.display = 'none';
  } else {
      text.style.display = 'none';
  }
}

function doDisplay2(){

  var text = document.getElementById("horror");
  var text2 = document.getElementById("comedy");
  var text3 = document.getElementById("mello");

  if(text2.style.display == 'none'){
    text.style.display = 'none';
    text2.style.display = 'block';
    text3.style.display = 'none';
  } else {
    text2.style.display = 'none';
  }
}

function doDisplay3(){

  var text = document.getElementById("horror");
  var text2 = document.getElementById("comedy");
  var text3 = document.getElementById("mello");

  if(text3.style.display == 'none'){
    text.style.display = 'none';
    text2.style.display = 'none';
    text3.style.display = 'block';
  } else {
    text3.style.display = 'none';
  }
}
