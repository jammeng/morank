// function doDisplay(){
//   var con = document.getElementById("term_text_1")
//   if(con.style.display=='none'){
//       con.style.display = 'block';
//   } else {
//     con.style.display = 'none';
//   }
// }

function doDisplay1(){

  var text = document.getElementById("term_text_1")
  var text2 = document.getElementById("term_text_2")
  var text3 = document.getElementById("term_text_3")
  var con = document.getElementById("term_text")
  var con2 = document.getElementById("background")

  if(con.style.display=='none'){
      text.style.display = 'block';
      text2.style.display = 'none';
      text3.style.display = 'none';
      con.style.display = 'block';
      con2.style.display = 'block';
  } else {
      con.style.display = 'none';
  }
}

function doDisplay2(){

  var text = document.getElementById("term_text_1")
  var text2 = document.getElementById("term_text_2")
  var text3 = document.getElementById("term_text_3")
  var con = document.getElementById("term_text")
  var con2 = document.getElementById("background")

  if(con.style.display=='none'){
    text.style.display = 'none';
    text2.style.display = 'block';
    text3.style.display = 'none';
    con.style.display = 'block';
    con2.style.display = 'block';
  } else {
    con.style.display = 'none';
  }
}

function doDisplay3(){

  var text = document.getElementById("term_text_1")
  var text2 = document.getElementById("term_text_2")
  var text3 = document.getElementById("term_text_3")
  var con = document.getElementById("term_text")
  var con2 = document.getElementById("background")

  if(con.style.display=='none'){
    text.style.display = 'none';
    text2.style.display = 'none';
    text3.style.display = 'block';
    con.style.display = 'block';
    con2.style.display = 'block';
  } else {
    con.style.display = 'none';
  }
}
