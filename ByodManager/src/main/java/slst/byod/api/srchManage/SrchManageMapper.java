package slst.byod.api.srchManage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SrchManageMapper {
	
	/**
	 * 조사업무리스트 조회(조사자용)
	 * @param srchVO
	 * @return
	 */
	public List<SrchManageVO> selectSrchInfoList(SrchManageVO srchVO);
	
	/**
	 * 조사업무 상세 조회(조사자용 및 관리자용)
	 * @param srchVO
	 * @return
	 */
	public SrchManageVO selectSrchDetailInfo(SrchManageVO srchVO);
	
	/**
	 * 조사업무 목록 조회(관리자용)
	 * @return
	 */
	public List<SrchManageVO> selectUserSrchInfoList();
	
	/**
	 * 조사업무 등록 전 보고서 번호 조회(관리자용)
	 * @return
	 */
	public String selectMaxReportNo();
	
	/**
	 * 조사업무 등록(관리자용)
	 * @param srchVO
	 * @return
	 */
	public void insertRegistBusiness(SrchManageVO srchVO);
	
	/**
	 * 조사업무 수정(관리자용)
	 * @param srchVO
	 */
	public void updateBusiness(SrchManageVO srchVO);
	
	/**
	 * 조사업무 삭제(공통 또는 관리자용)
	 * @param srchVO
	 */
	public void deleteSrchInfoList(SrchManageVO srchVO);
	
	/**
	 * 보고서 업로드(조사자용)
	 * @param srchVO
	 */
	public void updateReportUpload(SrchManageVO srchVO);
	
	/**
	 * 완료된 조사업무 목록 조회(조사자용)
	 * @param srchVO
	 * @return
	 */
	public List<SrchManageVO> selectSrchFinishInfoList(SrchManageVO srchVO);
	
	/**
	 * 완료된 조사업무 상세 조회(조사자용)
	 * @param srchVO
	 * @return
	 */
	public SrchManageVO selectSrchFinishDetailInfo(SrchManageVO srchVO);
	
	
}
