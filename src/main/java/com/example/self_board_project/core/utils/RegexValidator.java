package com.example.self_board_project.core.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class RegexValidator {
    
    /**
     * 이메일 형식 valid
     * @param email
     * @return
     */
    public static boolean emailValid(String email) {
        boolean flag = false;
        String regex = "[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\\.)+[a-zA-Z0-9]{2,4}$";
        Matcher matcher = Pattern.compile(regex).matcher(email);
        if(matcher.matches() == true) {
            flag = true;
        }
        return flag;
    }
    
    /**
     * 해시태그 형식 valid
     * @param tag
     * @return
     */
    public static boolean tagValid(String tag) {
        boolean flag = false;
        String regex = "^[a-zA-Z가-힣0-9ㄱ-ㅎ]{1,10}$";
        Matcher matcher = Pattern.compile(regex).matcher(tag);
        if(matcher.matches() == true) {
            flag = true;
        }
        return flag;
    }
    
    /**
     * 이름 형식 valid
     * @param name
     * @return
     */
    public static boolean nameValid(String name) {
        boolean flag = false;
        String regex = "^[가-힣]{2,10}$";
        Matcher matcher = Pattern.compile(regex).matcher(name);
        if(matcher.matches() == true) {
            flag = true;
        }
        return flag;
    }
    
    /**
     * 핸드폰 형식 valid
     * @param phone
     * @return
     */
    public static boolean phoneValid(String phone) {
        boolean flag = false;
        String regex = "^[0-9]{10,11}$";
        Matcher matcher = Pattern.compile(regex).matcher(phone);
        if(matcher.matches() == true) {
            flag = true;
        }
        return flag;
    }
    

}
