/**
 * 
 */
$(document).ready(function() {
/*	setInterval(function() {
		$(".img_slide").eq(0).insertAfter($(".img_slide").last());
		$(".img_slide").css("marginLeft","0px");
	}, 3000);*/

    $("#modal-open").click(function(){        
        $("#popup").css('display','flex').hide().fadeIn();
        //팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
    });

    $("#confirm").click(function(){
        modalClose(); //모달 닫기 함수 호출
      
        //컨펌 이벤트 처리
		document.frm.submit();
    });

    $("#close").click(function(){
        modalClose(); //모달 닫기 함수 호출
    });

    function modalClose(){
        $("#popup").fadeOut(); //페이드아웃 효과
    }
	
});


function ShowSliderValue(obj)
{
	/*console.log(obj.value);*/
	document.frm.range_val.value = parseFloat(obj.value / 10.0).toFixed(1);
}
	
var size=1;
var maxSize = 6;
function img_add()
{
	size++;
	if (size > maxSize) {
		size = maxSize;
		console.log(size);
		return;
	}
		
	var img = document.getElementById("uploadimage");
	var inner ="<p class='fname'><input type='file' name='fname"+size+" id='review_btn3'></p>";
	img.innerHTML = img.innerHTML+inner;
	var obj = document.getElementsByClassName("fname");
	console.log(obj);
}

function img_del()
{
	var obj = document.getElementsByClassName("fname");
	console.log(obj);
    if(size > 1)
    {	
	    obj[size-1].remove();
	    size--;
		if (size < 2) {
			size = 1;
			return;
		}
    }
}

function img_setvalue(val) {
	maxSize = val;
}







