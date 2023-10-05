package com.example.self_board_project.user.service;

import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class userBatchService {
    @Autowired
    private UserService userService;
// @Scheduled(cron = "0 15 10 15 11 ?") // 11월 15일 오전 10시 15분에 실행

    /**
     * 랜덤으로 오늘의 프로필 배치
     * 친구해요, 평가안한 이성만
     * service메소드에 빈 user를 넘기는 이유는 todayProfile에 로그인한 회원이 들어갔는데 혹시라도
     * todayprofile이 업데이트 되지 않았을 시 로그인한 user정보로 강제 randomid를 부여해주는 로직이 있기 때문
     */
    @Scheduled(cron = "0 03 00 * * *") //매일 오전 00 시 03분에 돈다
    public void todayRandomBatch() {
        User user = new User();
        userService.todayRandom(user);
    }
}
