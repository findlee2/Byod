package slst.byod.api.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

public class UserPwAlgorithm {
	
	public String UserPwAlgorithm(String userPw) throws NoSuchAlgorithmException{
		
		byte[] hashValue = null; // 해쉬값
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		
		md.reset();
		
		hashValue = md.digest(userPw.getBytes());
		
		return new String(Base64.encodeBase64(hashValue));
	}
}
