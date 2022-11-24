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

function pointch() {
	if(){
		point = point +1;
	}
	console.log(point+" point");
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