<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</head>
<body>
<div id="map" style="width:800px;height:400px;"></div>

<script type="text/javascript">
var pxpy; 
var px
var py; 
var jibunAddress;
var roadAddress;
var no; 
var title;



var map = new naver.maps.Map("map", {
	  center: new naver.maps.LatLng(37.5665187, 126.978467),
	  zoom: 15,
	  mapTypeControl: true
	});

	var infoWindow = new naver.maps.InfoWindow({
	  anchorSkew: true
	});

	map.setCursor('pointer');

	function searchCoordinateToAddress(latlng) {

	  infoWindow.close();

	  naver.maps.Service.reverseGeocode({
	    coords: latlng,
	    orders: [
	      naver.maps.Service.OrderType.ADDR,
	      naver.maps.Service.OrderType.ROAD_ADDR
	    ].join(',')
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!latlng) {
	        return alert('ReverseGeocode Error, Please check latlng');
	      }
	      if (latlng.toString) {
	        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
	      }
	      if (latlng.x && latlng.y) {
	        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
	      }
	      return alert('ReverseGeocode Error, Please check latlng');
	    }

	    var address = response.v2.address,
	        htmlAddresses = [];

	    if (address.jibunAddress !== '') {
	        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
	    }

	    if (address.roadAddress !== '') {
	        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
	    }
		
	    pxpy = latlng;
	    jibunAddress = address.jibunAddress;
	    roadAddress = address.roadAddress;
	    
	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	      '<h4> 여기니? </h4>',
	      htmlAddresses.join('<br />'),
	      '<input type="button" value="작성" onclick="addmap()">',
	      '</div>'
	    ].join('\n'));
	    infoWindow.open(map, latlng);
	  });
	}

	function searchAddressToCoordinate(address) {
	  naver.maps.Service.geocode({
	    query: address
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!address) {
	        return alert('Geocode Error, Please check address');
	      }
	      return alert('Geocode Error, address:' + address);
	    }

	    if (response.v2.meta.totalCount === 0) {
	      return alert('No result.');
	    }

	    var htmlAddresses = [],
	      item = response.v2.addresses[0],
	      point = new naver.maps.Point(item.x, item.y);

	    if (item.roadAddress) {
	      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	    }

	    if (item.jibunAddress) {
	      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	    }

	    if (item.englishAddress) {
	      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	    }
	    
	    px = item.x;
	    py = item.y;
	    
	    jibunAddress = item.jibunAddress;
	    roadAddress = item.roadAddress;
	    

	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
	      '<h4> 여기니?2 ',
	      title,
	      '</h4>',
	      htmlAddresses.join('<br />'),
	      '<input type="button" value="작성" onclick="addmap('+px+','+py+','+'\''+roadAddress+'\',\''+title+'\')">',
	      '</div>'
	    ].join('\n'));
	    
		console.log("pxpy : " + pxpy);
		
	    map.setCenter(point);
	    infoWindow.open(map, point);
	  });
	}

	
	function initGeocoder() {
	  map.addListener('click', function(e) {
	    searchCoordinateToAddress(e.coord);
	  });

	  $('#address').on('keydown', function(e) {
		  console.log("address");
	    var keyCode = e.which;

	    if (keyCode === 13) { // Enter Key
	      searchAddressToCoordinate($('#address').val());
	    }
	  });
	  
	  
		$('#mapListDiv #mapList').on('click', function(e) {
			var address = $(this).find('#address').val();
			title = $(this).find('#title').text();
			console.log("addr : "+ address);
			console.log("title : "+ title);
		    e.preventDefault();
		    searchAddressToCoordinate(address);
		});
 
	}
	
	naver.maps.onJSContentLoaded = initGeocoder;
	
	
	function addmap(px,py,roadAddress,title) {
		/* console.log("latlng : " + px + " : " + py); 
		console.log("jibunAddress : " + jibunAddress);
		console.log("roadAddress 이걸 등록: " + roadAddress);
		console.log("title : " + title); */
		$.ajax ({
			method : 'get',
			url : 'checkMap.do',
			data : {
				px : px,
				py : py,
				name : title
			},
			dataType : 'json',
			success: function (data) {
				if (data == 0){
	 	        	alert("작성 가능합니다.");
	 	        	location.href = '/longd/map/newWrite.do?px='+px+'&py='+py+'&roadAddress='+roadAddress+'&title='+title;
				} else {
					alert("이미 존재 합니다.");
				}
 	        },
 	        error: function (xhr, desc, err) { 
 	            alert('에러가 발생 하였습니다.');
 	            console.log(err);
 	            return;
 	        }
		})
		
	}
	
</script>
	<div id="map" style="width:100%;height:600px;">
        <div class="search" style="">
	        <form action="searchMap.do" method="get">
	        	<!-- <input id="address" type="text" placeholder="검색할 주소" value="불정로 6" /> 
	        		<input id="submit" type="button" value="주소 검색" />
	        	-->
	            <input name="sword" type="text" placeholder="검색할 주소"  />
				<input type="submit" value="주소 검색" />
			</form>

           	<div id="mapListDiv">
	            <c:forEach items="${search}" var="map" varStatus="status">
	            	<div id="mapList">
			    		<p>
			    			업체명 : <span id="title">${map.title}</span>
			    			주소 : ${map.address}
			    			<!-- ${status.index} -->
			    			<button id="submit" type="button" >선택</button>
			    			<input type="hidden" id="address" value="${map.address}">
			    		</p> 
			    		<p><input type="hidden" value="${map.roadAddress}"></p>
			    		<p><input type="hidden" value="${map.mapx}"></p>
			    		<p><input type="hidden" value="${map.mapy}"></p>
		    		</div>
	    		</c:forEach>
    		</div>
    		
        </div>
    </div>
</body>
</html>