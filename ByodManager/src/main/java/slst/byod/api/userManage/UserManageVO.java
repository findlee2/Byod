package slst.byod.api.userManage;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Data;

@Data
@JsonInclude(Include.NON_NULL)
public class UserManageVO {
	private String user_id;        //사용자 아이디
	private String user_nm;        //사용자 이름
	private String user_pw;        //사용자 비밀번호
	private String user_appve_yn;  //사용자 승인여부
	private String user_reg_dt;    //사용자 가입일자
	private String user_role;      //사용자 권한
	private String user_otg_no;    //OTG 번호
	
}
