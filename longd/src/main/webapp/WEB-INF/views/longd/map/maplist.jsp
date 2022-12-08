<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">

<title>지도 목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function () {
	var main = $("#home");
	main.removeClass("active");
	
	var page = $("#mapList");
	page.addClass("active");
	
	$("#map").on('click', function () {
		location.href = '/longd/map/map.do';
	})
	
})

function pageBtn(p) {
	console.log(p);
	var nowPage = $(".nowPage"+p);
	nowPage.addClass("active");
}
</script>

<style type="text/css">
#mapBtn {
	margin: 0px 0px 0px 700px;
}
</style>


</head>
<!-- Wrapper-->
	<!-- Main -->
		<!-- Contact -->
		<article id="contact" class="panel">
			<header>
				<h2> 장소 목록</h2>
			</header>
				<div>
					<!-- row 시작 -->
					<div class="row">
						<div class="col-12">
							<p> ${list.totalCount} 개 &nbsp; | &nbsp; ${ mapVO.page } &nbsp; / &nbsp; ${list.totalPage} 페이지</p>
						</div>
						<div class="col-12">
						<table border="1" id="mapListtable">
							<tr>
								<th><h3>번호</h3></th>
								<th><h3>상호명</h3></th>
								<th><h3>주소</h3></th>
							</tr>
							
							<c:forEach items="${list.list}" var="maplist" varStatus="status">
								<tr>
									<td>${list.totalCount-status.index-(mapVO.page-1)*mapVO.pageRow }</td>
									<td>${maplist.name }</td>
									<td>${maplist.address }</td>
								</tr>
							</c:forEach>
							
						</table>
						</div>
						<div id="mapBtn">
							<input type="button" id="map" value="지도보기">
						</div>
						<!-- 페이징 처리 -->
						<div class="col-12">
							<div class="paging">
		                        <ul>
			                        <c:if test="${list.prev == true }">
			                        	<li><a href="mapList.do?page=${list.startPage }&stype=${param.stype}&sword=${param.sword}"><</a></li>
			                        </c:if>
			                        <c:forEach var="p" begin="${list.startPage }" end="${list.endPage }">
			                            <li><a href='mapList.do?page=${p }&stype=${param.stype}&sword=${param.sword}' <c:if test="${mapVO.page == p }">class='current'</c:if>>${p }</a></li>
			                        </c:forEach>
			                        <c:if test="${list.next == true }">
			                        	<li><a href="mapList.do?page=${list.endPage+1 }&stype=${param.stype}&sword=${param.sword}">></a>
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