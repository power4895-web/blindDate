package com.example.self_board_project.user.service;

import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class userBatchService {
    @Autowired
    private UserService userService;
// @Scheduled(cron = "0 15 10 15 11 ?") // 11월 15일 오전 10시 15분에 실행


    @Scheduled(cron = "0 03 00 * * *") //매일 오전 00 시 03분에 돈다
    public void todayRandomBatch() {
        User user = new User();
        userService.todayRandom(user);
    }
}
