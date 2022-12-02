<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>지도 집계</title>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
var mapdata = new Array();
var mapfile = new Array();

$(function () {
	var trRow;
	var address;
	var main = $("#home");
	main.removeClass("active");
	 
	var page = $("#mapPage");
	page.addClass("active");
	
	document.getElementById("map").style.display = "none";
	
	$(".countymapBtn").on('click',function () {
		trRow = $(this).parent().parent();
		address = trRow.children().eq(0).text();
		console.log("county : " + address);
		
		$.ajax ({
			url : 'countymap.do',
			method : 'post',
			data : {
				address : address
			},
			dataType : 'json',
			success : function (data) {
				document.getElementById("map").style.display = "block";
				naverMap(data);
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
		
	})
	
	$('.countylistBtn').on('click', function () {
		trRow = $(this).parent().parent();
		address = trRow.children().eq(0).text();
		console.log("county : " + address);
		
		if($("#countymaplist").length  > 0 ){
			document.querySelector("#countymaplist").remove();
		}
		
		$.ajax ({
			url : 'countymap.do',
			method : 'post',
			data : {
				address : address
			},
			dataType : 'json',
			success : function (data) {
				if (data.list.list.length !== 0 ){
					mapdata.length = 0;
					mapfile.length = 0;
					
					var html = '';
						html += '<div id="countymaplist">';
						html += '	<table id="countymaplistTable">';
						html += '		<tr>';
						html += '			<th>상호명</th>';
						html += '			<th>날짜</th>';
						html += '			<th>내용</th>';
						html += '		</tr>';
					for(var i = 0; i < data.list.list.length; i++){
						
						mapdata.push(data.list.list[i]);
						mapfile.push(data.list.filelist[i]);
						
						html += '		<tr>';
						html += '			<td><a onclick="changeMap('+i+');">'+data.list.list[i].name+'</a></td>';
						html += '			<td>'+data.list.list[i].creationtime+'</td>';
						if (data.list.list[i].content != null) {
							html += '		<td> <a href="/longd/map/view.do?map_no='+data.list.list[i].map_no+'">'+data.list.list[i].content+'</a></td>';
						}else {
							html += '		<td> </td>';
						}
						html += '		</tr>';
					}
						html += '	</table>';
						html += '</div>';
						$(trRow).after(html);
				} else {
					alert('목록이 없습니다.');
				}
			}, error: function (xhr, desc, err) {
	            alert('에러가 발생');
	            console.log(err);
	            return; 
	        }
		})
	})
})

function goMap() {
	window.history.back();
}

function changeMap(no) {
	
	var no = no;
	var list = mapdata[no];
	var flist = mapfile[no];
	
	console.log(list);
	console.log(flist);
	
	document.getElementById("map").style.display = "block";
	
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(list.py, list.px),
	    zoom: 18
	});
	
	var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(list.py, list.px ),
        map: map,
        title: list.name,
    	icon: {
            url: '/longd/img/marker2.png',
            size: new naver.maps.Size(200, 300),
            scaledSize: new naver.maps.Size(27, 30),
            origin: new naver.maps.Point(0, 0),
            anchor: new naver.maps.Point(13, 30)
    	},
    	 zIndex: 1000
	});
	
	if (list.content == '' || list.content == null ) {
		console.log("null");
		var infoWindow = new naver.maps.InfoWindow({
			content : '<div class="contentDiv">'
					+ '	<p class="name">'+ list.name +'</p>'
					+ ' <p> 등록 된 글이 없습니다.</p>'
					+ '	<button class="writeBtn" onclick="writeContent('+list.map_no+')">글작성</button>'
					+ '</div>',
			borderColor: "#2db400"
		});
	}
	else {
		console.log("!null");
		var contentString = '';
			contentString += '<div class="contentDiv">';
			contentString += '	<p class="name">'+ list.name +'</p>';
			contentString += '	<p class="content">'+ list.content +'</p>';
			contentString += '	<div class="contentfile">';
			
			addfile(list.map_no);
			
		function addfile(map_no) {
			for (var j = 0; j< flist.lenght; j++){
    			if (flist[j].map_no == map_no) {
    				contentString += '<img class="contentImg" src="'+imgsrc+'/upload/'+flist[j].filename_real+'">';
				}
			}
		}
			contentString += '	</div>';
			contentString += '	<button class="writeBtn" onclick="editContent('+list.map_no+')">수정</button>'
			contentString += '</div>';
		
		var infoWindow = new naver.maps.InfoWindow({
			content : contentString,
			borderColor: "#2db400"
		});
		 
	}
	
	naver.maps.Event.addListener(marker, "click", function(e) {
	    if (infoWindow.getMap()) {
	    	infoWindow.close();
	    } else {
	    	infoWindow.open(map, marker);
	    }
	});
	
}
</script>

