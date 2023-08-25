package com.example.self_board_project.core.utils;

public class VariableValidtor {
    
    /**
     * 숫자인지 확인
     * @param str
     * @return
     */
    public static boolean isNumber(String str) {
        boolean flag = true;
        try {
            Integer.parseInt(str);
        } catch(Exception e) {
            flag = false;
        }
        return flag;
    }

    
    /**
     * 문자 null 혹은 "", " "체크하기
     * @param str
     * @return
     */
    public static boolean isNullString(String str) {
        boolean flag = true;
        if(str == null) {
            flag = false;
        }
        if(str.trim().length() == 0) {
            flag = false;
        }
        return flag;
    }
}
