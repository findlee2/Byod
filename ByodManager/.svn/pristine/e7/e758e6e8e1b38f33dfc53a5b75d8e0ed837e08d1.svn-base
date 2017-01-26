<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function(){

	/** 이벤트 정의 */
	$('#passWordChange').click(function(){
		passWordChange();
	});
	
	$('#layer-close').click(function(){
		$('.consRcvIn').fadeOut(200);
		$('.layer-cover').fadeOut(300);
	});
	
	var vHtml = '';
	$("#topDiv").empty();
	
	if("${userVO}" != null){		
		
		vHtml += "<span>${userVO.user_nm}님</span>&nbsp;&nbsp;";
		vHtml += "<a onclick='byodLogout()' style='cursor:pointer'>로그아웃</a>&nbsp;";
		vHtml += "<a onclick='byodPasswdChange()' style='cursor:pointer'>비밀번호변경</a>";
		
	}else{
		vHtml += "<a href='#link'>로그인</a>";
	}
	
	$("#topDiv").html(vHtml);
});

function byodLogout(){
	
	$.ajax({
		  type:"POST",
		  url: 'http://10.0.6.23:8007/Byod/userWLoginOut',		        
		  data : 'userId=${userVO.user_id}&userNm=${userVO.user_nm}',		  
		  dataType	: "text",	
		  crossOrigin: true,
		  cache : false,
		  success : onSuccessLogout,
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });
}

function onSuccessLogout(){
	$("#tmp").submit();
}

//비밀번호 레이어 출력
function byodPasswdChange(){
	
	$("#userOldPw").val('');
	$("#userNewPw").val('');
	
	$('.consRcvIn').fadeIn(300).find('#counselTitle').text("비밀번호변경");		
	$('.layer-cover').fadeIn(200);
}

//비밀번호 변경
function passWordChange(){
	
	var vParm = ''; 
	
	if($("#userOldPw").val() == '' || $("#userNewPw").val() == ''){
		alert("비밀번호를 입력하세요.")
		return false;
	}else{
		
		vParm += "userId=${userVO.user_id}";
		vParm += "&userOldPw="+$("#userOldPw").val();
		vParm += "&userNewPw="+$("#userNewPw").val();
		
		$.ajax({
			  type:"PUT",
			  url: 'http://10.0.6.23:8007/Byod/srchUserPassWordUpdate',		        
			  data : vParm,		  
			  dataType	: "text",	
			  crossOrigin: true,
			  cache : false,
			  success: function(data) {			  
				  	alert("비밀번호가 변경되었습니다.");			  	
					$('.consRcvIn').fadeOut(200);
					$('.layer-cover').fadeOut(300);			  	
			  },
			  error : function(request, status, error) {
				  if (request.status == '400') {
				    	alert("기존 비밀번호가 옳바르지 않습니다.\n"
				    			+"다시 시도하여 주세요.")
					}else{
						alert("code : " + request.status + "\r\nmessage : "
					    + request.reponseText + "\r\nerror : " + error);
					}
			  }
		  });
	}
}

</script>
<form id="tmp" action="/logout" method="post"></form>
<div id="header">
	<h1><a href="<c:url value='/srchInfo/srchInfoList'/>"><img src="<c:url value='/images/byod-mi.png' />" alt="BYOD 현장조사 업무지원 시스템 MI" /></a></h1>
	<div id="topDiv">
		<!-- <a href="#link">로그인</a>
		<a href="#link">회원가입</a> -->
	</div>
</div>
<div id="nav">
	<a href="<c:url value='/srchInfo/srchInfoList'/>">업무관리</a>
	<a href="<c:url value='/userInfo/userInfoList'/>">사용자관리</a>
	<a href="<c:url value='/srchEqupmnt/srchEqupmntList'/>">단말기관리</a>
	<a href="<c:url value='/logInfo/logInfoList'/>">로그관리</a>
</div>
<article class="consAppDetail">	
	<div id="layer-popup" class="consRcvIn">
		<h4 id="counselTitle" class="title"></h4>
		<p class="layerExp">/ BYOD 현장 조사 업무지원 시스템의 사용자 비밀번호 변경을 할때에는 기존비밀번호를 아셔야합니다.</p>
		<ul class="addExp">
			<li style="color: red;">승인된 계정의 비밀번호는 숫자'1'이고 로그인 후에 변경하실 수 있습니다.</li>												
		</ul>
		<table class="cm-tb-form2 tb-bdr-top1">
			<caption>비밀번호변경</caption>
			<colgroup>
				<col width="18%" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">기존 비밀번호</th>
				<td>
					<input type="text" id="userOldPw" maxlength="30" size="30" />
				</td>
			</tr>
			<tr>
				<th scope="row">신규 비밀번호</th>
				<td>
					<input type="password" id="userNewPw" maxlength="30" size="30" />
				</td>
			</tr>
		</table>
		<div class="buttonDiv">
			<a id="passWordChange" class="btnType01 orb-button">변경</a>
			<a id="layer-close" class="btnType01 lgb-button">닫기</a>
		</div>
	</div>
</article>