<style type="text/css">

</style>
</head>
	<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<header>
						<h2>통계</h2>
					</header>
						<div>
							<!-- row 시작 -->
							<div>
								<div id="map" style="width:800px;height:300px;background: #aaa; "></div>
							</div>
							
							<div class="row">
								<div class="col-12">
									<div id="totlacount">
										<h3><span>총 발자취 수 ${dlist.totalcount}</span></h3>
									</div>
								</div>
								<div class="col-12">
								</div>
								<div class="col-12">
									<table border="1" class="maptable" id="maptable">
										<tr>
											<th>지역</th>
											<th>횟수</th>
											<th></th>
										</tr>
										<c:forEach var="list" items="${dislist}" varStatus="status">
											<tr class="mapTr">
												<td class="county">${list.district_county2}</td>
												<c:if test="${list.district_county2  eq '강원'}">
													<td class="total">${dlist.dlist_1}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '경기'}">
													<td class="total">${dlist.dlist_2}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '경남'}">
													<td class="total">${dlist.dlist_3}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '경북'}">
													<td class="total">${dlist.dlist_4}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '광주'}">
													<td class="total">${dlist.dlist_5}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '대구'}">
													<td class="total">${dlist.dlist_6}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '대전'}">
													<td class="total">${dlist.dlist_7}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '부산'}">
													<td class="total">${dlist.dlist_8}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '서울'}">
													<td class="total">${dlist.dlist_9}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '인천'}">
													<td class="total">${dlist.dlist_10}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '세종'}">
													<td class="total">${dlist.dlist_11}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '울산'}">
													<td class="total">${dlist.dlist_12}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '전남'}">
													<td class="total">${dlist.dlist_13}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '전북'}">
													<td class="total">${dlist.dlist_14}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '제주'}">
													<td class="total">${dlist.dlist_15}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '충남'}">
													<td class="total">${dlist.dlist_16}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
												<c:if test="${list.district_county2  eq '충북'}">
													<td class="total">${dlist.dlist_17}</td>
													<td>
														<input type="button" class="countymapBtn" value="지도보기">
														<input type="button" class="countylistBtn" value="목록보기">
													</td>
												</c:if>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div class="col-12">
									<input type="button"  onclick="goMap();" value="지도보기" />
								</div>
							</div>
							<!-- row 끝 -->
						</div>
				</article>
			</div>
		</div>
		
