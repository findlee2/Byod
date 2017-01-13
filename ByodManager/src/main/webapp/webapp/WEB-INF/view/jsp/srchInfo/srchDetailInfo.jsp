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
	
	input[type=text] {
    width: 100%;
    padding: 12px 15px;
    margin: 0;
    box-sizing: border-box;
	}	
	
</style>
<script>

$(document).ready(function(){
	vUrl  = '';
	vPram = '';
    
	reportNo = '${reportNo}';
	
	vUrl = 'http://10.0.6.23:8007/Byod/srchFinishDetailInfo';
	vPram = 'reportNo='+ reportNo;
	               
	$.ajax({
		  type:"GET",
		  url: vUrl,
		  data : vPram,		  
		  dataType	: "json",		  
		  cache : false,
		  success : function(data){
				
				$("#report_no").val(data.report_no);
				
				if(data.report_stats == '2'){
					$("#report_stats").val("완료");
					$(".readOnly").attr("readonly","readonly");
					$("#searchBtn").attr('disabled',true);
					
				}else{
					$("#report_stats").val("진행중");
				}
				
				$("#attch_file_cnt").val(data.attch_file_cnt);
				$("#object_place_nm").val(data.object_place_nm);
				$("#object_buil_struc").val(data.object_buil_struc);
				$("#object_relation_user").val(data.object_relation_user);
				$("#object_location").val(data.object_location);
				$("#object_use").val(data.object_use);
				$("#check_extgsh_kind").val(data.check_extgsh_kind);
				$("#check_extgsh_result").val(data.check_extgsh_result);
				$("#check_alarm_equip_kind").val(data.check_alarm_equip_kind);
				$("#check_alarm_equip_result").val(data.check_alarm_equip_result);
				$("#check_alarm_equip_kind").val(data.check_alarm_equip_kind);
				$("#check_alarm_equip_result").val(data.check_alarm_equip_result);
				$("#check_extgsh_equip_kind").val(data.check_extgsh_equip_kind);
				$("#check_extgsh_equip_result").val(data.check_extgsh_equip_result);
				$("#check_flee_equip_kind").val(data.check_flee_equip_kind);
				$("#check_flee_equip_result").val(data.check_flee_equip_result);
				$("#check_etc_equip_kind").val(data.check_etc_equip_kind);
				$("#check_etc_equip_result").val(data.check_etc_equip_result);
				$("#check_period_start").val(data.check_period_start);
				$("#check_period_end").val(data.check_period_end);
				$("#special_note").val(data.special_note);
				$("#check_user_nm").val(data.check_user_nm);
				$("#check_user_qualfication_class").val(data.check_user_qualfication_class);
				$("#check_user_qualfication_no").val(data.check_user_qualfication_no);
				$("#object_relation_user_home_tel").val(data.object_relation_user_home_tel);
				$("#object_relation_user_mobil_tel").val(data.object_relation_user_mobil_tel);
				$("#location_lat").val(data.location_lat);
				$("#user_id").val(data.user_id);
				$("#location_lon").val(data.location_lon);
				$("#business_nm").val(data.business_nm);
				$("#demoAudio").attr('src',data.audio_attch_file_url);
				$("#demoImg").attr('src',data.img_attch_file_url);
				
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

function deleteInfo(){
	
	vUrl  = '';
	vPram = '';
	reportNo = $("#report_no").val();

	vUrl = 'http://10.0.6.23:8007/Byod/adminSrchInfoDelete';
	vPram = 'reportNo='+ reportNo;
	
	$.ajax({
		type: "DELETE",
		url : vUrl,
		data : vPram,
		dataType : "json",
		cache : false,
		error : function(request, status, error) {
			if(request.status != '200'){
			     alert("code : " + request.status + "\r\nmessage : "
					 + request.reponseText + "\r\nerror : " + error);				
			}
				goList();
		}
	});
}

function update(){
	vUrl  = '';
	vPram = '';
	
	vUrl = 'http://10.0.6.23:8007/Byod/adminUpdateBusiness';
	
	reportNo = $("#report_no").val();
	
	
	vPram = 'reportNo='+ reportNo+'&';;
	vPram += 'userId='+$("#user_id").val()+'&';
	vPram += 'businessNm='+ $("#business_nm").val()+'&';
	vPram += 'objectPlaceNm='+$("#object_place_nm").val()+'&';
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
		type: "PUT",
		url : vUrl,
		data : vPram,
		dataType : "json",
		cache : false,
		success : function(){
			alert("업무 내용이 수정되었습니다.");
		},
		error : function(request, status, error) {
			if(request.status != '200'){
			     alert("code : " + request.status + "\r\nmessage : "
					 + request.reponseText + "\r\nerror : " + error);				
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
	<form  id="btnUpdate" action="/srchInfo/srchInfoList">
		<input type="hidden" name="" >
	</form>
		<h2>업무관리>상세조회</h2>
		<div class="tb-function">
			<form  id="btnList" action="/srchInfo/srchInfoList">
				<input type="hidden" >
			</form>
			<div class="tb-confirm">
			</div>
		</div>
		<table class="tb-detail" class="tb-user-list">
			<tr>
				<th>보고서번호</th>
				<td><input type="text" id="report_no" name="report_no" readonly></td>
				<th>업무명</th>
				<td><input type="text" id="business_nm" name="business_nm" readonly></td>
				<th>상태</th>
				<td><input type="text" id="report_stats" name="report_stats" readonly></td>
				<th>첨부파일</th>
				<td><input type="text" id="attch_file_cnt" name="attch_file_cnt" readonly></td>
			</tr>
		</table>
		<table class="tb-detail" summary="소방대상물 테이블입니다." >
			<caption>업무상세</caption>
				<tr>
					<th rowspan="4" width="10%" scope="col" class="tb-title">소방대상물</th>
					<th width="5%" scope="col" class="tb-title">명칭</th>
					<td width="25%" scope="col" class="tb-cont" ><input type="text" id="object_place_nm" class="readOnly"><br><input type="text" id="object_relation_user_home_tel" ></td>
					<th width="5%" scope="col" class="tb-title">관계인</th>
					<td width="25%" scope="col" class="tb-cont"><input type="text" id="object_relation_user" class="readOnly"><br><input type="text" id="object_relation_user_mobil_tel" ></td>
				</tr>
<!-- 			<tbody id="result"> -->
					<tr>
						<th class="tb-title">소재지</th>
						<td colspan="3" class="tb-cont">								<input type="button" onclick="postcode()" class="btn" id="searchBtn" value="주소 검색">
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
</script></td>
					</tr>
					<tr>
						<th class="tb-title">용도</th>
						<td colspan="3" class="tb-cont"><input type="text" id="object_use" value="" class="readOnly"></td>
					</tr>
					<tr>
						<th >건물구조</th>
						<td colspan="3" class="tb-cont"><input type="text" id="object_buil_struc" value="" class="readOnly"></td>
					</tr>
<!-- 			</tbody> -->
		</table>
		<table class="tb-detail">
			<tr>
				<th width="10%" rowspan="6">소방시설 <br>등의 <br> 점검 내역</th>
				<th colspan="2">소방시설의 종류</th>
				<th>점검결과</th>
			</tr>
			<tr>
				<th class="tb-title" width="10%">소화기구</th>
				<td ><input class="readOnly" readonly type="text" name="check_extgsh_kind" id="check_extgsh_kind" value="작성된 내용 없음."></td>
				<td width="20%"><input type="text" class="readOnly" readonly name="check_extgsh_result" id="check_extgsh_result" value="작성된 내용 없음."></td>
			</tr>
			<tr>
				<th>경보설비</th>
				<td><input type="text" class="readOnly" readonly name="check_alarm_equip_kind" id="check_alarm_equip_kind" value="작성된 내용 없음."></td>
				<td><input type="text" class="readOnly" readonly name="check_alarm_equip_result" id="check_alarm_equip_result" value="작성된 내용 없음."></td>
			</tr>
			<tr>
				<th>소화설비</th>
				<td><input type="text" class="readOnly" readonly name="check_extgsh_equip_kind" id="check_extgsh_equip_kind" value="작성된 내용 없음."></td>
				<td><input type="text" class="readOnly" readonly name="check_extgsh_equip_result" id="check_extgsh_equip_result" value="작성된 내용 없음."></td>
			</tr>
			<tr>
				<th>피난설비</th>
				<td><input type="text" class="readOnly" readonly name="check_flee_equip_kind" id="check_flee_equip_kind" value="작성된 내용 없음."></td>
				<td><input type="text" class="readOnly" readonly name="check_flee_equip_result" id="check_flee_equip_result" value="작성된 내용 없음."></td>
			</tr>
			<tr>
				<th>기타설비</th>
				<td><input type="text"class="readOnly"  readonly name="check_etc_equip_kind" id="check_etc_equip_kind" value="작성된 내용 없음."></td>
				<td><input type="text" class="readOnly" readonly name="check_etc_equip_result" id="check_etc_equip_result" value="작성된 내용 없음."></td>
			</tr>
						<tr>
				<th colspan="2">특기사항</th>
				<td colspan="4"><input class="readOnly" type="text" id="special_note" value="" readonly></td>
			</tr>
		</table>
		<table class="tb-detail">
			<tr>
				<th>점검기간(*)</th>
				<td><input type="text" class="readOnly" name="check_period_start" id="check_period_start" value="" placeholder="시작일 (예)20160101"></td>
				<td><input type="text" class="readOnly" name="check_period_end" id="check_period_end" value=""placeholder="종료일 (예)20160102"></td>
				<th> 소방서장</th>
				<td ><input type="text" class="readOnly" name="head_fire_depart" id="head_fire_depart" value="북부"> </td>
			</tr>		
		</table>
		<table class="tb-detail">		
			<tr>
				<th rowspan="3">점검자</th>
				<th>성명(*)</th>
				<th>자격구분(*)</th>
				<th>자격번호(*)</th>
			</tr>		
			<tr>
				<td>
				<input type="hidden" class="readOnly" name="user_id" id="user_id" value="" >
				<input type="text" class="readOnly" name="check_user_nm" id="check_user_nm" value="" placeholder="점검자 성명"></td>
				<td><input type="text" class="readOnly" name="check_user_qualfication_class" id="check_user_qualfication_class" placeholder="점검자 자격구분"></td>
				<td><input type="text" class="readOnly" name="check_user_qualfication_no" id="check_user_qualfication_no" placeholder="점검자 자격번호">
				</td>
			</tr>			
		</table>
		
		<table class="tb-detail">
				<tr>
					<th rowspan="2" width="10%">첨부파일</th>
					<th width="5%">이미지</th>
					<td><audio id='demoAudio' src="" controls></audio></td>
				</tr>
				<tr>
					<th width="5%">녹취</th>
					<td> <img id="demoImg" alt="" src=""></td>
				</tr>				
		</table>

				<div class="tb-btn">
					<button class="btn" onclick="update()">수정</button>
					<button class="btn" onclick="deleteInfo()">삭제</button>
					<button class="btn" onclick="goList()">목록으로</button>
				</div>

	</div>
	<c:import url="/cmm/byodManagerFooterView"/>
</div>

</body>
</html>
