<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>간단한 지도 표시하기</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(function () {
	var main = $("#home");
	main.removeClass("active");
	
	var page = $("#mapPage");
	page.addClass("active");
	
	$("#mapList").on('click', function () {
		location.href = '/longd/map/mapList.do';
	})
	
	$("#maptotal").on('click', function () {
		location.href = '/longd/map/maptotal.do';
	})
})
</script> 

</head>
			<article id="work" class="panel" style="backgrond">
				<header>
					<h2> 발 자 취 </h2>
				</header>
				<div id="map" style="width:800px;height:400px;"></div>
				
				<div class="col-12" id="maplistBtn">
					<input type="button" id="mapList" value="목록보기" />
					<input type="button" class="maptotal" id="maptotal" value="통계">
				</div>
			</article>
		</div>
	</div>

<script type="text/javascript">
    
    var HOME_PATH = "<%=request.getContextPath()%>";
	var maplist = new Array();
	var filelist = new Array();
	var imgsrc = '<%=request.getContextPath()%>';
	var contentimg = '';
	
	maplist.push(											/* lat 위도			lng 경도 */
		<c:forEach items="${list.list}" var="vo">
			{ 
				map_no : ${vo.map_no} 
				, name : '${vo.name}'
				, lat : ${vo.py}
				, lng : ${vo.px}
				, content : '${vo.content}' 
				, marker : '${vo.marker}'
			},
		</c:forEach>	
	) 
			
	 
	filelist.push(
		<c:forEach items="${list.filelist}" var="filelist"> 
			{ filename_real : '${filelist.filename_real}' , map_no : ${filelist.map_no} } ,
		</c:forEach>
	)
   	
	var map = new naver.maps.Map('map', {
   	    center: new naver.maps.LatLng(37.595127, 127.0780643),
   	    zoom: 7
   	});
   	
		var bounds = map.getBounds(),
		    southWest = bounds.getSW(),
		    northEast = bounds.getNE(),
		    lngSpan = northEast.lng(),
		    latSpan = northEast.lat();
    
   	// 마커 배열로 
   	var markers = [],
       	infoWindows = [];
   	
    for (var i=0; i<maplist.length; i++) {
    	var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(maplist[i].lat, maplist[i].lng ),
            title: maplist[i].name,
	    	icon: {
	            url: HOME_PATH +'/img/'+maplist[i].marker,
	            size: new naver.maps.Size(27, 30),
	            scaledSize: new naver.maps.Size(27, 30),
	            origin: new naver.maps.Point(0, 0),
	            anchor: new naver.maps.Point(13, 30)
	    	},
	        zIndex: 100
    	});
    	
    	if (maplist[i].content == '') {
			var infoWindow = new naver.maps.InfoWindow({
				content : '<div class="contentDiv">'
					+ '	<p class="name">'+ maplist[i].name +'</p>'
					+ ' <p> 등록 된 글이 없습니다.</p>'
					+ '	<button class="writeBtn" onclick="writeContent('+maplist[i].map_no+')">글작성</button>'
					+ '</div>',
				borderColor: "#2db400"
			});
    	
    	}
    	else {
    		var contentString = '';
    		contentString += '<div class="contentDiv">';
   			contentString += '	<p class="name">'+ maplist[i].name +'</p>';
   			contentString += '	<p class="content">'+ maplist[i].content +'</p>';
   			contentString += '	<div class="contentfile">';
   			
   			addfile(maplist[i].map_no);
   			
    		function addfile(map_no) {
    			for (var j = 0; j<filelist.length; j++){
	    			if (filelist[j].map_no == map_no) {
	    				contentString += '<img class="contentImg" src="'+imgsrc+'/upload/'+filelist[j].filename_real+'">';
					}
    			}
    		}
   			contentString += '</div>';
    		contentString += '	<button class="writeBtn" onclick="editContent('+maplist[i].map_no+')">수정</button>'
   			contentString += '</div>';
    		
    		var infoWindow = new naver.maps.InfoWindow({
    			content : contentString,
				borderColor: "#2db400"
    		});
    	}
    	
		markers.push(marker);
		infoWindows.push(infoWindow); 
		
    };
	
	
    naver.maps.Event.addListener(map, 'idle', function() {
        updateMarkers(map, markers);
    });
	
	
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