<script type="text/javascript">
//마커 배열로 
var markers = [],
infoWindows = [];

	function naverMap(list) {
		
		var HOME_PATH = "<%=request.getContextPath()%>";
		var imgsrc = '<%=request.getContextPath()%>';
		var contentimg = '';
		
		
		var mlist = list.list.list; 
		var flist = list.list.filelist;
		
		if(mlist.length !== 0) {
			
			var map = new naver.maps.Map('map', {
				    center: new naver.maps.LatLng(mlist[0].py, mlist[0].px),
				    zoom: 12
			});
				
			var bounds = map.getBounds(),
			    southWest = bounds.getSW(),
			    northEast = bounds.getNE(),
			    lngSpan = northEast.lng(),
			    latSpan = northEast.lat();
			
			for (var i=0; i<mlist.length; i++) {
					var marker = new naver.maps.Marker({
				        position: new naver.maps.LatLng(mlist[i].py, mlist[i].px ),
				        map: map,
				        title: mlist[i].name,
				    	icon: {
				            url: '/longd/img/marker2.png',
				            size: new naver.maps.Size(200, 300),
				            scaledSize: new naver.maps.Size(27, 30),
				            origin: new naver.maps.Point(0, 0),
				            anchor: new naver.maps.Point(13, 30)
				    	},
				    	 zIndex: 1000
					});
					
					if (mlist[i].content == '' || mlist[i].content == null ) {
						var infoWindow = new naver.maps.InfoWindow({
							content : '<div class="contentDiv">'
									+ '	<p class="name">'+ mlist[i].name +'</p>'
									+ ' <p> 등록 된 글이 없습니다.</p>'
									+ '	<button class="writeBtn" onclick="writeContent('+mlist[i].map_no+')">글작성</button>'
									+ '</div>',
							borderColor: "#2db400"
						});
					}
					else {
						var contentString = '';
							contentString += '<div class="contentDiv">';
							contentString += '	<p class="name">'+ mlist[i].name +'</p>';
							contentString += '	<p class="content">'+ mlist[i].content +'</p>';
							contentString += '	<div class="contentfile">';
							
							addfile(mlist[i].map_no);
							
						function addfile(map_no) {
							for (var j = 0; j< flist.lenght; j++){
				    			if (flist[j].map_no == map_no) {
				    				contentString += '<img class="contentImg" src="'+imgsrc+'/upload/'+flist[j].filename_real+'">';
								}
							}
						}
							contentString += '	</div>';
							contentString += '	<button class="writeBtn" onclick="editContent('+mlist[i].map_no+')">수정</button>'
							contentString += '</div>';
						
						var infoWindow = new naver.maps.InfoWindow({
							content : contentString,
							borderColor: "#2db400"
						});
						 
					}
					markers.push(marker);
					infoWindows.push(infoWindow);
				}
			
			}else {
				alert("목록이 없습니다.");
			}	
		
	
		 naver.maps.Event.addListener(map, 'idle', function() {
			updateMarkers(map, markers);
	    })
		    
	    function updateMarkers(map, markers) {
	
		    var mapBounds = map.getBounds();
		    var marker, position;
	
		    for (var i = 0; i < markers.length; i++) {
	
		        marker = markers[i];
		        position = marker.getPosition();
	
		        if (mapBounds.hasLatLng(position)) {
		            showMarker(map, marker);
		        } else {
		            hideMarker(map, marker);
		        }
		    }
		}
		 
	    
		function showMarker(map, marker) {
		    if (marker.setMap()) return;
		    marker.setMap(map);
		}	
		
		function hideMarker(map, marker) {
		    if (!marker.setMap()) return;
		    marker.setMap(null);
		}
	
		// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
		function getClickHandler(seq) {
		    return function(e) {
		        var marker = markers[seq],
		            infoWindow = infoWindows[seq];
	
		        if (infoWindow.getMap()) {
		            infoWindow.close();
		        } else {
		            infoWindow.open(map, marker);
		           /* 
		            for (data in infoWindow){
		                console.log("값: "+JSON.stringify(data))
		    		}
		             */
		            //console.log("클릭 : "+ marker);
		        }
		    }
		}
	
		for (var i=0, ii=markers.length; i<ii; i++) {
		    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		    
		}
	
	}  //// --- 끝
	
	
	function writeContent(mapno) {
		console.log(mapno);
		location.href = '/longd/map/write.do?map_no='+mapno;
	}
	
	function editContent(mapno) {
		console.log(mapno);
		location.href = '/longd/map/edit.do?map_no='+mapno;
	}
	
	
</script>


</body>
</html>