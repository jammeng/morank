

function OpenPop() {
   document.getElementById("popup_layer").style.display = "";
}
function OpenPopimg() {
   document.getElementById("img_popup_layer").style.display = "";
}
function closePop() {
   document.getElementById("popup_layer").style.display = "none";

}
function closePopimg() {
   document.getElementById("img_popup_layer").style.display = "none";

}



function ClickLikeButton()
{
   const btnElement=document.getElementById("likebtn");
   btnElement.innerText  = '추천완!';
   
}

function copyToClipboard(elementId) {

  // 글을 쓸 수 있는 란을 만든다.
  var aux = document.createElement("input");

  // 지정된 요소의 값을 할당 한다.
  aux.setAttribute("value", document.getElementById(elementId).innerHTML);

  // bdy에 추가한다.
  document.body.appendChild(aux);

  // 지정된 내용을 강조한다.
  aux.select();

  // 텍스트를 카피 하는 변수를 생성
  document.execCommand("copy");

  // body 로 부터 다시 반환 한다.
  document.body.removeChild(aux);

   alert("링크 복사에 성공 하였습니다.");

}


function formCheck(){
   
   
   var comment_inputs = document.form1.comment_inputs.value;
   
   
   if(comment_inputs == null || comment_inputs == "")
   {
      alert('내용을 입력하세요');
      document.forms1.comment_inputs.focus();
      return false;
   }
   
   

}