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
    $(".loginBtn").click(function(){
        loginAction();
    });
});

//로그인 요청
function loginAction(){
	
	$.ajax({
		  type:"GET",
		  url: '/Byod/userWLoginInfo',
		  data : $("#loginForm").serialize(),
		  dataType	: "json",		  
		  cache : false,
          success : onSuccess,		 
		  error : function(request, status, error) {
			    if (request.status != '0') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });
}

//로그인 성공시 업무관리 페이지 요청
function onSuccess(data, status, xhr){
	//alert(xhr.status);
	$("#loginForm").submit();
	
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
			<div class="inner">
			<article class="membLoginWrap">
				<form id="loginForm" name="loginForm" action="/srchInfo/srchInfoList" method="post">
				<div class="common-div-box1 membLogin">
					<div>					
						<fieldset>
							<label for="membID">아이디</label>
							<input type="text" id="userId" name="userId" class="loginInput" placeholder="ID"  title="아이디를 입력하세요."/><br/>					
							<label for="membPW">비밀번호</label>
							<input type="password" id="userPw" name="userPw" class="loginInput" placeholder="PW" onkeydown="javascript:if (event.keyCode == 13) { loginAction(); }" title="비밀번호를 입력하세요."/>
							<input type="button" class="loginBtn" style="cursor:pointer;" title="로그인" value="로그인" />
						</fieldset>					
					</div>
				</div>							
				</form>
			</article>
		</div>
	</div>
	<div id="footer">Copyright ⓒ 2016 <span>Selimsoft</span> Co.,Ltd. All Rights Reserved.</div>
</div>
</body>
</html>
