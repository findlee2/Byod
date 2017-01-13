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
	.tb-cont {text-align:left;}
	.tb-btn {width:100%;padding:5px 0;margin-top:20px;overflow:hidden; text-align:center;}
	.btn{height:28px;font-weight:bold;font-size:13px;color:#666;text-decoration:none;vertical-align:middle;border:1px solid #ccc;padding:0 15px;margin:10px;}
	.btn:hover {background-color:#fff;}
	input[type=text] {width: 100%; padding: 12px 20px; margin: 0; box-sizing: border-box;}
</style>
<script>

$(document).ready(function(){
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminBeforeRegistBusiness';
	$.ajax({
		  type:"GET",
		  url: vUrl,
		  dataType	: "json",		  
		  cache : false,
		  success : function(data){
			  $("#report_no").val(data.report_no);
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




function regist(){
	
	vUrl  = '';
	vPram = '';
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminRegistBusiness';
	
	vPram += 'reportNo='+$("#report_no").val()+'&';
	vPram += 'userId='+$("#user_id").val()+'&';
	vPram += 'businessNm='+ $("#business_nm").val()+'&';
	vPram += 'objectPlaceNm='+ $("#object_place_nm").val()+'&';
	vPram += 'objectRelationUser='+$("#object_relation_user").val()+'&';
	vPram += 'objectRelationUserHomeTel='+$("#object_relation_user_home_tel").val()+'&';
	vPram += 'objectRelationUserMobilTel='+$("#object_relation_user_mobil_tel").val()+'&';
	vPram += 'objectLocation='+$("#object_location").val()+'&';
	vPram += 'objectUse='+$("#object_use").val()+'&';
	vPram += 'objectBuilStruc='+$("#object_buil_struc").val()+'&';
	vPram += 'checkPeriodStart='+$("#check_period_start").val()+'&';
	vPram += 'checkPeriodEnd='+$("#check_period_end").val()+'&';
	vPram += 'checkUserNm='+$("#check_user_nm").val()+'&';
	vPram += 'checkUserQualficationClass='+$("#check_user_qualfication_class").val()+'&';
	vPram += 'checkUserQualficationNo='+$("#check_user_qualfication_no").val()+'&';
	vPram += 'headFireDepart='+$("#head_fire_depart").val()+'&';
	vPram += 'locationLat='+$("#location_lat").val()+'&';
	vPram += 'locationLon='+$("#location_lon").val();
	
	$.ajax({
		  type:"POST",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(){				
							alert("등록 성공");
		  				},
		  error : function(request, status, error) {
			    if (request.status != '200') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
//  			    goList();
		  }
	  });
	
}


</script>
</head>
<body>
<div id="byod-wrap">
	<c:import url="/cmm/byodManagerTopView"/>	
	<div id="container">
	<form  id="btnList" action="/srchInfo/srchInfoList">
		<input type="hidden" name="" >
	</form>
	<form  id="btnUpdate" action="/srchInfo/srchInfoList">
		<input type="hidden" name="" >
	</form>
		<h2>업무관리>신규등록 </h2>
		<div class="tb-function">
			<form  id="btnList" action="/srchInfo/srchInfoList">
		<input type="hidden" >
	</form>
			<div class="tb-confirm">
			</div>
		</div>
		<table class="tb-detail">
			<tr>
				<th>보고서번호(*)</th>
				<td colspan="5"><input type="text" id="report_no" name="report_no" readonly></td>
			</tr>
		</table>
		<table class="tb-detail">
			<tr>
				<th>사용자ID(*)</th>
				<td><input type="text" id="user_id" name="user_id" placeholder="사용자ID"/></td>
				<th>업무명(*)</th>
				<td><input type="text" id="business_nm" name="business_nm" ></td>
			</tr>
		</table>
		<table class="tb-detail" summary="업무등록 테이블입니다." >
			<caption>업무 신규 등록</caption>
				<tr>
					<th rowspan="4" width="7%" scope="col" class="tb-title">소방대상물</th>
					<th width="5%" scope="col" class="tb-title">명칭</th>
					<td width="15%" scope="col" class="tb-cont" ><input type="text" id="object_place_nm" placeholder="명칭(*)"></td>
					<td width="15%" scope="col" class="tb-cont" ><input type="text" id="object_relation_user_home_tel" placeholder="전화번호"></td>
					<th width="5%" scope="col" class="tb-title">관계인</th>
					<td width="15%" scope="col" class="tb-cont"><input type="text" id="object_relation_user" placeholder="관계인 성명(*)"></td>
					<td width="15%" scope="col" class="tb-cont"><input type="text" id="object_relation_user_mobil_tel" placeholder="관계자 연락처"></td>
				</tr>
<!-- 			<tbody id="result"> -->
					<tr>
						<th class="tb-title">소재지</th>
						<td colspan="5" class="tb-cont">
<!-- 						<button class="btn" onclick="searchLocation()">검색</button><input type="text" id="object_location"> -->
					
								<input type="button" onclick="postcode()" class="btn" value="주소 검색">
								<input type="text" id="object_location" readonly placeholder=""><input type="hidden" id="location_lat" placeholder="위도"><input type="hidden" id="location_lon" placeholder="경도"><br>
<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//apis.daum.net/maps/maps3.js?apikey=79f43aa7737af042d69f7d5ffaeefa94&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

    function postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("object_location").value = fullAddr;
                // 주소로 좌표를 검색
                geocoder.addr2coord(data.address, function(status, result) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
                        // 지도를 보여준다.
                        document.getElementById("location_lat").value = result.addr[0].lat;
                        document.getElementById("location_lon").value = result.addr[0].lng;
                        
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>
						
						</td>
					</tr>
					<tr>
						<th class="tb-title">용도(*)</th>
						<td colspan="5" class="tb-cont"><input type="text" id="object_use" value=""></td>
					</tr>
					<tr>
						<th >건물구조(*)</th>
						<td colspan="5" class="tb-cont"><input type="text" id="object_buil_struc" value=""></td>
					</tr>
<!-- 			</tbody> -->
		</table>
		<table class="tb-detail">
			<tr>
				<th>점검기간(*)</th>
				<td><input type="text" name="check_period_start" id="check_period_start" value="" placeholder="시작일 (예)20160101"></td>
				<td><input type="text" name="check_period_end" id="check_period_end" value=""placeholder="종료일 (예)20160102"></td>
				<th> 소방서장</th>
				<td ><input type="text" name="head_fire_depart" id="head_fire_depart" value="북부"> </td>
			</tr>		
		</table>
		<table class="tb-detail">
			<tr>
				<th colspan="5">특기사항</th>
			</tr>		
			<tr>
				<th rowspan="3">점검자</th>
				<th>성명(*)</th>
				<th>자격구분(*)</th>
				<th>자격번호(*)</th>
			</tr>		
			<tr>
				<td><input type="text" name="check_user_nm" id="check_user_nm" value="" placeholder="점검자 성명"></td>
				<td><input type="text" name="check_user_qualfication_class" id="check_user_qualfication_class" placeholder="점검자 자격구분"></td>
				<td><input type="text" name="check_user_qualfication_no" id="check_user_qualfication_no" placeholder="점검자 자격번호">
				</td>
			</tr>			
		</table>
		
			<div class="tb-btn" >
				<button class="btn" onclick="regist()">등록</button>
				<button class="btn" onclick="goList()">취소</button>
			</div>

	</div>
	<div id="paging"></div>
	<div id="footer">Copyright ⓒ 2016 <span>Selimsoft</span> Co.,Ltd. All Rights Reserved.</div>
</div>

</body>
</html>
