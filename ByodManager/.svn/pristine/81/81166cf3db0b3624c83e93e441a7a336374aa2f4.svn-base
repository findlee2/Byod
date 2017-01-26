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
<link href="<c:url value='/css/datatable.css'/>" rel="stylesheet" type="text/css">
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
		vUrl = 'http://10.0.6.23:8007/Byod/adminSrchEqupmntInfoAllList';
	}else{                                   //조사자 조회
		vUrl  = 'http://10.0.6.23:8007/Byod/srchInfoList';
		vPram = user_id='${userVO.user_id}';
	}
	
	$.ajax({
		  type:"GET",
		  url: vUrl,
		  data : vPram,		  
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


function onSuccess(data, status, xhr){
	
	var vHtml       = "";
	
	$("#result").empty();
	
	$.each(data, function(key,val){
		
		vHtml += "<tr>";
		vHtml += "	<td>"+eval(key+1)+"</td>"; 
		vHtml += "	<td><a onclick=detailListView('"+data[key].srch_equpmnt_id+"') style=cursor:pointer>"+data[key].srch_equpmnt_id+"</td>";
		vHtml += "	<td>"+data[key].srch_equpmnt_identi_no+"</td>";
		vHtml += "	<td>"+data[key].srch_equpmnt_kind+"</td>";
		vHtml += "	<td>"+data[key].user_nm+"</td>";
		vHtml += "	<td>"+data[key].user_id+"</td>";
		vHtml += "	<td>"+data[key].cre_dt+"</td>";
		vHtml += "	<td>"+data[key].use_yn+"</td>";
		vHtml += "</tr>";
		
	 });
	$("#result").html(vHtml);
	
	  $('#dataList').DataTable({
		    "paging": true ,
		    "lengthChange": false,
		    "searching": true,
		    "ordering": false,
		    "info": false,
		    "autoWidth": true,
		    "oLanguage": {
  				"sSearch": "<span>조회:</span> _INPUT_" //search
			}
		  });
// 	  $("label").html("<input type='search' class='' placeholder='검색' aria-controls='dataList'>");
// 	  $("label").replaceAll('Search:','검색');
	  }


function detailListView(srchEqupmntId){
	$("#srchEqupmntId").val(srchEqupmntId);
	alert($("#srchEqupmntId").val());
	$("#pageForm").submit();
}


function registBusiness(){
	$("#registForm").submit();
}


</script>
</head>
<body>
<form id="registForm" name="registForm" action="/srchEqupmnt/srchEqupRegist" method="post">
<!-- 	<input id="srchEqupmntId" name="srchEqupmntId" type="hidden" value=""/> -->
</form>
<form id="pageForm" name="pageForm" action="/srchEqupmnt/srchEqupDetail" method="post">
	<input id="srchEqupmntId" name="srchEqupmntId" type="hidden" value=""/>
</form>

<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
		<h2>단말기관리</h2>
		<div class="tb-function">

			<div class="tb-confirm">
				<button onclick="registBusiness()" class="btnRegist">장비신규등록</button>
			</div>
		</div>
		<table class="tb-user-list" id="dataList" summary="사용자목록 테이블입니다.">
			<caption>장비목록</caption>
			<thead>
				<tr>
					<th width="10%" scope="col">순번</th>
					<th width="15%" scope="col">장비 ID</th>
					<th scope="col">조사장비 고유번호</th>
					<th width="10%" scope="col">종류</th>
					<th width="15%" scope="col">사용자 이름</th>
					<th width="12%" scope="col">사용자 ID</th>
					<th width="12%" scope="col">생성일자</th>
					<th width="12%" scope="col">사용여부</th>
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
