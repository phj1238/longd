<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>content 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

</head>
	<!-- Wrapper-->
		<!-- Main -->
			<!-- Contact -->
			<article id="contact" class="panel">
				<form id="form" action="" method="post"  enctype="multipart/form-data">
				<header>
					<h2>content </h2>
					<p> 장소 : ${mlist.address}</p>
					<p> 상호명 : ${mlist.name}</p>
				</header>
				<div>
					<!-- row 시작 -->
					<div class="row">
						<div class="col-12">
							<!-- content 작성날짜 -->
							<span>작성 날짜</span>
							<input type="text" name="content_regdate" value="${clist.content_regdate }">
						</div>
						<div class="col-12">
							<span>방문 날짜</span>
							<input type="text" name="visit_regdate" value="${clist.visit_regdate }">
						</div>
						<div class="col-12">
							<span>제목</span>
							<span>${clist.content_title}</span>
						</div>
						<div class="col-12">
							<textarea name="content" rows="6">${clist.content }</textarea>
						</div>
						<div class="col-12">
							<input type="submit"  onclick="filecheck();" value="수정" />
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