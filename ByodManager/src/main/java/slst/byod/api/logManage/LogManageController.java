package slst.byod.api.logManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import slst.byod.api.srchManage.SrchManageVO;
import slst.byod.api.util.ByodApiUtil;

@Api(value = "Log manage API")
@RestController
@RequestMapping(value = "", produces = { "application/json" })
public class LogManageController {
	@Autowired LogManageMapper logManageMapper;
	
	
	/**
	 * 로그 관리-조회(관리자용)
	 * @param reportNo
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그 관리-조회(관리자용)", notes = "관리자가 로그 관리 메뉴에서 전체 로그를 조회한다.", response = LogManageVO.class)
	@RequestMapping(value = "/Byod/AdminAllLogSrchInfoList", method = RequestMethod.GET)
	public ResponseEntity<Object> AdminAllLogSrchInfoList() throws Exception {
		
		List<LogManageVO> responseBody = logManageMapper.selectAdminAllLogSrchInfoList();

		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
}
