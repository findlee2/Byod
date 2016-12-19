package slst.byod.api.userManage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import slst.byod.api.logManage.LogManageUtilParsingController;
import slst.byod.api.srchManage.SrchManageVO;
import slst.byod.api.util.UserPwAlgorithm;
@Api(value = "ByodManager API")
@RestController
@RequestMapping(value = "", produces = { "application/json" })
public class UserManageController extends LogManageUtilParsingController{
	@Autowired UserManageMapper userManageMapper;

	/**<<<<<<<<<<<<<<테스트 메소드>>>>>>>>>>>>>>>
	 * 로그인 페이지 화면 호출
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/test/ajaxTest")
	public ModelAndView testView() throws Exception{
		return new ModelAndView("ajaxTest");
	}

	@RequestMapping(value = "/login.do")
	@ResponseBody
	public String members(@RequestParam(value = "id", required = false) String id, @RequestParam(value = "pw", required = false) String pw){
	    
	  UserManageVO userVO             = new UserManageVO();
	  userVO.setUser_id(id);
	  UserManageVO responseBody = userManageMapper.selectUserInfo(userVO);
	  
	  return responseBody.toString();
	}
	/**
	 * <<<<<<<<<<<<<<테스트 메소드>>>>>>>>>>>>>>>
	 */
	
