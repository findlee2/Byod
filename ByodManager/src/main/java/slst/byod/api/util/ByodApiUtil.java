package slst.byod.api.util;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ByodApiUtil {
	
	/**
	 * 보고서 NO, 로그 ID, 조사장비 ID, 첨부파일 ID 파싱 
	 * @param reportType   1:SL_ResultReport_ , 2:SYSLOG_ , 3:EqupmntID_ , 4:FILE_
	 * @param num          조회되서 넘어온 일련번호
	 * @param indexOfstr   ex)t_ , G_ , D_, E_
	 * @param format       타입에 맞게 자릿수 포맷팅
	 * @return
	 */
	public static String numberParsing(String pType ,String pNum){
		
		String result     = "";
		String reportType = "";
		String format     = "";
		String indexOfstr = "";
		int tmpLogId      = 0;
		int tmpLogIdFmat  = 0;
		
		if(pType.equals("1")){
			reportType = "SL_ResultReport_";
			format     = "%06d";
			indexOfstr = "t_";
		}else if(pType.equals("2")) {
			reportType = "SYSLOG_";
			format     = "%010d";
			indexOfstr = "G_";
		}else if(pType.equals("3")){
			reportType = "EqupmntID_";
			format     = "%06d";
			indexOfstr = "D_";
		}else{
			reportType = "FILE_";
			format     = "%010d";
			indexOfstr = "E_";
		}
		
		if(pNum == null){
			tmpLogIdFmat= 1;
		}else{
			
			tmpLogId = Integer.parseInt(pNum.substring(pNum.indexOf(indexOfstr)+2));
			tmpLogIdFmat= tmpLogId+1;
		}
		
		result = reportType + String.format(format , tmpLogIdFmat);
		
		return result;
	}
	
	/**
	 * 좌표 -> 주소로 파싱(다음 OpenApi)
	 * @param lon
	 * @param lat
	 * @return
	 * @throws ParseException
	 */
	@SuppressWarnings("rawtypes")
	public static String locationParsing(String lon, String lat, String apiKey) throws ParseException{
		
		String rtnStr = "";
		
		if(lon != null){
			
			try {
				
				URL url = new URL("https://apis.daum.net/local/geo/coord2detailaddr?"
						+ "apikey="+apiKey
						+ "&x="+lon
						+ "&y="+lat
						+ "&inputCoordSystem=WGS84"
						+ "&output=json");
				
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Accept", "application/json");
				
				if (conn.getResponseCode() != 200) {
					throw new RuntimeException("Failed : HTTP error code : "
							+ conn.getResponseCode());
				}
				
				JSONParser jsonParser = new JSONParser();
				
				Object obj = jsonParser.parse(new InputStreamReader((conn.getInputStream())));
				
				JSONObject jsonObject = (JSONObject) obj;
				
				rtnStr = ((HashMap) jsonObject.get("new")).get("name").toString();
				
				log.info("Output from Server .... ");
				
				log.info("접속위치 : ["+rtnStr+"]");
				
				conn.disconnect();
				
			} catch (MalformedURLException e) {
				
				e.printStackTrace();
				
			} catch (IOException e) {
				
				e.printStackTrace();
				
			}
			
		}else{
			rtnStr = null;
		}
		
		return rtnStr;
	}
	
	/**
	 * null 체크(null이면 true 리턴)
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(Object s) {
        if (s == null) {
            return true;
        }
        if ((s instanceof String) && (((String)s).trim().length() == 0)) {
            return true;
        }
        if (s instanceof Map) {
            return ((Map<?, ?>)s).isEmpty();
        }
        if (s instanceof List) {
            return ((List<?>)s).isEmpty();
        }
        if (s instanceof Object[]) {
            return (((Object[])s).length == 0);
        }
        return false;
    }
}
