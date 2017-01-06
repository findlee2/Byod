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
	
	/** 이벤트 정의 */
    $(".loginBtn").click(function(){
        loginAction();
    });
	//selectList(0); //초기조회 시
});

var vPage           = 1; //클릭한 페이지 번호
var vPageFirstIndex = 0; //페이지 시작 번호

function selectList(page){
	vUrl  = '';
	vPram = '';
	
	if("${userVO.user_role}" == '1'){        //관리자 조회
		vUrl = '/Byod/adminSrchInfoList';
		vPram = 'pageNo='+ page;
	}else{                                   //조사자 조회
		vUrl  = '/Byod/srchInfoList';
		if(page !=null){
			vPram = user_id='${userVO.user_id}';
		}else{
			vPram = user_id='${userVO.user_id}';
		}
		vPram = user_id='${userVO.user_id}';
		//vPage = page;
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
	var vTotPageCnt = 0;
	
	$("#result").empty();
	
	$.each( data, function(key,val){

		vHtml += "<tr>";
		if(vPageFirstIndex > 0){
			vHtml += "	<td>"+eval(vPageFirstIndex+1+key)+"</td>";
		}else{
			vHtml += "	<td>"+eval(key+1)+"</td>"; 
		}
		vHtml += "	<td>"+data[key].report_no+"</td>";
		vHtml += "	<td>"+data[key].business_nm+"</td>";
		vHtml += "	<td>"+data[key].object_location+"</td>";
		vHtml += "	<td>"+data[key].check_user_nm+"</td>";
		vHtml += "	<td>"+data[key].user_id+"</td>";
		vHtml += "	<td>"+data[key].check_period_start+"</td>";
		vHtml += "	<td>"+data[key].report_stats+"</td>";
		vHtml += "</tr>";
		
		vTotPageCnt = data[key].tot_cnt;
	 });
	$("#result").html(vHtml);
	
	//총 건수를 구한후 페이징 max값 설정한다.	
	if((vTotPageCnt) > 0){
		vTotPageCnt = Math.round(vTotPageCnt/10)+1;
	}
	
	$('#paging').paging({
		current:vPage, max:vTotPageCnt,
		onclick:function(e,num){
			vPage = num;
			if(vPage > 1){				
				vPageFirstIndex = eval((vPage-1)*10); //페이지 시작번호 세팅
				selectList(eval((vPage-1)*10));
			}else{
				vPageFirstIndex = 0;
				selectList(0);
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
		<h2>단말기관리</h2>
		<div class="tb-function">
			<div class="tb-search">
				<select>
					<option>ID</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요" />
				<button>조회</button>
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
	<div id="paging"></div>
	<div id="footer">Copyright ⓒ 2016 <span>Selimsoft</span> Co.,Ltd. All Rights Reserved.</div>
</div>

</body>
</html>