	/**
	 * 로그인(모바일)
	 * @param userId
	 * @param userPw
	 * @param userOtgNo
	 * @param networkPath
	 * @param userLon
	 * @param userLat
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그인(모바일)", notes = "로그인 후 사용자 정보를 조회한다.", response = UserManageVO.class)
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",   	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userPw",      value = "사용자 비밀번호", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userOtgNo",   value = "OTG 번호",    	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "networkPath", value = "단말기 접속경로", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userLon",     value = "단말기위치 경도", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userLat",     value = "단말기위치 위도", 	required = true, dataType = "string", paramType = "query")
	  })	
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/UserMLoginInfo", method = RequestMethod.GET)	
	public ResponseEntity<Object> UserMLoginInfo(@RequestParam("userId") String userId,
											     @RequestParam("userPw") String userPw,
											     @RequestParam("userOtgNo") String userOtgNo,
											     @RequestParam("networkPath") String networkPath,
											     @RequestParam("userLon") String userLon,
											     @RequestParam("userLat") String userLat,
											     HttpServletRequest request) throws Exception {
		
		HttpSession session             = request.getSession();
		UserManageVO userVO             = new UserManageVO();
		UserPwAlgorithm userPwAlgorithm = new UserPwAlgorithm();
		UserManageVO responseBody       = null;
		
		userVO.setUser_id(userId);
		userVO.setUser_otg_no(userOtgNo);
		
		//비밀번호 암호화(단방향 SHA-256)
		userVO.setUser_pw(userPwAlgorithm.UserPwAlgorithm(userPw));
		
		try{
			
			responseBody  = userManageMapper.selectUserInfo(userVO);
			
			if(responseBody == null){
				return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
			}
			session.setAttribute("userVO", responseBody);
			
			UserManageVO UserVO = (UserManageVO)request.getSession().getAttribute("userVO");
			
			/**
			 * [로그생성]
			 * [argument]
			 * 구분 (NotNull)
			      보고서 번호 
			      업무명            
			      보고서 담당자 아이디        
			      보고서 담당자 이름                   
			      최종 보고서 업로드 시간
			      보고서 처리구분
			      단말기 접속경로
			      단말기위치 경도
			      단말기위치 위도
			      처리자 이름(NotNull)
			      처리자 아이디(NotNull)
			 */
			AdminInsertRegistBusinessLog("1",null,null,null,null,null,null, networkPath, 
					userLon, userLat, UserVO.getUser_nm(),UserVO.getUser_id());
		}catch(Exception e){
			e.getStackTrace();			
		}
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 로그아웃(모바일)
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그아웃(모바일)", notes = "로그아웃한다.")
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "networkPath", value = "단말기 접속경로", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userLon",     value = "단말기위치 경도", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userLat",     value = "단말기위치 위도", 	required = true, dataType = "string", paramType = "query")
	  })
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/UserMLoginOut", method = RequestMethod.GET)	
	public ResponseEntity<String> UserMLoginOut( @RequestParam("networkPath") String networkPath,
		     									 @RequestParam("userLon") String userLon,
		     									 @RequestParam("userLat") String userLat,
		     									 HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		UserManageVO UserVO = (UserManageVO)request.getSession().getAttribute("userVO");
		
		/**
		 * [로그생성]
		 * [argument]
		 * 구분 (NotNull)
		      보고서 번호 
		      업무명            
		      보고서 담당자 아이디        
		      보고서 담당자 이름                   
		      최종 보고서 업로드 시간
		      보고서 처리구분
		      단말기 접속경로
		      단말기위치 경도
		      단말기위치 위도
		      처리자 이름(NotNull)
		      처리자 아이디(NotNull)
		 */
		AdminInsertRegistBusinessLog("2",null,null,null,null,null,null, networkPath, 
				userLon, userLat, UserVO.getUser_nm(),UserVO.getUser_id());
		
		session.setAttribute("userVO", null);
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 로그인(웹)
	 * @param userId
	 * @param userPw
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그인(웹)", notes = "로그인 후 사용자 정보를 조회한다.", response = UserManageVO.class)
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",  	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userPw",      value = "사용자 비밀번호", 	required = true, dataType = "string", paramType = "query")
	  })	
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/UserWLoginInfo", method = RequestMethod.GET)	
	public ResponseEntity<Object> UserWLoginInfo(@RequestParam("userId") String userId,
											     @RequestParam("userPw") String userPw,
											     HttpServletRequest request) throws Exception {
		
		HttpSession session             = request.getSession();	
		UserManageVO userVO             = new UserManageVO();
		UserPwAlgorithm userPwAlgorithm = new UserPwAlgorithm();
		UserManageVO responseBody       = null;
		userVO.setUser_id(userId);
		
		//비밀번호 암호화(단방향 SHA-256)
		userVO.setUser_pw(userPwAlgorithm.UserPwAlgorithm(userPw));
		
		try{
			
			responseBody  = userManageMapper.selectUserInfo(userVO);
			
			if(responseBody == null){
				return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
			}
			session.setAttribute("userVO", responseBody);
			
			UserManageVO UserVO = (UserManageVO)request.getSession().getAttribute("userVO");
			
			/**
			 * [로그생성]
			 * [argument]
			 * 구분 (NotNull)
			      보고서 번호 
			      업무명            
			      보고서 담당자 아이디        
			      보고서 담당자 이름                   
			      최종 보고서 업로드 시간
			      보고서 처리구분
			      단말기 접속경로
			      단말기위치 경도
			      단말기위치 위도
			      처리자 이름(NotNull)
			      처리자 아이디(NotNull)
			 */
			AdminInsertRegistBusinessLog("1",null,null,null,null,null,null, null, 
					null, null, UserVO.getUser_nm(),UserVO.getUser_id());
			
		}catch(Exception e){
			e.getStackTrace();			
		}
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 로그아웃(웹)
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그아웃(웹)", notes = "로그아웃한다.")
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/UserWLoginOut", method = RequestMethod.GET)	
	public ResponseEntity<String> UserWLoginOut(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		UserManageVO UserVO = (UserManageVO)request.getSession().getAttribute("userVO");
		
		/**
		 * [로그생성]
		 * [argument]
		 * 구분 (NotNull)
		      보고서 번호 
		      업무명            
		      보고서 담당자 아이디        
		      보고서 담당자 이름                   
		      최종 보고서 업로드 시간
		      보고서 처리구분
		      단말기 접속경로
		      단말기위치 경도
		      단말기위치 위도
		      처리자 이름(NotNull)
		      처리자 아이디(NotNull)
		 */
		AdminInsertRegistBusinessLog("2",null,null,null,null,null,null, null, 
				null, null, UserVO.getUser_nm(),UserVO.getUser_id());
		
		session.setAttribute("userVO", null);
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 조사자등록(관리자용)
	 * @param userId
	 * @param userNm
	 * @param userOtgNo
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 등록(관리자용)", notes = "관리자가 조사자 등록을 한다.(로그를 남길려면 관리자 로그인 후 진행해야한다.)", response = UserManageVO.class)
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",		required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userNm",      value = "사용자 이름",	  	required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userOtgNo",   value = "OTG 번호",  	  	required = false, dataType = "string", paramType = "query")
	  })	
	@ApiResponses(value = {@ApiResponse(code = 409, message = "Conflict(해당 아이디가 이미 존재)")})
	@RequestMapping(value = "/Byod/AdminUserRegist", method = RequestMethod.POST)	
	public ResponseEntity<Object> AdminUserRegist(@RequestParam("userId") String userId,
											      @RequestParam("userNm") String userNm,
											      @RequestParam(value="userOtgNo", required=false) String userOtgNo,
											      HttpServletRequest request) throws Exception {
		
		UserManageVO AdimUserVO         = (UserManageVO)request.getSession().getAttribute("userVO");
		UserManageVO userVO             = new UserManageVO();
		UserPwAlgorithm userPwAlgorithm = new UserPwAlgorithm();
		UserManageVO responseBody       = null;
		String iniPw                    = "1";	//초기 조사자 암호 세팅
		int cnt                         = 0;
		
		
		userVO.setUser_id(userId);
		userVO.setUser_nm(userNm);
		userVO.setUser_otg_no(userOtgNo);
		
		//비밀번호 암호화(단방향 SHA-256)
		userVO.setUser_pw(userPwAlgorithm.UserPwAlgorithm(iniPw));
		
		try{
			cnt= userManageMapper.insertUserInfo(userVO);
			if(cnt > 0){
				responseBody = userManageMapper.selectUserInfo(userVO);
			}
			
			/**
			 * [로그생성]
			 * [argument]
			 * 구분 (NotNull)
			      보고서 번호 
			      업무명            
			      보고서 담당자 아이디        
			      보고서 담당자 이름                   
			      최종 보고서 업로드 시간
			      보고서 처리구분
			      단말기 접속경로
			      단말기위치 경도
			      단말기위치 위도
			      처리자 이름(NotNull)
			      처리자 아이디(NotNull)
			 */
			AdminInsertRegistBusinessLog("6",null,null,responseBody.getUser_id(),responseBody.getUser_nm(),null,null, null, 
					null, null, AdimUserVO.getUser_nm(),AdimUserVO.getUser_id());
			
		}catch(Exception e){
			e.getStackTrace();			
			//rest 또는 curl로 동일한 계정, 동일한 OTG번호를 입력시 체크하여 리턴
			return new ResponseEntity<Object>(HttpStatus.CONFLICT);
		}
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 조사자 수정(관리자용)
	 * @param userId
	 * @param userNm
	 * @param userOtgNo
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 수정(관리자용)", notes = "관리자가 조사자의 정보를 수정한다.(로그를 남길려면 관리자 로그인 후 진행해야한다.)", response = UserManageVO.class)
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",		required = true,   dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userNm",      value = "사용자 이름",	  	required = false,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userAppveYn", value = "사용자 승인여부",	required = false,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userRole",    value = "사용자 권한",	  	required = false,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userOtgNo",   value = "OTG 번호",  	  	required = false,  dataType = "string", paramType = "query")
	  })	
	@RequestMapping(value = "/Byod/AdminUserUpdate", method = RequestMethod.PUT)	
	public ResponseEntity<Object> AdminUserUpdate(@RequestParam("userId") String userId,
											         @RequestParam(value="userNm" , required=false) String userNm,
											         @RequestParam(value="userAppveYn" , required=false) String userAppveYn,
											         @RequestParam(value="userRole" , required=false) String userRole,
											         @RequestParam(value="userOtgNo", required=false) String userOtgNo,
											         HttpServletRequest request) throws Exception {
		
		UserManageVO AdimUserVO         = (UserManageVO)request.getSession().getAttribute("userVO");
		UserManageVO userVO             = new UserManageVO();
		UserManageVO responseBody       = null;
		int cnt                         = 0;
		
		userVO.setUser_id(userId);
		userVO.setUser_nm(userNm);
		userVO.setUser_appve_yn(userAppveYn);
		userVO.setUser_role(userRole);
		userVO.setUser_otg_no(userOtgNo);
		
		try{
			cnt= userManageMapper.updateAdminSrchUser(userVO);
			if(cnt > 0){
				responseBody = userManageMapper.selectUserInfo(userVO);
			}
			
			/**
			 * [로그생성]
			 * [argument]
			 * 구분 (NotNull)
			      보고서 번호 
			      업무명            
			      보고서 담당자 아이디        
			      보고서 담당자 이름                   
			      최종 보고서 업로드 시간
			      보고서 처리구분
			      단말기 접속경로
			      단말기위치 경도
			      단말기위치 위도
			      처리자 이름(NotNull)
			      처리자 아이디(NotNull)
			 */
			AdminInsertRegistBusinessLog("8",null,null,responseBody.getUser_id(),responseBody.getUser_nm(),null,null, null, 
					null, null, AdimUserVO.getUser_nm(),AdimUserVO.getUser_id());
			
		}catch(Exception e){
			e.getStackTrace();			
			return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 조사자삭제(관리자용)
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 삭제(관리자용)", notes = "관리자가 조사자를 삭제를 한다.(로그를 남길려면 관리자 로그인 후 진행해야한다.)")
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",		required = true,  dataType = "string", paramType = "query")
	  })	
	@RequestMapping(value = "/Byod/AdminUserDelete", method = RequestMethod.DELETE)	
	public ResponseEntity<String> AdminUserDelete(@RequestParam("userId") String userId,
														HttpServletRequest request ) throws Exception {
		
		UserManageVO AdimUserVO         = (UserManageVO)request.getSession().getAttribute("userVO");
		UserManageVO userVO             = new UserManageVO();
		
		userVO.setUser_id(userId);
		
		try{
			
			UserManageVO rtnUserVO = userManageMapper.selectUserInfo(userVO);
			
			userManageMapper.adminUserDelete(rtnUserVO);
			
			/**
			 * [로그생성]
			 * [argument]
			 * 구분 (NotNull)
			      보고서 번호 
			      업무명            
			      보고서 담당자 아이디        
			      보고서 담당자 이름                   
			      최종 보고서 업로드 시간
			      보고서 처리구분
			      단말기 접속경로
			      단말기위치 경도
			      단말기위치 위도
			      처리자 이름(NotNull)
			      처리자 아이디(NotNull)
			 */
			AdminInsertRegistBusinessLog("7",null,null,rtnUserVO.getUser_id(),rtnUserVO.getUser_nm(),null,null, null, 
					null, null, AdimUserVO.getUser_nm(),AdimUserVO.getUser_id());
			
		}catch(Exception e){
			e.getStackTrace();
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}

	/**
	 * 중복아이디 체크(관리자용)
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "중복아이디체크(관리자용)", notes = "중복아이디체크를 한다.", response = UserManageVO.class)
	@ApiImplicitParam(name = "userId",   value = "사용자 아이디", required = true, dataType = "string", paramType = "query")
	@ApiResponses(value = {@ApiResponse(code = 409, message = "Conflict(해당 아이디가 이미 존재)")})
	@RequestMapping(value = "/Byod/AdminUserRegMemberDuplCheck", method = RequestMethod.GET)
	public ResponseEntity<String> AdminUserRegMemberDuplCheck(@RequestParam("userId") String userId) throws Exception {
		
		UserManageVO userVO = new UserManageVO();
		
		userVO.setUser_id(userId);
		int cnt = 0;
		
		cnt = userManageMapper.selectUserCheck(userVO);
		
		if(cnt > 0){
			//해당 아이디가 이미 존재
			return new ResponseEntity<String>(HttpStatus.CONFLICT);		
		}
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 조사자 비밀번호 변경(조사자용)
	 * @param userId
	 * @param userOldPw
	 * @param userNewPw
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 비밀번호 변경(조사자용)", notes = "조사자 비밀 번호를 변경한다.")
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",      value = "사용자 아이디",      	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userOldPw",   value = "사용자 기존 비밀번호", 	required = true, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userNewPw",   value = "사용자 신규 비밀번호", 	required = true, dataType = "string", paramType = "query")
	  })	
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/SrchUserPassWordUpdate", method = RequestMethod.PUT)	
	public ResponseEntity<String> SrchUserPassWordUpdate(@RequestParam("userId") String userId,
											             @RequestParam("userOldPw") String userOldPw,
											             @RequestParam("userNewPw") String userNewPw) throws Exception {
		
		UserManageVO userVO             = new UserManageVO();
		UserPwAlgorithm userPwAlgorithm = new UserPwAlgorithm();
		
		userVO.setUser_id(userId);
		
		//비밀번호 암호화(단방향 SHA-256)
		userVO.setUser_pw(userPwAlgorithm.UserPwAlgorithm(userOldPw));
		
		try{
			
			//기존 비밀번호 체크
			UserManageVO reUserVO  = userManageMapper.selectUserInfo(userVO);
			
			if(reUserVO !=null){
				//기존 패스워드가 인증시 신규 비밀번호로 변경
				userVO.setUser_pw(userPwAlgorithm.UserPwAlgorithm(userNewPw));
				userManageMapper.updateSrchUserPassWord(userVO);
				
				/**
				 * [로그생성]
				 * [argument]
				 * 구분 (NotNull)
				      보고서 번호 
				      업무명            
				      보고서 담당자 아이디        
				      보고서 담당자 이름                   
				      최종 보고서 업로드 시간
				      보고서 처리구분
				      단말기 접속경로
				      단말기위치 경도
				      단말기위치 위도
				      처리자 이름(NotNull)
				      처리자 아이디(NotNull)
				 */
				AdminInsertRegistBusinessLog("4",null,null,reUserVO.getUser_id(),reUserVO.getUser_nm(),null,null, null, 
						null, null, reUserVO.getUser_nm(),reUserVO.getUser_id());
				
			}else{
				return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
		}catch(Exception e){
			e.getStackTrace();			
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 조사자 정보 목록 조회(관리자용)
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 정보 목록 조회(관리자용)", notes = "관리자가 조사자들의 정보목록을 조회 한다.", response = UserManageVO.class)
	@RequestMapping(value = "/Byod/AdminSrchUserInfoList", method = RequestMethod.GET)
	public ResponseEntity<Object> AdminSrchUserInfoList() throws Exception {
		
		List<SrchManageVO> responseBody = userManageMapper.selectAdminSrchUserInfoList();
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 조사자 승인 및 정보 변경(관리자용)
	 * @param userId
	 * @param user_appve_yn
	 * @param user_role
	 * @param userOtgNo
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 승인 및 정보 변경(관리자용)", notes = "관리자가 해당 조사자를 승인 및 정보 변경한다.(로그를 남길려면 관리자 로그인 후 진행해야한다.)", response = UserManageVO.class)
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "userId",       value = "사용자 아이디", 	required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userAppveYn",  value = "승인여부",    	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userRole",     value = "권한",       	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userOtgNo",    value = "OTG 번호",    	required = false, dataType = "string", paramType = "query")	    
	  })	
	@ApiResponses(value = {@ApiResponse(code = 400, message = "Bad Request")})
	@RequestMapping(value = "/Byod/AdminSrchUserRoleUpdate", method = RequestMethod.PUT)	
	public ResponseEntity<Object> AdminSrchUserRoleUpdate(@RequestParam("userId") String userId,
											          @RequestParam(value="userAppveYn",required=false) String userAppveYn,
											          @RequestParam(value="userRole",required=false) String userRole,
											          @RequestParam(value="userOtgNo",required=false) String userOtgNo,
											          HttpServletRequest request) throws Exception {
		
		UserManageVO AdimUserVO    = (UserManageVO)request.getSession().getAttribute("userVO");
		UserManageVO userVO        = new UserManageVO();
		UserManageVO reUserVO      = null;
		int cnt                    = 0;

		
		userVO.setUser_id(userId);
		userVO.setUser_appve_yn(userAppveYn);
		userVO.setUser_role(userRole);
		userVO.setUser_otg_no(userOtgNo);
		
		userManageMapper.updateAdminSrchUser(userVO);
		
		try{
			cnt= userManageMapper.updateAdminSrchUserRole(userVO);
			if(cnt < 1){
				return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
			}else{
				
				reUserVO  = userManageMapper.selectUserInfo(userVO);
				
				/**
				 * [로그생성]
				 * [argument]
				 * 구분 (NotNull)
				      보고서 번호 
				      업무명            
				      보고서 담당자 아이디        
				      보고서 담당자 이름                   
				      최종 보고서 업로드 시간
				      보고서 처리구분
				      단말기 접속경로
				      단말기위치 경도
				      단말기위치 위도
				      처리자 이름(NotNull)
				      처리자 아이디(NotNull)
				 */
				AdminInsertRegistBusinessLog("5",null,null,reUserVO.getUser_id(),reUserVO.getUser_nm(),null,null, null, 
						null, null, AdimUserVO.getUser_nm(),AdimUserVO.getUser_id());
				
			}
			
		}catch(Exception e){
			e.getStackTrace();
			return new ResponseEntity<Object>(reUserVO, HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<Object>(reUserVO, HttpStatus.OK);
	}

}
