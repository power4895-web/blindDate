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

    @Scheduled(cron = "0 03 00 * * *")
    public void todayRandom() {
        User user = new User();
        List<User> userList = userService.selectUserList();
        for (User item: userList) {
            String todayProfileId = "";
            if(item.getGender().equals("M")) {
                user.setGender("F");
                List<User> manRandomList = userService.selectUserRandomList(user);
                for (User item2: manRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                userService.updateTodayProfileId(user);
            } else {
                user.setGender("M");
                List<User> womanRandomList = userService.selectUserRandomList(user);
                for (User item2: womanRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                userService.updateTodayProfileId(user);
            }
        }
    }

}
