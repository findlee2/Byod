package slst.byod.api.srchEqupmntManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import slst.byod.api.util.ByodApiUtil;

@Api(value = "ByodManager API")
@RestController
@RequestMapping(value = "", produces = { "application/json" })
public class SrchEqupmntManageController {
	@Autowired SrchEqupmntManageMapper srchEqupmntManageMapper;
	
	
	/**
	 * 조사장비조회(관리자용)
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사장비조회(관리자용)", notes = "관리자가 조사장비 조회를한다.", response = SrchEqupmntManageVO.class)
	@RequestMapping(value = "/Byod/AdminSrchEqupmntInfoList", method = RequestMethod.GET)
	public ResponseEntity<Object> AdminSrchEqupmntInfoList() throws Exception {
		
		List<SrchEqupmntManageVO> responseBody = srchEqupmntManageMapper.selectAdminSrchEqupmntInfoList();

		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
	
	/**
	 * 조사장비 등록(관리자용)
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사장비 등록(관리자용)", notes = "관리자가 조사장비를 등록한다.")
	@ApiImplicitParams({
	    @ApiImplicitParam(name = "srchEqupmntIdentiNo", value = "조사장비 고유번호",	required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "srchEqupmntKind",     value = "조사장비 종류",	  	required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userNm",   			value = "사용자 이름",  	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userId",      		value = "사용자 아이디",	  	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "useYn",      			value = "사용여부",	  	required = false, dataType = "string", paramType = "query")
	  })
	@ApiResponses(value = {@ApiResponse(code = 409, message = "Conflict(해당 장비가 이미 존재)")})
	@RequestMapping(value = "/Byod/AdminSrchEqupmntRegist", method = RequestMethod.POST)
	public ResponseEntity<String> AdminSrchEqupmntRegist(@RequestParam("srchEqupmntIdentiNo") String srchEqupmntIdentiNo,
														 @RequestParam("srchEqupmntKind") String srchEqupmntKind,
														 @RequestParam(value="userNm", required=false) String userNm,
														 @RequestParam(value="userId", required=false) String userId,
														 @RequestParam(value="useYn", required=false) String useYn) throws Exception {
		
		SrchEqupmntManageVO equpmntVO  = new SrchEqupmntManageVO();
		String equpmntId               = "";
		
		//조사장비 max ID 조회
		equpmntId = srchEqupmntManageMapper.selectMaxEqupmntId();
		
		equpmntVO.setSrch_equpmnt_id(ByodApiUtil.numberParsing("3",equpmntId));
		equpmntVO.setSrch_equpmnt_identi_no(srchEqupmntIdentiNo);
		equpmntVO.setSrch_equpmnt_kind(srchEqupmntKind);
		equpmntVO.setUser_nm(userNm);
		equpmntVO.setUser_id(userId);
		equpmntVO.setUse_yn(useYn);
		
		try{
			
			srchEqupmntManageMapper.insertAdminSrchEqupmnt(equpmntVO);
			
		}catch(Exception e){
			e.getStackTrace();
			return new ResponseEntity<String>(HttpStatus.CONFLICT);
		}

		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 조사장비 수정(관리자용)
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사장비 수정(관리자용)", notes = "관리자가 조사장비를 수정한다.")
	@ApiImplicitParams({
		@ApiImplicitParam(name = "srchEqupmntId",       value = "조사장비 고유번호",	required = true,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "srchEqupmntIdentiNo", value = "조사장비 고유번호",	required = false,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "srchEqupmntKind",     value = "조사장비 종류",	  	required = false,  dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userNm",   			value = "사용자 이름",  	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "userId",      		value = "사용자 아이디",	  	required = false, dataType = "string", paramType = "query"),
	    @ApiImplicitParam(name = "useYn",      			value = "사용여부",	  	required = false, dataType = "string", paramType = "query")
	  })
	@ApiResponses(value = {@ApiResponse(code = 409, message = "Conflict(해당 장비가 이미 존재)")})
	@RequestMapping(value = "/Byod/AdminSrchEqupmntUpdate", method = RequestMethod.PUT)
	public ResponseEntity<String> AdminSrchEqupmntUpdate(@RequestParam("srchEqupmntId") String srchEqupmntId,
														 @RequestParam(value="srchEqupmntIdentiNo", required=false) String srchEqupmntIdentiNo,
														 @RequestParam(value="srchEqupmntKind", required=false) String srchEqupmntKind,
														 @RequestParam(value="userNm", required=false) String userNm,
														 @RequestParam(value="userId", required=false) String userId,
														 @RequestParam(value="useYn", required=false) String useYn) throws Exception {
		
		SrchEqupmntManageVO equpmntVO  = new SrchEqupmntManageVO();
		
		equpmntVO.setSrch_equpmnt_id(srchEqupmntId);
		equpmntVO.setSrch_equpmnt_identi_no(srchEqupmntIdentiNo);
		equpmntVO.setSrch_equpmnt_kind(srchEqupmntKind);
		equpmntVO.setUser_nm(userNm);
		equpmntVO.setUser_id(userId);
		equpmntVO.setUse_yn(useYn);
		
		try{
			
			srchEqupmntManageMapper.updateAdminSrchEqupmnt(equpmntVO);
			
		}catch(Exception e){
			e.getStackTrace();
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return new ResponseEntity<String>(HttpStatus.OK);
	}
	
	/**
	 * 조사자 장비 삭제(관리자용)
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "조사자 장비 삭제(관리자용)", notes = "관리자가 조사장비를 삭제한다.")
	@ApiImplicitParams({
		@ApiImplicitParam(name = "srchEqupmntId", value = "조사장비 고유번호",	required = true,  dataType = "string", paramType = "query")
	  })	
	@RequestMapping(value = "/Byod/AdminSrchEqupmntDelete", method = RequestMethod.DELETE)	
	public ResponseEntity<String> AdminSrchEqupmntDelete(@RequestParam("srchEqupmntId") String srchEqupmntId) throws Exception {
		
		SrchEqupmntManageVO equpmntVO  = new SrchEqupmntManageVO();
		
		equpmntVO.setSrch_equpmnt_id(srchEqupmntId);
		
		try{
			
			srchEqupmntManageMapper.deleteSrchEqupmnt(equpmntVO);
			
		}catch(Exception e){
			e.getStackTrace();
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<String>(HttpStatus.OK);
	}
}