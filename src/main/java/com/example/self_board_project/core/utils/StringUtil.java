package com.example.self_board_project.core.utils;

import java.io.UnsupportedEncodingException;
import java.text.StringCharacterIterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	
	/**
	 * 특수문자 제거
	 * @param str
	 * @return
	 */
	public static String specialCharacterRemove(String str) {
		String match = "[^\uAC00-\uD7A3xfe0-9a-zA-Z0-9\\s-,]";
		str = str.replaceAll(match, "");
		return str;
	}
	
	/**
	 * 정규식 체크
	 * @param pattern
	 * @param str
	 * @return
	 */
	public static boolean isRegex(String pattern, String str) {
		if(str == null) return false;
		Pattern p = Pattern.compile(pattern);
		Matcher m = p.matcher(str);
		return m.find();
		
	}
	
	/**
	 * 숫자 체크
	 * @param pattern
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		if(str == null) return false;
		return isRegex("^[0-9]+$", str);
	}
    
	/**
	  * 문자열 자르기
	  * @param value
	  * @param numBytes
	  * @param charset UTF-8
	  * @return
	  */
	public static String strlen(String value, int numBytes, String charset) {
      do {
          byte[] valueInBytes = null;
          try {
              valueInBytes = value.getBytes(charset);
          } catch (UnsupportedEncodingException e) {
              throw new RuntimeException(e.getMessage(), e);
          }
          if (valueInBytes.length > numBytes) {
              value = value.substring(0, value.length() - 1);
          } else {
              return value;
          }
      } while (value.length() > 0);
      return "";
  }

	
	/**
	 * 문자열 자르기(UTF-8 글자수로 자르기)
	 * </pre>
	 * @param str
	 * @param len
	 * @param tail
	 * @return
	 */
	public static String strlenUTF(String str, int len,String tail){
		if( str.length() <= len){
			return str;
		}
		StringCharacterIterator sci = new StringCharacterIterator(str);
		StringBuffer buffer = new StringBuffer();
		buffer.append(sci.first());
		for(int i=1; i<len ; i++){
			if( i < len-1){
				buffer.append(sci.next());
			}else{
				char c=sci.next();
				if(c != 32){ //마지막 charater가 공백이 아닐경우
					buffer.append(c);
				}
			}
		}	
		buffer.append(tail);
		return buffer.toString();
	}
	
	/**
     * 문자열  트림 
     * @param str
     * @return
     */
	public static String trim(String str) {
	    return null == str ? null : str.trim();
	}
}