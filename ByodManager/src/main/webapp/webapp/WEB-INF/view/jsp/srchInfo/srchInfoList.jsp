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
<script src="<c:url value='/js/jquery.paging.js'/>"></script> 
<script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
<link href="<c:url value='/css/datatable.css'/>" rel="stylesheet" type="text/css">
 
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
		vUrl = 'http://10.0.6.23:8007/Byod/adminSrchInfoList';
		//vUrl = '/Byod/adminSrchInfoList';
	}else{                                   //조사자 조회		
		vUrl  = 'http://10.0.6.23:8007/Byod/srchWebInfoList';
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
	
	var vHtml            = "";
	
	$("#result").empty();
	
	$.each( data, function(key,val){

		vHtml += "<tr>";
		vHtml += "	<td>"+eval(key+1)+"</td>"; 
		vHtml += "	<td><a onclick=detailListView('"+data[key].report_no+"') style=cursor:pointer>"+data[key].report_no+"</a></td>";
		vHtml += "	<td>"+data[key].business_nm+"</td>";
		vHtml += "	<td>"+data[key].object_location+"</td>";
		vHtml += "	<td>"+data[key].check_user_nm+"</td>";
		vHtml += "	<td>"+data[key].user_id+"</td>";
		vHtml += "	<td>"+data[key].check_period_start+"</td>";
		if(data[key].report_stats == '2'){
			vHtml += "	<td>완료</td>";	
		}else{
			vHtml += "	<td>진행중</td>";
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

function detailListView(reportNo){
	$("#reportNo").val(reportNo);
	$("#frm").submit();
}

function registBusiness(){
	$("#registForm").submit();
}
</script>
</head>
<body>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
	<form name="frm" id="frm" action="/srchInfo/srchDetailInfo" method="post">
		<input type="hidden" name="reportNo" id="reportNo">
	</form>
	<form id="registForm" name="registForm" action="/srchInfo/srchInfoRegist" method="post">
		<input id="reportNo" name="reportNo" type="hidden" value=""/>
	</form>
		<h2>업무관리</h2>
		<div class="tb-function">
				<div class="tb-confirm">
				<button onclick="registBusiness()">등록</button>
			</div>
		</div>
		<table id="dataList" class="tb-user-list" summary="업무목록 테이블입니다.">
			<caption>업무목록</caption>
			<thead>
				<tr>
					<th width="10%" scope="col">순번</th>
					<th width="15%" scope="col">보고서 번호</th>
					<th scope="col">업무명</th>
					<th scope="col">소재지</th>
					<th width="10%" scope="col">담당자</th>
					<th width="15%" scope="col">담당자 아이디</th>
					<th width="10%" scope="col">점검시작일</th>
					<th width="12%" scope="col">상태</th>
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
