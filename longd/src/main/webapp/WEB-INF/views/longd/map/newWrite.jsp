<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>새로 map 글 쓰기</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<!-- 달력 //제이쿼리 ui css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<style>
.insert .file-list {
    overflow: auto;
    padding: 10px;
    display: flex;
	box-shadow: 0 1px 1px rgb(0 0 0 / 5%);    
}

/* .insert .file-list .filebox span {
    font-size: 14px;
    margin-top: 10px;
}
 */

.insert .file-list .filebox .delete .Ximg{
    color: #ff5353;
    margin-left: 5px;
    width: 20px;
    height: 20px;
    position: absolute;
}


.save{
	float: right;
	color : #fff;
	background-color: #0095f6;
	border: 0;
    width: 60px;
    height: 28px;
    border-radius: 6px;
	box-shadow: 0 3px 3px rgb(0 0 0 / 5%);    
}

.img{
	width:90px; 
	height:90px; 
	box-shadow: 0 3px 3px rgb(0 0 0 / 5%);    
}


.filebox{
	width: 120px;
	height: 100px;
	justify-content: space-between;
}
</style>

<script type="text/javascript">
$(function () {
	var main = $("#home");
	main.removeClass("active");
	 
	var page = $("#writePage");
	page.addClass("active");
	
	$("#markerList .markerImg").on('click', function () {
		$(".markerImg").removeClass("markerImgactive");
		$(this).addClass('markerImgactive');
		console.log($("input[type=radio][name=marker]:checked").val());
	})
	
	$("#datepicker").datepicker({
		dateFormat: 'yy-mm-dd', //날짜 표시 형식 설정
	    showOtherMonths: true, //이전 달과 다음 달 날짜를 표시
	    showMonthAfterYear:true, //연도 표시 후 달 표시
	    changeYear: true, //연도 선택 콤보박스
	    changeMonth: true, //월 선택 콤보박스
	    showOn: "both", //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
	    yearSuffix: "년", //연도 뒤에 나오는 텍스트 지정
	    monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	    minDate: "-10y", // -1D:하루전, -1M:한달전, -1Y:일년전
	    buttonImage: "/longd/img/calendar.png", //버튼에 띄워줄 이미지 경로
	    buttonImageOnly: true, //디폴트 버튼 대신 이미지 띄워줌
	    buttonText: "선택", //버튼 마우스오버 시 보이는 텍스트
	});
	
})
</script>


<script>
var fileNo = 0;
var filesArr = new Array();

/* 첨부파일 추가 */
function addFile(obj){
    var maxFileCnt = 5;   // 첨부파일 최대 개수
    var attFileCnt = document.querySelectorAll('.filebox').length;    // 기존 추가된 첨부파일 개수
    var remainFileCnt = maxFileCnt - attFileCnt;    // 추가로 첨부가능한 개수
    var curFileCnt = obj.files.length;  // 현재 선택된 첨부파일 개수
	
    
    // 첨부파일 개수 확인
    if (curFileCnt > remainFileCnt) {
        alert("첨부파일은 최대 " + maxFileCnt + "개 까지 첨부 가능합니다.");
    } 
 
    for (var i = 0; i < Math.min(curFileCnt, remainFileCnt); i++) {
    	
        const file = obj.files[i];
        
        // 첨부파일 검증
        if (validation(file)) {
            // 파일 배열에 담기
            var reader = new FileReader();
            reader.onload = function (event) {
            	// 파일 이미지 src 담기
            	var imgsrc = event.target.result;
				
				let htmlData = '';
				htmlData += '<div id="file' + fileNo + '" class="filebox">';
	            htmlData += '	<img class="img" src="'+imgsrc+'">';
	            // 파일이름
	            //htmlData += '   <span id="name" class="name">' + file.name + '</span>';
	            htmlData += '   <a class="delete" onclick="deleteFile(' + fileNo + ');">';
	            htmlData += '		<span type="button" class="far fa-minus-square"><img class="Ximg" src="/longd/img/X.png"></span>';
	            htmlData += '	</a>';
	            htmlData += '</div>';
	            $('.file-list').append(htmlData);
	            fileNo++;
				
				filesArr.push(file);
            };
            reader.readAsDataURL(file);
            
        } else {
            continue;
        }
    }
    // 초기화
    document.querySelector("input[type=file]").value = "";
}

