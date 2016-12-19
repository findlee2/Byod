package slst.byod.api.userManage;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserManageMapper {

	/**
	 * 회원가입여부 체크
	 * @param userVO
	 * @return
	 */
	public int selectUserCheck(UserManageVO userVO);
	
	/**
	 * 회원가입
	 * @param userVO
	 * @return
	 */
	public int insertUserInfo(UserManageVO userVO);
	
	/**
	 * 사용자정보조회
	 * @param userVO
	 * @return
	 */
	public UserManageVO selectUserInfo(UserManageVO userVO);
	
	/**
	 * 조사자 수정(관리자용)
	 * @param userVO
	 * @return
	 */
	public int updateAdminSrchUser(UserManageVO userVO);
	
	/**
	 * 조사자 삭제(관리자용)
	 * @param userVO
	 */	
	public void adminUserDelete(UserManageVO userVO);
	
	/**
	 * 조사자 비밀번호 변경(조사자용)
	 * @param userVO
	 */
	public void updateSrchUserPassWord(UserManageVO userVO);
	
	/**
	 * 조사자 정보 조회(관리자용)
	 * @return
	 */
	public List<UserManageVO> selectAdminSrchUserInfoList();
	
	/**
	 * 조사자 정보 상세 조회(관리자용)
	 * @return
	 */
	public UserManageVO selectAdminSrchUserDetailInfo(UserManageVO userVO);
	
	/**
	 * 조사자 승인 및 권한 변경(관리자용)
	 * @param userVO
	 * @return
	 */
	public int updateAdminSrchUserRole(UserManageVO userVO);
	
}
