package slst.byod.api.srchEqupmntManage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SrchEqupmntManageMapper {
	
	/**
	 * 조사장비 등록 전 장비 ID 조회
	 * @return
	 */
	public String selectMaxEqupmntId();
	
	/**
	 * 조사장비조회(관리자용)
	 * @return
	 */
	public List<SrchEqupmntManageVO> selectAdminSrchEqupmntInfoList();
	
	/**
	 * 조사장비 등록(관리자용)
	 * @param equpmntVO
	 */
	public void insertAdminSrchEqupmnt(SrchEqupmntManageVO equpmntVO);
	
	/**
	 * 조사장비 수정(관리자용)
	 * @param equpmntVO
	 */
	public void updateAdminSrchEqupmnt(SrchEqupmntManageVO equpmntVO);
	
	/**
	 * 조사장비 삭제(관리자용)
	 * @param equpmntVO
	 */
	public void deleteSrchEqupmnt(SrchEqupmntManageVO equpmntVO);
}
