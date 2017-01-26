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
<link href="<c:url value='/css/datatable.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/byod.css'/>" rel="stylesheet" type="text/css">
<script src="/webjars/jquery/2.2.1/jquery.min.js"></script>
<script src="<c:url value='/js/jquery.paging.js'/>"></script> 
<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
 
<script>
$(document).ready(function(){
	
	/** 이벤트 정의 */
    $(".loginBtn").click(function(){
        loginAction();
    });
	selectList(); //초기조회 시
});

function selectList(){
	vUrl  = '';
	vPram = '';
	
	if("${userVO.user_role}" == '1'){        //관리자 조회
		vUrl = 'http://10.0.6.23:8007/Byod/adminSrchUserInfoList';
	}else{                                   //조사자 조회
		vUrl  = 'http://10.0.6.23:8007/Byod/srchInfoList';
		vPram = 'userId=${userVO.user_id}';
	}
	
	$.ajax({
		  type:"GET",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  crossOrigin: true,
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


function onSuccess(data, status, xhr){
	var vHtml       = "";
	
	$("#result").empty();
	
	$.each( data, function(key,val){

		vHtml += "<tr>";
		vHtml += "	<td>"+eval(key+1)+"</td>"; 
		vHtml += "	<td><a onclick=detailListView('"+data[key].user_id+"') style=cursor:pointer>"+data[key].user_id+"</td>";
		vHtml += "	<td>"+data[key].user_nm+"</td>";
		if(data[key].user_role == '2'){
			vHtml += "	<td>일반사용자</td>";
		}else{
			vHtml += "	<td>관리자</td>";
		}
		
		if(data[key].user_otg_no == null){
		vHtml += "	<td>"+"부여되지않음"+"</td>";
		}else{
		vHtml += "	<td><a onclick=otgView('"+data[key].user_otg_no+"') style=cursor:pointer>"+data[key].user_otg_no+"</td>";
		}		
		
		vHtml += "	<td>"+data[key].user_reg_dt+"</td>";
		if(data[key].user_appve_yn == '1'){
			vHtml += "	<td>승인</td>";
		}else{
			vHtml += "	<td>미승인</td>";
		}
		vHtml += "</tr>";
		
	 });
	$("#result").html(vHtml);
	  $('#dataList').DataTable({
		    "paging": true ,
		    "lengthChange": false,
		    "searching": true,
		    "ordering": false,
		    "info": false,
		    "autoWidth": false,
		    "oLanguage": {
				"sSearch": "<span>조회:</span> _INPUT_" //search
			}
		  });

}

function detailListView(userID){
	alert(userID);
	$("#clickuserID").val(userID);
	$("#pageForm").submit();
}

function otgView(userOtgNo){
	$("#userOtgNo").val(" ");
	$("#userOtgNo").val(userOtgNo);
	alert($("#userOtgNo").val());
	popUrl="/userInfo/userOtgInfo"
	popOption = "width=400, height=370, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"popupView",popOption);
	$("#popupForm").submit();
}
</script>
</head>
<body>
<form id="popupForm" name="popupForm" action="/userInfo/userOtgInfo" target="popupView" method="post">
	<input id="userOtgNo" name="userOtgNo" type="hidden" value=""/>
</form>

<form id="pageForm" name="pageForm" action="/userInfo/userInfoDetail" method="post">
	<input id="clickuserID" name="clickuserID" type="hidden" value=""/>
</form>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
		<h2>사용자관리</h2>
		<table id="dataList" class="tb-user-list" summary="사용자목록 테이블입니다.">
			<caption>업무목록</caption>
			<thead>
				<tr>
					<th width="10%" scope="col">순번</th>
					<th width="15%" scope="col">사용자 ID</th>
					<th width="15%"scope="col">사용자이름</th>
					<th width="10%" scope="col">권한</th>
					<th width="15%" scope="col">OTG번호</th>
					<th width="20%" scope="col">가입일자</th>
					<th width="12%" scope="col">승인여부</th>
				</tr>
			</thead>
			<tbody id="result">
				
			</tbody>
		</table>
	</div>
	<c:import url="/cmm/byodManagerFooterView"/>
</div>


</body>
</html>