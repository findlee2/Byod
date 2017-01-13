<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ajaxTest</title>
<script src="/webjars/jquery/2.2.1/jquery.min.js"></script> 
<script type="text/javascript">

//조사자등록 ajax 테스트
//contentType 설정하지말고 String으로 쏠것(유의사항)
function fn_insertUser(){
	
	//var params = jQuery("#userInfoForm").serialize();
	var userId    = document.userInfoForm.userId.value;
	var userNm    = document.userInfoForm.userNm.value;
	var userOtgNo = document.userInfoForm.userOtgNo.value;
	
	var vParam = "userId="+ userId
				+"&userNm="+ userNm
				+"&userOtgNo="+ userOtgNo;
	
	$.ajax({
		  type:"POST",
		  url: '/Byod/AdminUserRegist',
		  //data : $("#userInfoForm").serialize(), 
		  data: vParam,
		  dataType	: "json",		  
		  cache : false,
          //ContentType: "application/json",
		  success: function(data) {
			  alert(data.user_id);	
		  },
		  error : function(request, status, error) {
			    if (request.status != '0') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });
}
//보고서 업로드
function uploadForm(){
	
	//var params = jQuery("#uploadForm").serialize();
	var reportNo    = "SL_ResultReport_000001";
	var userId      = "ahnsu234";
	var networkPath = "3g";
	var locationLat = "36.428079";
	var locationLon = "127.392783";
	var	sourceFile = [];		
	
	var vParam = "reportNo="+ reportNo
				+"&userId="+ userId
				+"&networkPath="+ networkPath
				+"&locationLat="+ locationLat
				+"&locationLon="+ locationLon
				+"&sourceFile="+ document.uploadForm.sourceFile.value;
	//폼객체를 불러와서
	var form = $('uploadForm')[0];
	//FormData parameter에 담아줌
	var formData = new FormData(form);
	$.ajax({
		  type:"post",
		  url: '/Byod/SrchUserReportUpload',
		  //data : $("#uploadForm").serialize(),
		  data : formData,
		  //data: vParam,
		  dataType	: "json",		  
		  cache : false,
          //ContentType: "application/json",
		  success: function(data) {
			  alert(data);	
		  },
		  error : function(request, status, error) {
			    if (request.status != '0') {
			     alert("code : " + request.status + "\r\nmessage : "
			       + request.reponseText + "\r\nerror : " + error);
			    }
		  }
	  });
}
 
$(function(){
	  //$('#audioF').click(function(){
		  //var url = '';
		  
		  $.ajax({
			  type:"GET",
			  url: '/Byod/srchFinishDetailInfo',
			  
			  data : "reportNo=SL_ResultReport_000002",
			  //data: vParam,
			  dataType	: "json",		  
			  cache : false,
	          //ContentType: "application/json",
			  success: function(data) {
				  //alert(data.audio_attch_file_url);
				  //url = data.audio_attch_file_url;
				  
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
		  
          //var url = "file:///C:/attachments/1.01-NEW%20MEN.mp3";    
          //file:///C:/attachments/1.01-NEW%20MEN.mp3
	    //});
});
	


</script>

</head>

<body>
<div id="wrap">
	<div id="userInfoWrap">
		<div id="userInfoDiv">
			<form id="userInfoForm" name="userInfoForm">
				<legend>조사자 등록</legend>
				<div>
					<label for="organization-id">
					 사용자 아이디
					</label>
					<div>
					  <input type="text" id="userId" name="userId" class="form-control" maxlength="50"><br>
					</div>
				</div>
				<div>
					<label for="organization-id">
					 사용자 이름
					</label>
					<div>
					  <input type="text" id="userNm" name="userNm" class="form-control" maxlength="50"><br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						OTG 번호
					</label>
					<div>
					    <input type="text" id="userOtgNo" name="userOtgNo" class="form-control" maxlength="50"> <br>
					</div>
				</div>
				<div class="btn-createOrg" style="text-align: left;">
					<button id="btn-create" class="btn" onclick="fn_insertUser(); return false;">가입</button>
				</div>
			</form>
		</div> 
	</div>
</div>
<div id="wrap">
	<div id="userInfoWrap">
		<div id="userInfoDiv">
			<form id="uploadForm" name="uploadForm" enctype="multipart/form-data">
				<legend>업로드</legend>
				<div>
					<label for="organization-id">
					 reportNo
					</label>
					<div>
					  <input type="text" id="reportNo" name="reportNo" class="form-control" maxlength="50"
					  value="SL_ResultReport_000001"><br>
					</div>
				</div>
				<div>
					<label for="organization-id">
					 userId
					</label>
					<div>
					  <input type="text" id="userId" name="userId" class="form-control" maxlength="50"
					  value="ahnsu234"><br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						networkPath
					</label>
					<div>
					    <input type="text" id="networkPath" name="networkPath" class="form-control" maxlength="50"
					    value="3g"> <br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						locationLat
					</label>
					<div>
					    <input type="text" id="locationLat" name="locationLat" class="form-control" maxlength="50"
					    value="36.428079"> <br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						locationLon
					</label>
					<div>
					    <input type="text" id="locationLon" name="locationLon" class="form-control" maxlength="50"
					    value="127.392783"> <br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						file
					</label>
					<div>
					    <input type="file"  name="sourceFile" class="form-control" maxlength="50" multiple> <br>
					</div>
				</div>
				<div>
					<label for="organization-name">
						file
					</label>
					<div>
					    <input type="file"  name="sourceFile" class="form-control" maxlength="50" multiple> <br>
					</div>
				</div>
				<div class="btn-createOrg" style="text-align: left;">
					<button id="btn-create" class="btn" onclick="fn_upload(); return false;">업로드</button>
				</div>
			</form>
		</div> 
	</div>
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
</body>
</html>