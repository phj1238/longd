<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file ="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/longd/css/main.css" rel="stylesheet" type="text/css" />

<title>그룹 만들기</title>

<script>
var nickArr = new Array();
var realArr = new Array();
var nickNo = 0;

$(function () {
	var main = $("#home");
	main.removeClass("active");
	
	var page = $("#mygroupPage");
	page.addClass("active");
	
	
		/* 
		$.ajax({
			url : 'insertgroup.do',
			method : 'post',
			data : {
				nick : insertNick
			},
			dataType : 'json',
			success : function () {
				
			}, error: function (xhr, desc, err) {
				alert('에러가 발생');
				console.log(err);
				return; 
	        }
		}) 
		*/
		
})

function goGroupcheck() {
	var group_name = $('#group_name').val();
	
	if (group_name.trim() == ''){
		alert("그룹 이름을 작성 해주세요");
		$('#group_name').focus();
		return;
	}
	
	$.ajax ({
		url : 'checkgroup.do',
		data : {
			group_name : group_name
		},
		method : 'post',
		dataType : 'json',
		success : function (data) {
			console.log(data);
			if (data == 0){
				$(".checkgroup").text(group_name+" 는 사용 가능한 이름 입니다.");
			}else {
				$(".checkgroup").text(group_name+" 는 중복된 이름 입니다.");
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	})
}

function searchMember() {
	var nick = $('#nick').val();
	
	if (nick.trim() == ''){
		alert("닉네임을 작성 해주세요");
		$('#nick').focus();
		return;
	}
	
	$.ajax ({
		url : 'searchMember.do',
		method : 'post',
		data : {
			nick : nick
		},
		dataType : 'json',
		success : function (data) {
			console.log(data);
			if (data == 1){
				var html = '<div class="member'+nickNo+'">';  
					html += '	<span class="membernick">'+nick+'</span>';
					html += '	<input type="hidden" class="nickname" name="nick" value="'+nick+'">';
					html += '	<a href="javascript:;" onclick="deleteNick('+nickNo+')" class="xMember'+nickNo+'"><img id="'+nick+'"class="xImg" src="/longd/img/X.png"></a>';
					html += '</div>';
				$(".memberlist").append(html);
				nickNo++;
				nickArr.push(nick);
				
			}else {
				alert(nick+" 는 없는 닉네임 입니다");
			}
		}, error: function (xhr, desc, err) {
            alert('에러가 발생');
            console.log(err);
            return; 
        }
	})
}

function deleteNick(nickNo) {
	document.querySelector(".member" + nickNo).remove();
}

</script>

</head>


<body>
<!-- Wrapper-->
			<!-- Main -->
				<!-- Contact -->
				<article id="contact" class="panel">
					<header>
						<h2>그룹 만들기</h2>
					</header>
					<div> 
						<form action="insertgroup.do" method="post">
						<div class="row">
							<div class="col-12 join">
								<div class="id">
									<span>그룹 이름</span>
									<div></div>
									<input class="groupTextbox" type="text" name="group_name" id="group_name" placeholder="그룹이름" />
									<input type="button" onclick="goGroupcheck()" value="그룹 이름 중복확인">
								</div>
							</div>
							<div class="col-12 join">
								<span class="checkgroup"></span>
							</div>
							<div class="col-12 join">
								<div class="nick">
									<span>그룹 인원</span>
									<div></div>
									<input class="groupTextbox" type="text" id="nick" placeholder="닉네임" />
									<input type="button" onclick="searchMember()" value="닉네임 검색">
								</div>
							</div>
							<div class="col-12">
								<div class="memberlist"></div>
							</div>
							<div class="col-12">								
								<div class="col-12">
									<input type="submit" value="완료" id="submitBtn"/>
								</div>
							</div>
						</div>
						</form>
					</div>
				</article>
			</div>
		</div>
</body>
</html>