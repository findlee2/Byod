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
	
</style>
<script>

$(document).ready(function(){
	vUrl  = '';
	vPram = '';
    
	srchEqupmntId = '${srchEqupmntId}';
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminSrchEqupmntInfoList';
	vPram = 'srchEqupmntId='+ srchEqupmntId;
	alert("ㅎㅇ"+vPram)

	$.ajax({
		  type:"GET",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(data){				
							$("#cre_dt").val(data.cre_dt);
							$("#srch_equpmnt_id").val(srchEqupmntId);
							$("#srch_equpmnt_identi_no").val(data.srch_equpmnt_identi_no);
							$("#srch_equpmnt_kind").val(data.srch_equpmnt_kind);
							$("#user_id").val(data.user_id);
							$("#user_nm").val(data.user_nm);
							
							if(data.use_yn == 'Y'){
								$("#useY").prop('checked',true);
							}else{
								$("#useN").prop('checked',true);
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


function deleteEqup(){
	vUrl = '';
	vPram = '';
	vUrl = 'http://10.0.6.23:8007/Byod/adminSrchEqupmntDelete';
	vPram = 'srchEqupmntId='+srchEqupmntId;
// 	vPram = 'srchEqupmntId='+ $("#srch_equpmnt_id").text();
	alert(vPram);
	
	$.ajax({
		  type:"PUT",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "text",		  
		  cache : false,
		  success : function(){
		  },
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }else{
			    	alert("삭제되었습니다");
			  		goList();
			    }
		  }
	  });	
}


function updateEqup(){
	vUrl = '';
	vPram = '';
	
	var useYn =$(':input[name=use_yn]:radio:checked').val();
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminSrchEqupmntUpdate';
	vPram = 'srchEqupmntId='+$("#srch_equpmnt_id").val()+'&';
	vPram += 'srchEqupmntIdentiNo='+$("#srch_equpmnt_identi_no").val()+'&';
	vPram += 'srchEqupmntKind='+$("#srch_equpmnt_kind").val()+'&';
	vPram += 'userId='+ $("#user_id").val()+'&';
	vPram += 'userNm='+ $("#user_nm").val()+'&';
	vPram += 'useYn='+useYn;	
	
	alert(vPram);
	$.ajax({	
		  type:"PUT",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		 
		  crossOrigin: true,
		  cache : false,
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }else{
			    	alert("수정 성공");
			    }
			    goList();
		  }
	  });
}

</script>
</head>
<body>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
		<h2>단말기관리>상세조회</h2>
		<div class="tb-function">
			<form  id="btnList" action="/srchEqupmnt/srchEqupmntList">
				<input type="hidden" >
			</form>
			<div class="tb-confirm">
			</div>
		</div>
		<table class="tb-detail">
				<tr>
					<th>조사장비ID</th>
					<td id=""><input type="text" id="srch_equpmnt_id" readonly></td>
				</tr>
				<tr>
					<th>조사장비고유번호</th>
					<td><input type="text" id="srch_equpmnt_identi_no" ></td>
				</tr>
				<tr>
					<th>장비 종류</th>
					<td><input type="text" id="srch_equpmnt_kind" ></td>
				</tr>
				<tr>
					<th>사용자 ID</th>
					<td><input type="text" id="user_id" ></td>
				</tr>
				<tr>
					<th>사용자 이름</th>
					<td><input type="text" id="user_nm"></td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td><input type="radio" name="use_yn" value="Y" id="useY" >사용 &nbsp;&nbsp;&nbsp; <input type="radio" name="use_yn" value="N" id="useN">미사용</td>
				</tr>
		</table>


				<div class="tb-btn">
					<button class="btn" onclick="updateEqup()">수정</button>
					<button class="btn" onclick="deleteEqup()">삭제</button>
					<button class="btn" onclick="goList()">목록으로</button>
				</div>

	</div>
	<c:import url="/cmm/byodManagerFooterView"/>

</div>

</body>
</html>
