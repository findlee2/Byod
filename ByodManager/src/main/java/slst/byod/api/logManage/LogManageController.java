package slst.byod.api.logManage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import slst.byod.api.util.Base64Utils;

@Api(value = "Log manage API")
@RestController
@RequestMapping(value = "", produces = { "application/json" })
public class LogManageController {
	@Autowired LogManageMapper logManageMapper;
	
	@Value("${Globals.RoundKey}")
	private String RoundKey;
	
	Base64Utils base64 = new Base64Utils();
	
	/**
	 * 로그 관리-조회(관리자용)
	 * @param reportNo
	 * @return
	 * @throws Exception
	 */
	@ApiOperation(value = "로그 관리-조회(관리자용)", notes = "관리자가 로그 관리 메뉴에서 전체 로그를 조회한다.", response = LogManageVO.class)
	@RequestMapping(value = "/Byod/adminAllLogSrchInfoList", method = RequestMethod.GET)
	public ResponseEntity<Object> adminAllLogSrchInfoList() throws Exception {
		
		List<LogManageVO> responseBody = logManageMapper.selectAdminAllLogSrchInfoList();

		for(int i=0; i<responseBody.size(); i++){
			responseBody.get(i).setBusiness_nm(base64.decrypt(responseBody.get(i).getBusiness_nm(), RoundKey));
			responseBody.get(i).setUser_nm(base64.decrypt(responseBody.get(i).getUser_nm(), RoundKey));
			responseBody.get(i).setAccess_loctn(base64.decrypt(responseBody.get(i).getAccess_loctn(), RoundKey));
			responseBody.get(i).setDispose_user_nm(base64.decrypt(responseBody.get(i).getDispose_user_nm(), RoundKey));
		}
		
		return new ResponseEntity<Object>(responseBody, HttpStatus.OK);
	}
}
