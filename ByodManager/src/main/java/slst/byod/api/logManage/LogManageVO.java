package slst.byod.api.logManage;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Data;

@Data
@JsonInclude(Include.NON_NULL)
public class LogManageVO {
	private String log_id;	            //로그 아이디 
	private String log_gb;	            //구분
	private String report_no;	        //보고서 번호 
	private String business_nm;	        //업무명            
	private String user_id;	            //담당자 아이디        
	private String user_nm;	            //담당자 이름                   
	private String dispose_tm;	        //처리시간
	private String report_upload_tm;	//최종 보고서 업로드 시간
	private String report_status;	    //보고서 처리구분	
	private String network_path;	    //단말기 접속경로
	private String access_loctn;        //단말기 접속 위치
	private String dispose_user_nm;	    //처리자 이름
	private String dispose_user_id;	    //처리자 아이디
	private String location_lat;	    //조사자 접속위도
	private String location_lon;	    //조사자 접속경도
}
