<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
<style type="text/css">
	#paging{text-align:center;}
	a.paging-item,a.paging-side{margin:0 .25em;}
	a.paging-item.selected{font-weight:bold;}
</style>
<script>
$(document).ready(function(){
	
	selectList(); //초기조회 시
});


function selectList(){
	vPram = '';
	vPram = 'reportNo='+ "${reportNo}";
	
	$.ajax({
		  type:"GET",
		  url: "/Byod/srchFinishInfoFList",
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
	var vTotPageCnt = 0;
	
	$("#result").empty();

		vHtml += "<tr>";
		vHtml += "	<td>보고서 번호</td>";
		vHtml += "	<td>"+data.report_no+"</td>";
		vHtml += "</tr>";
		
		vHtml += "<tr>";
		vHtml += "	<td>업무명</td>";
		vHtml += "	<td>"+data.business_nm+"</td>";
		vHtml += "</tr>";
		
	$("#result").html(vHtml);
	
	$("#demoAudio").attr('src',data.audio_attch_file_url);
	$("#demoImg").attr('src',data.img_attch_file_url);
	
}

</script>
</head>
<body>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
		<h2>업무관리</h2>
		<div class="tb-function">
			<div class="tb-search">
				<select>
					<option>ID</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요" />
				<button>조회</button>
			</div>
			<div class="tb-confirm">
				<button>승인</button>
				<button>미승인</button>
			</div>
		</div>
		<table class="tb-user-list" summary="사용자목록 테이블입니다.">
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
	<div>
	===========================================================================================
	</div>
	<div id="audioF">첨부파일 오디오 테스트</div>
	<audio id='demoAudio' src="" controls></audio>
	
	
	 <div>
	===========================================================================================
	</div>
	<div>첨부파일 이미지 테스트</div>
	<img id="demoImg" alt="" src="">
	<div id="footer">Copyright ⓒ 2016 <span>Selimsoft</span> Co.,Ltd. All Rights Reserved.</div>
</div>

</body>
</html>
