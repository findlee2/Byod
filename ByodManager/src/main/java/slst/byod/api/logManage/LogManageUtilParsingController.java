package slst.byod.api.logManage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;
import slst.byod.api.util.ByodApiUtil;

@Api(value = "ByodManager API")
@RestController
@RequestMapping(value = "", produces = { "application/json" })
public class LogManageUtilParsingController {
	@Autowired LogManageMapper logManageMapper;
	
	@Value("${daumApiKey}")
	String daumApiKey;
	
	/**
	 * 조사업무 등록 전 로그ID 조회(관리자용)
	 * @return
	 * @throws Exception
	 */
	public String AdminBeforeRegistBusinessNoSrch(String type) throws Exception {

		
		String tmpResult     = "";
		String responseBody  = "";
		
		tmpResult = logManageMapper.selectMaxLogId();
		
		System.out.println("tmpResult::::"+tmpResult);
		
		//타입 1:보고서, 2:로그
		responseBody = ByodApiUtil.numberParsing(type, tmpResult);
		
		System.out.println("responseBody::::"+responseBody);
		
		return responseBody;
	}
	
	
	/**
	 * 조사업무 등록 로그 생성(관리자용)
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void AdminInsertRegistBusinessLog(String logGb, String reportNo,
			String businessNm,     String userId,       String userNm,
			String reportUploadTm, String reportStatus,	String networkPath,
			String userLon,        String userLat,      String disposeUserNm, String disposeUserId) throws Exception {

		LogManageVO logVO = new LogManageVO();
		
		logVO.setLog_id(AdminBeforeRegistBusinessNoSrch("2"));
		logVO.setLog_gb(logGb);
		logVO.setReport_no(reportNo);
		logVO.setBusiness_nm(businessNm);
		logVO.setUser_id(userId);
		logVO.setUser_nm(userNm);
		logVO.setReport_upload_tm(reportUploadTm);
		logVO.setReport_status(reportStatus);
		logVO.setNetwork_path(networkPath);
		logVO.setAccess_loctn(ByodApiUtil.locationParsing(userLon,userLat,daumApiKey));
		logVO.setDispose_user_nm(disposeUserNm);
		logVO.setDispose_user_id(disposeUserId);
			
		logManageMapper.insertRegistBusinessLog(logVO);
	}
	
}
