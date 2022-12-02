<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title>Astral by HTML5 UP</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />
	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var point = 0;

$(function () {
	var main = $("#home");
	main.removeClass("active");
	
	var page = $("#loginPage");
	page.addClass("active");
	
	var wrapper = $("#wrapper");
	wrapper.attr("id","login");
	
	$("#naverspan").click(function () {
		
	})
})

function goIdcheck() {
	var id = $("input[name='id']").val();
	
	if ($("input[name='id']").val().trim() == '') {
		alert('아이디를 입력해 주세요');
		$("input[name='id']").focus();
		return;
	}
	
	$.ajax ({
		url : 'checkId.do',
		method : 'post',
		data : {
			id : id
		},
		dataType : 'json',
		success : function (data) {
			console.log(data);
			if (data == 0){
				$(".checkid").text(id+" 는 사용 가능한 아이디 입니다.");
			}else {
				$(".checkid").text(id+" 는 중복된 아이디 입니다.");
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	})
}

function goNickcheck() {
	var nick = $("input[name='nick']").val();
	
	if ($("input[name='nick']").val().trim() == '') {
		alert('닉네임을 입력해 주세요');
		$("input[name='nick']").focus();
		return;
	}
	
	$.ajax ({
		url : 'checkNick.do',
		method : 'post',
		data : {
			nick : nick
		},
		dataType : 'json',
		success : function (data) {
			console.log(data);
			if (data == 0){
				$(".checknick").text(nick+" 는 사용 가능한 닉네임 입니다.");
			}else {
				$(".checknick").text(nick+" 는 중복된 닉네임 입니다.");
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	})
}

function checkpoint() {
	if (point == 3) {
		$("#submit").attr("disabled", false);
	}else{
		$("#submit").attr("disabled", true);
	}
}

$(function () {
	$("#pwd2").on("propertychange change keyup paste input", function() {
		var pwd = $("input[name='pwd']").val();
		var pwd2 = $(this).val();
		
		if (pwd == pwd2) {
			console.log(pwd+pwd2);
			$(".pwdcheck").text("비밀번호가 같습니다.");
		} else {
			$(".pwdcheck").text("비밀번호가 틀립니다.");
		}
	})
	
})
</script>	
<script>
function postcode(){
	new daum.Postcode({
	oncomplete: function(data) {
	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	 
	  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	  var fullAddr = ''; // 최종 주소 변수
	  var extraAddr = ''; // 조합형 주소 변수
	 
	  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	      fullAddr = data.roadAddress;
	  } else { // 사용자가 지번 주소를 선택했을 경우(J)
	      fullAddr = data.jibunAddress;
	  }
	 
	  // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	  if(data.userSelectedType === 'R'){
	      //법정동명이 있을 경우 추가한다.
	      if(data.bname !== ''){
	          extraAddr += data.bname;
	      }
	      // 건물명이 있을 경우 추가한다.
	      if(data.buildingName !== ''){
	          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	      fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	  }
	 
	  // 우편번호와 주소 정보를 해당 필드에 넣는다.
	  document.getElementById('postcode').value = data.zonecode;
	  document.getElementById("addr1").value = fullAddr;
	  // 커서를 상세주소 필드로 이동한다.
	  document.getElementById("addr2").focus();
	}
	 
	}).open();
}
</script>
</head>
	<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<header>
						<h2>회원가입</h2>
					</header>
					<form action="join.do" method="post">
						<div> 
							<div class="row">
								<div class="col-12 join">
									<div class="id">
										<span>아이디</span>
										<input type="text" name="id" placeholder="아이디" /> <input type="button" onclick="goIdcheck()" value="아이디 중복확인">
										<br>
										<span class="checkid"></span>
									</div>
								</div>
								<div class="col-12 join">
									<div class="password">
										<span>비밀번호</span>
										<input type="password" name="pwd" id="pwd" placeholder="비밀번호" />
									</div>
									<div class="password">
										<span>비밀번호 확인</span>
										<input type="password" name="pwd2" id="pwd2" placeholder="비밀번호" />
										<br>
										<span class="pwdcheck"></span>
									</div>
								</div>
								<div class="col-12 join">
									<div class="nick">
										<span>닉네임</span>
										<input type="text" name="nick" placeholder="닉네임" /> <input type="button" onclick="goNickcheck()" value="닉네임 중복확인">
										<br>
										<span class="checknick"></span>
									</div>
								</div>
								<div class="col-12 join">
									<div class="addr">
										<span>주소</span>
										<a href="javascript:void(0);" onclick="postcode();return false;" class="btn btn-info m-btn--air">우편번호찾기</a>
										<div class="addr1">
											<input type="text" name="postcode" id="postcode" placeholder="우편번호">
										</div>
										<div class="addr1">
											<input type="text" name="addr1" id="addr1" placeholder="주소">
										</div>
										<div class="addr1">
											<input type="text" name="addr2" id="addr2" placeholder="상세주소" >
										</div>
									</div>
								</div>
								<div class="col-12">								
									<div class="col-12">
										<input type="button" value="회원가입" id="submit" onclick="pointch()"/>
									</div>
								</div>
							</div>
						</div>
					</form>
				</article>
			</div>
		</div>
</body>
</html>