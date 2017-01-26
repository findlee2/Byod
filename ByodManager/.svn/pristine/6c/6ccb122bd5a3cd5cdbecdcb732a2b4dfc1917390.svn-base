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
 	.headTitle { background-color:#fff; width:100%;  text-align:center; padding:20px;} 
 	.tb-btn{width:100%;padding:5px 0;margin-top:20px;overflow:hidden; text-align:center;}
	.btn{height:28px;font-weight:bold;font-size:13px;color:#666;text-decoration:none;vertical-align:middle;border:1px solid #ccc;padding:0 15px;margin:10px;}
	.btn:hover {background-color:#fff;}
</style>

<script>
$(document).ready(function(){
	 $("#userOtgNo").text('${userOtgNo}');
	vUrl = 'http://10.0.6.23:8007/Byod/adminOTGEncrypt';
	vPram ='userOtgNo='+$("#userOtgNo").text();
	$.ajax({
		type : "GET",
		url : vUrl,
		data : vPram,
		dataType : "json",
		cache : false,
		success : function(data){
			$("#otgNo").text(data.user_otg_no);
		},
		error : function(request, status, error) {
			if(request.status != '0'){
			     alert("code : " + request.status + "\r\nmessage : "
					 + request.reponseText + "\r\nerror : " + error);				
			}
		}
	});
});

</script>
</head>
<body>
<div id="container">
		<div class="headTitle">
		<h2>사용자 OTG 조회</h2>
		</div>
		<table class="tb-user-list">
			<tr>
				<td><b>OTG NO</b></td>
				<td id="userOtgNo"></td>
			</tr>
			<tr>
				<td><b>암호화 OTG NO</b></td>
				<td id="otgNo"></td>
			</tr>
		</table>
		<div class="tb-btn">
		<button class="btn" onclick="javascript:window.close()">닫기</button>
		</div>
		
			<c:import url="/cmm/byodManagerFooterView"/>
</div>
</body>
</html>