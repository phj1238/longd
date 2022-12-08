<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>글 쓰기</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<!-- //제이쿼리 ui css -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="/longd/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<style>
</style>

<script type="text/javascript">
var oEditors = [];

$(function () {
	var main = $("#home");
	main.removeClass("active");
	 
	var page = $("#writePage");
	page.addClass("active");
	
	 nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "content",
	        sSkinURI: "/longd/smarteditor/SmartEditor2Skin.html",    
	        htParams : {
	            bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            fOnBeforeUnload : function(){
	                //alert("아싸!");    
	            }
	        }, //boolean
	        fOnAppLoad : function(){
	            //예제 코드
	            //oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	        },
	        fCreator: "createSEditor2"
	    });
	
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
function setEditor(){
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "content",
        sSkinURI: "/smarteditor/SmartEditor2Skin.html",    
        htParams : {
            bUseToolbar : true,                // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            fOnBeforeUnload : function(){
                //alert("아싸!");    
            }
        }, //boolean
        fOnAppLoad : function(){
            //예제 코드
            //oEditors.getById["contents"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
        },
        fCreator: "createSEditor2"
    });
   
    return oEditors;
}

</script>



	
</head>
	<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<header>
						<h2>글 쓰기 </h2>
						<p> 장소 : ${list.address}</p>
						<p> 상호명 : ${list.name}</p>
					</header>
					<form id="form" action="insert.do" method="post"  enctype="multipart/form-data">
					<input type="hidden" name="map_no" value="${list.map_no }">
						<div id="writeDate">날짜 : <input type="text" id="datepicker" name="" > </div>
						<div>
							<!-- row 시작 -->
							<div class="row">
								<div class="col-12">
									<textarea name="content"  id="content" placeholder="내용" rows="6"></textarea>
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