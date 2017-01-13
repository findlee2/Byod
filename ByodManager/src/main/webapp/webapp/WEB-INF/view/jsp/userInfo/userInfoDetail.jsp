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
	.tb-detail {width:100%; margin-top:10px; }
	.tb-detail th {height:50px; text-align:center; background-color:#f9f9f9; border:1px solid #dddddd;}
	.tb-detail td {height:50px; border:1px solid #dddddd; padding : 10px;}
 	.tb-detail td:hover {background-color:#F9F9F9;} 
 	.tb-title {text-align:center;} 
	.tb-cont {text-align:left; }
	
	.tb-btn{width:100%;padding:5px 0;margin-top:20px;overflow:hidden; text-align:center;}
	.btn{height:28px;font-weight:bold;font-size:13px;color:#666;text-decoration:none;vertical-align:middle;border:1px solid #ccc;padding:0 15px;margin:10px;}
	.btn:hover {background-color:#fff;}
	
	input[type=text] { width: 200px; padding: 7px 5px; margin: 0; box-sizing: border-box;}
	
	
</style>
<script>

$(document).ready(function(){
	vUrl  = '';
	vPram = '';
    
	clickuserID = '${clickuserID}';
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminSrchUserDetailInfo';
	vPram = 'userId='+clickuserID;
// 	alert("뭘눌럿"+clickuserID);
	               
	$.ajax({
		  type:"GET",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(data){
				$("#user_id").text(data.user_id);
				$("#user_nm").val(data.user_nm);
				$("#user_otg_no").val(data.user_otg_no);
				$("#user_reg_dt").text(data.user_reg_dt);
				
				if(data.user_role == '2'){
					$("#role2").prop('checked',true);
				}else{
					$("#role1").prop('checked',true);
				}
				
				if(data.user_appve_yn == '1'){
					$("#appve1").prop('checked',true);
				}else{
					$("#appve2").prop('checked',true);
				}
		  },
				
				
		  error : function(request, status, error) {
			    if (request.status != '0') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });
});

function goList(){
	$("#btnList").submit();
}

function deleteUser(){
	
	vUrl = '';
	vPram = '';
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminUserDelete';
	vPram = 'userId='+ $("#user_id").text();
	alert(vPram);
	
	$.ajax({
		  type:"PUT",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(){
		  },
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
			    else{
					  goList();
			    }
		  }
	  });	
}

function update(){
	vUrl = '';
	vPram = '';
alert("${userVO.user_id}");
	var userAppveYn =$(':input[name=user_appve_yn]:radio:checked').val();
	var userRole =$(':input[name=user_role]:radio:checked').val();
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminUserUpdate';
	vPram = 'userId='+ $("#user_id").text();
	vPram += '&userNm='+ $("#user_nm").val();
	vPram += '&userOtgNo='+ $("#user_otg_no").val();	
	vPram += '&userAppveYn='+ userAppveYn;
	vPram += '&userRole='+ userRole;	
	vPram += '&adminUserId=${userVO.user_id}';
	vPram += '&adminUserNm=${userVO.user_nm}';
	
	
	
	
	alert(vPram);
	
	$.ajax({
		  type:"PUT",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(){
			  
		    	alert("정보가 변경되었습니다.");
				goList();
		  },
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });	
	
}


</script>
</head>
<body>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">

		<h2>사용자관리>상세조회</h2>
		<div class="tb-function">
			<form  id="btnList" action="/userInfo/userInfoList">
		<input type="hidden" >
	</form>
			<div class="tb-confirm">
			</div>
		</div>
		<table class="tb-detail">
				<tr>
					<th>사용자 ID</th>
					<td id="user_id" ></td>
				</tr>
				<tr>
					<th>사용자 이름</th>
					<td id="" ><input type="text" id="user_nm"></td>
				</tr>
				<tr>
					<th>등록일</th>
					<td id="user_reg_dt" ></td>
				</tr>
				<tr>
					<th>역할</th>
					<td id="user_role"><input type="radio" name="user_role" value="1" id="role1">관리자  &nbsp;&nbsp;&nbsp;<input type="radio" name="user_role" id="role2" value="2">일반사용자</td>
				</tr>
				<tr>
					<th>OTG번호</th>
					<td><input type="text" id="user_otg_no" ></td>
				</tr>
				<tr>
					<th>승인여부</th>
					<td><input type="radio" name="user_appve_yn" value="1" id="appve1">승인 &nbsp;&nbsp;&nbsp; <input type="radio" name="user_appve_yn" id="appve2" value="2">미승인</td>
				</tr>
		</table>


				<div class="tb-btn">
					<button class="btn" onclick="update()">수정</button>
					<button class="btn" onclick="deleteUser()">삭제</button>
					<button class="btn" onclick="goList()">목록으로</button>
				</div>

	</div>

	<c:import url="/cmm/byodManagerFooterView"/>
</div>

</body>
</html>
