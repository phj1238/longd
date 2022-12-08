<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>header</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

<link href="/longd/css/header.css" rel="stylesheet" type="text/css" />

<!-- Scripts -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body class="is-preload">
<!-- Wrapper-->
	<div id="wrapper">
		<div id="top"></div>
		<!-- Nav -->
		<nav id="nav">
			<a href="/longd/longd/main.do" class="icon" id="mainPage"><img src="/longd/img/home.png"><span> 메인화면 </span></a>
				<a href="/longd/group/listGroup.do" class="icon" id="mygroupListPage" ><img src="/longd/img/group.png"><span> 그 룹 목 록 </span></a>
				<a href="/longd/map/map.do" class="icon" id="mapPage" ><img src="/longd/img/nav-marker.png"><span> 지 도 </span></a>				
 				<a href="/longd/map/newMapwrite.do" class="icon" id="searchMap" ><img src="/longd/img/search.png"><span> 장 소 검 색 </span></a>
				<a href="/longd/map/mapList.do" class="icon" id="mapList" ><img src="/longd/img/list.png"><span> 지 도 목 록 </span></a>
				<a href="/longd/map/write.do" class="icon" id="writePage" ><img src="/longd/img/edit.png"><span> 글 쓰 기 </span></a>
<!-- 				<a href="/longd/map/contentList.do" class="icon" id="mapListPage" ><img src="/longd/img/list.png"><span> 글 목 록 </span></a>-->
			<c:if test="${empty userInfo}">
				<a href="/longd/user/loginPage.do" class="icon" id="loginPage" ><img src="/longd/img/login.png"><span> 로 그 인 </span></a>
			</c:if>		
			<c:if test="${!empty userInfo }">
				<a href="/longd/user/mypage.do" class="icon" id="myPage" ><img src="/longd/img/user.png"><span> 내 정 보 </span></a>
 				<a href="/longd/user/logout.do" class="icon" id="logoutPage" ><img src="/longd/img/logout.png"><span> 로 그 아 웃 </span></a>
			</c:if>
			<a href=""><span>Twitter</span></a>
		</nav>
		<div id="main">

</html>