/* 첨부파일 검증 */
function validation(obj){
    const fileTypes = ['application/pdf', 'image/gif', 'image/jpeg', 'image/png', 'image/bmp', 'image/tif', 'application/haansofthwp', 'application/x-hwp'];
    if (obj.name.length > 100) {
        alert("파일명이 100자 이상인 파일은 제외되었습니다.");
        return false;
    } else if (obj.size > (100 * 1024 * 1024)) {
        alert("최대 파일 용량인 100MB를 초과한 파일은 제외되었습니다.");
        return false;
    } else if (obj.name.lastIndexOf('.') == -1) {
        alert("확장자가 없는 파일은 제외되었습니다.");
        return false;
    } else if (!fileTypes.includes(obj.type)) {
        alert("첨부가 불가능한 파일은 제외되었습니다.");
        return false;
    } else {
        return true;
    }
}

/* 첨부파일 삭제 */
function deleteFile(num) {
    document.querySelector("#file" + num).remove();
    filesArr[num].is_delete = true;
}


function filecheck() {
    // 첨부파일이 없을 때 
	var form = $(".filebox").val();
    if (form == null) {
    	alert("사진을 등록해 주세요");
    	return fales;
    	
    } else {
    		
    	var form = $('form')[0];
    	var formData = new FormData(form);

    	    for (var i = 0; i < filesArr.length; i++) {
    	        // 삭제되지 않은 파일만 폼데이터에 담기
    	        if (!filesArr[i].is_delete) {
    	            formData.append("file", filesArr[i]);
    	    	    console.log("file?????? : " + filesArr[i]);
    	        }
    	    }
    	    //var pet_content = $("#pet_content").val();
    	    //var data = formData + pet_content;
    	    //console.log("찍히니?2 : " + pet_content);
    	    
    	    $.ajax({
    	    	method: 'POST',
    	        url: 'newMapinsert.do',
    	        dataType: 'json',
    	        data: formData,
    	        async: true,
    	        contentType: false,
    	        processData: false,
    	        //enctype : 'multipart/form-data',
    	        //timeout: 30000,
    	        //cache: false,
    	        //headers: {'cache-control': 'no-cache', 'pragma': 'no-cache'},
    	        success: function () {
    	            alert("성공");
    	        },
    	        error: function (xhr, desc, err) { 
    	            alert('에러가 발생 하였습니다.');
    	            console.log(err);
    	            return;
    	        }
    	    });
    }
}
</script>



	
</head>
	<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<form id="form" action="" method="post"  enctype="multipart/form-data">
						<input type="hidden" name="px" value="${list.px}"> 
						<input type="hidden" name="py" value="${list.py}"> 
						<input type="hidden" name="address" value="${list.address}"> 
						<input type="hidden" name="name" value="${list.title}"> 
						<input type="hidden" name="displayName" value="${list.title}"> 
					<header>
						<h2>글 쓰기 </h2>
						<p> 장소 : ${list.address}</p>
						<p> 상호명 : ${list.title}</p>
					</header>
					
					<div id="writeDate">날짜 : <input type="text" id="datepicker" name="" > </div>
					<div id="markerList">
						<span id="markerText">마커</span>
						<label for="marker1" class="marker"><input type="radio" name="marker" id="marker1" value="marker1.png"><img class="markerImg" src="/longd/img/marker1.png"></label>
						<label for="marker2" class="marker"><input type="radio" name="marker" id="marker2" value="marker2.png"><img class="markerImg" src="/longd/img/marker2.png"></label>
						<label for="marker3" class="marker"><input type="radio" name="marker" id="marker3" value="marker3.png"><img class="markerImg" src="/longd/img/marker3.png"></label>
						<label for="marker4" class="marker"><input type="radio" name="marker" id="marker4" value="marker4.png"><img class="markerImg" src="/longd/img/marker4.png"></label>
						<label for="marker5" class="marker"><input type="radio" name="marker" id="marker5" value="marker5.png"><img class="markerImg" src="/longd/img/marker5.png"></label>
					</div>
						<div>
							<!-- row 시작 -->
							<div class="row">
								<div class="col-12">
									<textarea name="content" placeholder="내용" rows="6"></textarea>
								</div>
								
								<div class="col-12">
									<div class="write">
										<div class="insert">
											<input type="file" onchange="addFile(this);"  multiple />
											<div class="file-list"></div>
										</div>
									</div>
								</div>
								<div class="col-12">
									<input type="submit"  onclick="filecheck();" value="작성완료" />
								</div>
							</div>
							<!-- row 끝 -->
						</div>
					</form>
				</article>
			</div>
		</div>
</body>
</html>