<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>BYOD 현장조사 업무지원 시스템</title>
<link href="<c:url value='/css/reset.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/byod.css'/>" rel="stylesheet" type="text/css">
<script src="/webjars/jquery/2.2.1/jquery.min.js"></script> 
<style type="text/css">
/**
	임시 스타일 적용(차후 최루토가 보완해줄것을 예상하며)
*/
.membLoginWrap {margin-top:50px;margin-bottom:30px;overflow:hidden;}
.membLoginWrap h2 {display:inline-block;font:bold 32px 'Nanum Gothic',sans-serif;color:#333;margin-bottom:5px;}
.membLoginWrap p {display:inline-block;font:normal 11px 'Dotum', sans-serif;color:#999;}
.membLoginWrap .membLogin {position:relative;width:100%;margin-top:10px;}
.membLoginWrap .membLogin>div {position:relative;width:445px;padding:0;margin:40px auto;}
.membLoginWrap .membLogin>div label {display:inline-block;width:70px;font:bold 14px 'Nanum Gothic',sans-serif; color:#585858;vertical-align:middle;margin-right:5px;}
.membLoginWrap .membLogin>div input {margin-bottom:2px;}
.membLoginWrap .membLogin>div .loginInput {width:265px;height:38px;padding-left:5px;border:1px solid #ccc;box-sizing:border-box;}
.membLoginWrap .membLogin>div .loginBtn {
	position:absolute;top:0;right:0;
	width:93px;height:78px;
	font:bold 18px 'Nanum Gothic', sans-serif;color:#fff;line-height:79px;text-decoration:none;text-align:center;
	border:none;
	background-color:#6e6e6e;
}
.membLoginWrap .membLogin>div .idSave {display:block;padding:0;margin:5px 0 0 77px;}
.membLoginWrap .membLogin>div .idSave label {font:normal 12px 'Nanum Gothic',sans-serif;color:#666;vertical-align:middle;padding:0;margin:0;cursor:pointer;}
.membLoginWrap .membLogin>div .idSave input {border:1px solid #ddd;vertical-align:middle;}
.membLoginWrap .membLogin>ul {width:100%;background-color:#fff;border-top:1px solid #ddd;list-style:none;}
.membLoginWrap .membLogin>ul>li {position:relative;display:table-cell;width:600px;height:140px;padding-left:220px;box-sizing:border-none;}
.membLoginWrap .membLogin>ul>li:first-child {background:url('../images/content/memb.guide.line.png') no-repeat right center;}
.membLoginWrap .membLogin>ul>li span {position:absolute;display:block;top:30px;left:120px;width:81px;height:81px;}
.membLoginWrap .membLogin>ul>li p {font:normal 12px 'Dotum',sans-serif;color:#999;margin-top:50px;}
.membLoginWrap .membLogin>ul>li a {display:block;font:bold 14px 'Nanum Gothic',sans-serif;color:#333;text-decoration:none;margin-top:5px;}

</style>

<script>
$(document).ready(function(){
	
	/** 이벤트 정의 */
	
	//로그인
    $(".loginBtn").click(function(){
        loginAction();
    });
	
	//아이디 중복체크
    $("#idCheck").click(function(){
        idCheckAction();
    });
    
  	//회원가입
    $("#registMember").click(function(){
    	registMemberAction();
    });
	
    /* 회원가입 레이어팝업 */
	var layerPop = $('.consRcvIn');
	var layerCov = $('.layer-cover');
	$('#tb-member-btn').click(function(){
		layerPop.fadeIn(300).find('#counselTitle').text("회원가입");		
		layerCov.fadeIn(200);
		
		$('#layer-close').click(function(){
			layerPop.fadeOut(200);
			layerCov.fadeOut(300);
		});
	});
});
	
var dupCheck = false;

//로그인 요청
function loginAction(){
	
	$.ajax({
		  type:"GET",
		  url: 'http://10.0.6.23:8007/Byod/userWLoginInfo',
		  data : $("#loginForm").serialize(),		  
		  dataType	: "json",		  
		  cache : false,
          success : onSuccess,		 
		  error : function(request, status, error) {
			    if (request.status == '400') {
			    	alert("로그인 정보가 옳바르지 않습니다.\n"
			    			+"다시 시도하여 주세요.")
				}else{
					alert("code : " + request.status + "\r\nmessage : "
				    + request.reponseText + "\r\nerror : " + error);
				}
		  }
	  });
}

//로그인 성공시 업무관리 페이지 요청
function onSuccess(data, status, xhr){
	
	//session 객체를 만들기 위한 데이터 세팅
	$("#user_id").val(data.user_id);
	$("#user_nm").val(data.user_nm);
	$("#user_appve_yn").val(data.user_appve_yn);
	$("#user_role").val(data.user_role);
	$("#user_otg_no").val(data.user_otg_no);
	
	$("#SessionForm").submit();
}

//중복아이디 체크
function idCheckAction(){
	
	if($("#memberId").val() == ''){
		alert("아이디를 입력하세요.");
		return false;
	}
	
	$.ajax({
		  type:"GET",
		  url: 'http://10.0.6.23:8007/Byod/adminUserRegMemberDuplCheck',
		  data : "userId="+$("#memberId").val(),		  
		  dataType	: "text",		  
		  cache : false,
		  success: function(data) {
			  	$("#idRtn").text("사용 가능한 아이디 입니다.");
			  	dupCheck = true;
		  },		 
		  error : function(request, status, error) {
			     if (request.status == '409') {
			    	$("#idRtn").text("해당 아이디는 사용 중입니다.");
				}else{
					alert("code : " + request.status + "\r\nmessage : "
				    + request.reponseText + "\r\nerror : " + error);
				}
			    dupCheck = false;
		  }
	  });
}

//회원가입
function registMemberAction(){
	
	var vParm = ''; 
	
	if(!dupCheck){
		alert("아이디 중복체크를 하셔야 합니다.");
		return false;
	}else if($("#memberName").val() == ''){
		alert("이름을 입력하셔야 합니다.");
		return false;
	}else{
		
		vParm += "userId="+$("#memberId").val();
		vParm += "&userNm="+$("#memberName").val();
		
		$.ajax({
			  type:"POST",
			  url: 'http://10.0.6.23:8007/Byod/userRegist',
			  data : vParm,		  
			  dataType	: "json",		  
			  cache : false,
			  success: function(data) {
				  
				  	alert(data.user_nm + "님의 회원가입이 성공적으로 이루어 졌습니다.\n"
				  			+ "관리자의 승인 후 사용하실 수 있습니다.");
				  	
					$('.consRcvIn').fadeOut(200);
					$('.layer-cover').fadeOut(300);
				  	
			  },		 
			  error : function(request, status, error) {
				     if (request.status == '409') {
				    	$("#idRtn").text("해당 아이디는 사용 중입니다.");
					}else{
						alert("code : " + request.status + "\r\nmessage : "
					    + request.reponseText + "\r\nerror : " + error);
					}
			  }
		  });
	}
	
	
	
	
}

</script>
</head>
<body>
<div id="byod-wrap">
	<div id="header">
		<h1><img src="<c:url value='/images/byod-mi.png' />" alt="BYOD 현장조사 업무지원 시스템 MI" /></h1>
	</div>
	<div id="nav">
		<a>&nbsp;</a>
	</div>
	<div id="container">
			<form id="SessionForm" name="SessionForm" action="/srchInfo/srchInfoList" method="post">
				<input type="hidden" id="user_id"       name="user_id"/>
				<input type="hidden" id="user_nm"       name="user_nm"/>
				<input type="hidden" id="user_appve_yn" name="user_appve_yn"/>
				<input type="hidden" id="user_role"     name="user_role"/>
				<input type="hidden" id="user_otg_no"   name="user_otg_no"/>
			</form>		
			<div class="inner">
			<article class="membLoginWrap">
				<form id="loginForm" name="loginForm" method="post">
				<div class="common-div-box1 membLogin">
					<div>					
						<fieldset>
							<label for="membID">아이디</label>
							<input type="text" id="userId" name="userId" class="loginInput" placeholder="ID"  title="아이디를 입력하세요."/><br/>					
							<label for="membPW">비밀번호</label>
							<input type="password" id="userPw" name="userPw" class="loginInput" placeholder="PW" onkeydown="javascript:if (event.keyCode == 13) { loginAction(); }" title="비밀번호를 입력하세요."/>
							<input type="button" class="loginBtn" style="cursor:pointer;" title="로그인" value="로그인" />
						</fieldset>
					<div id="tb-member">
						<a id="tb-member-btn" class="tb-member-btn">회원가입</a>							
					</div>		
					</div>
				</div>	
				</form>						
			</article>
		</div>
	</div>
		<article class="consAppDetail">	
			<div id="layer-popup" class="consRcvIn">
				<h4 id="counselTitle" class="title"></h4>
				<p class="layerExp">/ BYOD 현장 조사 업무지원 시스템을 사용하기 위해서는 회원가입이 합니다.</p>
				<ul class="addExp">
					<li>회원가입 후에는 관리자의 승인이 필요합니다.</li>
					<li>관리자의 승인 후에는 본 시스템을 사용하실 수 있습니다.</li>
					<li style="color: red;">승인된 계정의 비밀번호는 숫자'1'이고 로그인 후에 변경하실 수 있습니다.</li>												
				</ul>
				<table class="cm-tb-form2 tb-bdr-top1">
					<caption>회원가입</caption>
					<colgroup>
						<col width="18%" />
						<col />
					</colgroup>
					<tr>
						<th scope="row">아이디</th>
						<td>
							<input type="text" id="memberId" maxlength="30" size="30" />&nbsp;&nbsp;
								<button id="idCheck" class="tb-confirmCheck">아이디 중복체크</button>
							<span id="idRtn" class="right"></span>
						</td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td>
							<input type="text" id="memberName" maxlength="30" size="30" />
						</td>
					</tr>
				</table>
				<div class="buttonDiv">
					<a id="registMember" class="btnType01 orb-button">회원가입</a>
					<a id="layer-close" class="btnType01 lgb-button">닫기</a>
				</div>
			</div>
		</article>
	<div id="footer">Copyright ⓒ 2016 <span>Selimsoft</span> Co.,Ltd. All Rights Reserved.</div>
</div>
<div class="layer-cover"></div>
</body>
</html>
