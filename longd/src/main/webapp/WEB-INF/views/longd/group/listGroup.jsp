<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../common/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그룹 리스트</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />
<script>
$(function () {
	var main = $("#home");
	main.removeClass("active");
	
	var page = $("#mygroupListPage");
	page.addClass("active");
	
	$('.group_name').click(function () {
		var group_name = $(this).text();
		console.log("group_name : " + group_name);
		
	})
	
	$('#newGroup').click(function () {
		location.href = '/longd/group/newGroup.do';
	})
})
</script>



</head>
<!-- Wrapper-->
	<!-- Main -->
		<!-- Contact -->
		<article id="contact" class="panel">
			<header>
				<h2>그룹 목록</h2>
			</header>
				<div>
					<!-- row 시작 -->
					<div class="row">
						<div class="col-12">
							<input type="button" value="그룹 만들기" id="newGroup" style="float:right;">
						</div>
						<div class="col-12">
							<table border="1" id="grouplist">
								<tr>
									<th><h3 style="color: #fff;">번호</h3></th>
									<th><h3 style="color: #fff;">그룹 이름</h3></th>
									<th><h3 style="color: #fff;">만든 날짜</h3></th>
								</tr>
								<c:forEach items="${glist.glist}" var="list" varStatus="status">
									<tr>
										<td>${glist.groupcount-status.index-(groupVO.page-1)*groupVO.pageRow }</td>
										<td><a target="" href="/longd/map/map.do?group_no=${list.group_no }" class="group_name" >${list.group_name }</a></td>
										<td><fmt:formatDate value="${list.group_member_regdate}" pattern="yyyy-MM-dd" /></td>
									</tr>
								</c:forEach>
							</table>
						</div>
						
						<!-- 페이징 처리 -->
						<div class="col-12">
							<div class="paging">
		                        <ul>
			                        <c:if test="${glist.prev == true }">
			                        	<li><a href="mapList.do?page=${glist.startPage }&stype=${param.stype}&sword=${param.sword}"><</a></li>
			                        </c:if>
			                        <c:forEach var="p" begin="${glist.startPage }" end="${glist.endPage }">
			                            <li><a href='mapList.do?page=${p }&stype=${param.stype}&sword=${param.sword}' <c:if test="${groupVO.page == p }">class='current'</c:if>>${p }</a></li>
			                        </c:forEach>
			                        <c:if test="${glist.next == true }">
			                        	<li><a href="mapList.do?page=${glist.endPage+1 }&stype=${param.stype}&sword=${param.sword}">></a>
			                        </c:if>
		                        </ul> 
	                		</div>
                		</div>
					</div>
					<!-- row 끝 -->
				</div>
		</article>
	</div>
</div>


</body>
</html>