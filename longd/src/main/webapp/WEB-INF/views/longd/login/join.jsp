<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>로그인</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />
<style>
</style>

<script type="text/javascript">
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
</script>

</head>
		<article id="contact" class="panel">
			<header>
				<h2> 회 원 가 입 </h2>
			</header>
			<form action="login.do" method="post">
				<div>
					<!-- row 시작 -->
					<div class="row">
						<div class="col-12 login">
							<input type="text" name="id" placeholder="아이디" />
						</div>
						<div class="col-12 login">
							<input type="password" name="pwd" placeholder="비밀번호" />
						</div>
						<div class="col-12">
							<input type="submit" value="가입" />
							<br><br>
							<div id="naverspan">
								<img id="naverImg" src="/longd/img/naver.png"><input id="naverBtn" type="submit" value="네이버 아이디로 로그인" />
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