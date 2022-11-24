<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>글 수정 페이지</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<style>
</style>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function () {
	var main = $("#home");
	main.removeClass("active");
	 
	var page = $("#writePage");
	page.addClass("active");
})
</script>


<script>
</script>



	
</head>
	<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<header>
						<h2>지도 집계??</h2>
					</header>
						<div>
							<!-- row 시작 -->
							<div class="row">
							<h3>총 발자취 수</h3>
							<h3>${dlist.totalcount}</h3>
								<div class="col-12">
									<table border="1">
										<tr>
											<c:forEach var="list" items="${dislist}"  varStatus="status">
												<th> ${list.district_county}</th>
												<th> ${list.district_no}</th>
											</c:forEach>
										</tr>
										<tr>
											<td>${dlist.dlist_1}</td>
											<td>${dlist.dlist_2}</td>
											<td>${dlist.dlist_3}</td>
											<td>${dlist.dlist_4}</td>
											<td>${dlist.dlist_5}</td>
											<td>${dlist.dlist_6}</td>
											<td>${dlist.dlist_7}</td>
											<td>${dlist.dlist_8}</td>
											<td>${dlist.dlist_9}</td>
											<td>${dlist.dlist_10}</td>
											<td>${dlist.dlist_11}</td>
											<td>${dlist.dlist_12}</td>
											<td>${dlist.dlist_13}</td>
											<td>${dlist.dlist_14}</td>
											<td>${dlist.dlist_15}</td>
											<td>${dlist.dlist_16}</td>
											<td>${dlist.dlist_17}</td>
										</tr>
									</table>
								</div>
								<div class="col-12">
									<input type="submit"  onclick="filecheck();" value="수정완료" />
								</div>
							</div>
							<!-- row 끝 -->
						</div>
				</article>
			</div>
		</div>
</body>
</html>