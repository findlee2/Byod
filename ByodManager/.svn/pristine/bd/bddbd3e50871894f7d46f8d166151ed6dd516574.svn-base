<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
$(document).ready(function(){
	
	var vHtml = '';
	$("#topDiv").empty();
	
	if("${userVO}" != null){		
		vHtml += "<a onclick='byodLogout()' style='cursor:pointer'>로그아웃</a>&nbsp;";
		vHtml += "<a href='#link'>비밀번호변경</a>";
		
	}else{
		vHtml += "<a href='#link'>로그인</a>";
	}
	
	$("#topDiv").html(vHtml);
});

function byodLogout(){
	
	var vPram = 'aaaa';
	$.ajax({
		  type:"GET",
		  url: '/Byod/userWLoginOut',
		  data : vPram,		  
		  dataType	: "json",	
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
	alert("1111");
	$("#tmp").submit();
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