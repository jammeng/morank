$(function(){
	var container = $('.full-bg');

	$(window).resize(function(){
		var currentWindow = $(this),
			windowWidth = currentWindow.width(),
			windowHeight = currentWindow.height(),
			broswerRatio = windowWidth / windowHeight,
			imageRatio = 너비/높이;

		if(imageRatio > broswerRatio){
			container.css({
				height: '100%',
				width: windowHeight * imageRatio, // 현재 윈도우 높이 X 원래 이미지 비율
				left: (windowWidth - windowHeight * imageRatio) / 2 , //(브라우저 너비 - 이미지 너비) / 2
				top: 0,
			});
		}else{
			container.css({
				height:windowWidth/imageRatio, // 이미지 너비/ 이미지 비율
				width: '100%',
				left:0,
				top:(windowHeight - windowWidth/imageRatio)/2, //(브라우저 높이 - 이미지 높이) /2
			});
		}
	}); //Resize
	$(window).trigger(resize);
});//document ready