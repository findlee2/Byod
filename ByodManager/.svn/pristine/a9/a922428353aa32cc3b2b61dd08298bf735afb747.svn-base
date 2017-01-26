package slst.byod.api.attchFileManage;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AttchFileManageMapper {
	
	/**
	 * 보고서 업로드 전 첨부파일 아이디 조회(조사자용)
	 * @return
	 */
	public String selectMaxFileId();
	
	/**
	 * 첨부파일 갯수 조회
	 * @param reportNo
	 * @return
	 */
	public int selectReportAndFileCnt(String reportNo);
	
	/**
	 * 첨부파일 업로드(조사자용)
	 * @param srchVO
	 * @return
	 */
	public void insertAttchFile(AttchFileManageVO attchVO);
	

}
