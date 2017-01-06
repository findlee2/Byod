<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	function homeLoaction(){
		$("#tmpForm").submit();
	}
</script>
<div id="header">
<form id="tmpForm" name="tmpForm" action="/srchInfo/srchInfoList" method="post"></form>

	<h1><a onclick="homeLoaction()"><img src="<c:url value='/images/byod-mi.png' />" alt="BYOD 현장조사 업무지원 시스템 MI" /></a></h1>
	<div>
		<a href="#link">로그인</a>
		<a href="#link">회원가입</a>
	</div>
</div>
<div id="nav">
	<a href="#link">업무관리</a>
	<a href="#link">사용자관리</a>
	<a href="#link">단말기관리</a>
	<a href="#link">로그관리</a>
</div>