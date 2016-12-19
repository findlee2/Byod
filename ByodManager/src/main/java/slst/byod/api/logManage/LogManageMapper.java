package slst.byod.api.logManage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LogManageMapper {
	
	/**
	 * 조사업무 등록 전 로그 ID 조회
	 * @return
	 */
	public String selectMaxLogId();
	
	/**
	 * 조사업무 등록(관리자용)
	 * @param logVO
	 * @return
	 */
	public int insertRegistBusinessLog(LogManageVO logVO);
	
	/**
	 * 로그 관리-조회(관리자용)
	 * @return
	 */
	public List<LogManageVO> selectAdminAllLogSrchInfoList();
}