package com.example.self_board_project.core.tld;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class ElCustom {
    static Logger logger = LoggerFactory.getLogger(ElCustom.class);

    // Date형식의 데이터를 (1초전, 1분, 1시간전... 형식으로)가공
    public static String dateConverter(Date date) throws Exception {
        // 1. SimpleDateFormat 객체 초기화
        /** String >> Date 형식으로 변환하기 위해 "yyyy-MM-dd HH:mm:ss"의 형식으로 변환한다. */
        SimpleDateFormat recvSimpleFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH); // kst
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
        // 2. SimpleDateFormat.parse(String date) >> Date형식으로 변환
        Date tmp = recvSimpleFormat.parse(date.toString()); // kst
        String tmp2 = sdf.format(tmp); // kst
        Date regDate = sdf.parse(tmp2); // kst
        Date now = new Date();

        // 3. 현재시간.getTime() - DB에서 받아온 시간.getTime()을 이용해 밀리세컨즈로 변환
        long calMilisecond = now.getTime() - regDate.getTime();
        long calSecond = calMilisecond / 1000;
        long calMinute = calMilisecond / (60 * 1000);
        long calHour = calMilisecond / (60 * 60 * 1000);
        long calDay = calMilisecond / (24 * 60 * 60 * 1000);
        long calMonth = calMilisecond / (24 * 60 * 60 * 1000) / 30;
        long calYear = calMilisecond / (24 * 60 * 60 * 1000) / 365;

//        logger.info(calMilisecond + "밀리초 차이");
//        logger.info(calSecond + "초 차이");
//        logger.info(calMinute + "분 차이");
//        logger.info(calHour + "시간 차이");
//        logger.info(calDay + "일 차이");
//        logger.info(calMonth + "개월 차이");
//        logger.info(calYear + "년 차이");
        
        /**
         * 60초 미만 이라면 초로 표현
         * 60분 미만 이라면 분으로 표현 
         * 24시간 미만 이라면 시간으로 표현 
         * 31일 미만 이라면 일로 표현(1개월을 30일로 둘지?) 
         * 365일 미만 이라면 개월로 표현 (애매함 - 윤년 기준을 어떻게 세워야할지 모르겠음)
         */
        
        String result = "";
        if(calSecond < 0) {
            result = "방금 전";
        } else if (calSecond >= 0 && calSecond < 60) {
            //result = calSecond + "초 전";
            result = "방금 전";
        } else if (calSecond >= 60 && calMinute < 60) {
            result = calMinute + "분 전";
        } else if (calMinute >= 60 && calHour < 24) {
            result = calHour + "시간 전";
        } else if (calHour >= 24 && calDay < 30) {
            result = calDay + "일 전";
        } else if (calDay >= 30 && calDay < 365) {
            result = calMonth + "개월 전";
        } else {
            result = calYear + "년 전";
        }

        return result;
    }
    
    public static String dateConverter2(Date date) throws Exception {
        // 1. SimpleDateFormat 객체 초기화
        /** String >> Date 형식으로 변환하기 위해 "yyyy-MM-dd HH:mm:ss"의 형식으로 변환한다. */
        SimpleDateFormat recvSimpleFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH); // kst
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH);
        // 2. SimpleDateFormat.parse(String date) >> Date형식으로 변환
        Date formatDate = recvSimpleFormat.parse(date.toString()); // kst
        Date regDate = sdf.parse(sdf.format(formatDate)); 
        Date now = new Date();

        // 3. 현재시간.getTime() - DB에서 받아온 시간.getTime()을 이용해 밀리세컨즈로 변환
        long calMilisecond = now.getTime() - regDate.getTime();
        long calSecond = calMilisecond / 1000;
        long calMinute = calMilisecond / (60 * 1000);
        long calHour = calMilisecond / (60 * 60 * 1000);
//        long calDay = calMilisecond / (24 * 60 * 60 * 1000);
//        long calMonth = calMilisecond / (24 * 60 * 60 * 1000) / 30;
//        long calYear = calMilisecond / (24 * 60 * 60 * 1000) / 365;

//        logger.info(calMilisecond + "밀리초 차이");
//        logger.info(calSecond + "초 차이");
//        logger.info(calMinute + "분 차이");
//        logger.info(calHour + "시간 차이");
//        logger.info(calDay + "일 차이");
//        logger.info(calMonth + "개월 차이");
//        logger.info(calYear + "년 차이");
        
        /**
         * 60초 미만 이라면 초로 표현
         * 60분 미만 이라면 분으로 표현 
         * 24시간 미만 이라면 시간으로 표현 
         * 31일 미만 이라면 일로 표현(1개월을 30일로 둘지?) 
         * 365일 미만 이라면 개월로 표현 (애매함 - 윤년 기준을 어떻게 세워야할지 모르겠음)
         */
        
        String result = "";
        if(calSecond < 0) {
            result = "방금전";
        } else if (calSecond >= 0 && calSecond < 60) {
            //result = calSecond + "초 전";
            result = "방금전";
        } else if (calSecond >= 60 && calMinute < 60) {
            result = calMinute + "분전";
        } else if (calMinute >= 60 && calHour < 24) {
            result = calHour + "시간전";
        } else {
            SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM.dd", Locale.ENGLISH);
            String tmp = sdf2.format(regDate);
            String tmpArray[] = tmp.toString().split("-");
            StringBuffer sb = new StringBuffer(tmpArray[0]);
            sb.append("<span>");
            sb.append(tmpArray[1]);
            sb.append("</span>");
            result = sb.toString();
        }

        return result;
    }
}
