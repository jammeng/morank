window.onload = function(){
  var display = document.getElementById("profile_wrap");
  var btn = document.getElementById("login_btn");

  btn.onclick = function(){
    if(display.style.display=="none"){
      display.style.display = "block";
    } else {
      display.style.display = "none";
    }
  }
}
