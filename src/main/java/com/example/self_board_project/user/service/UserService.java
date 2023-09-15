package com.example.self_board_project.user.service;

import com.example.self_board_project.user.mapper.UserMapper;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    public UserMapper userMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public int selectUserCount() {
        System.out.println(">>");
        return 1;
    }
    public List<User> selectUserList() {

        return userMapper.selectUserList();
    }
    public List<User> selectUserRandomList(User user) {

        return userMapper.selectUserRandomList(user);
    }
    public User selectUser(User user) {
        return userMapper.selectUser(user);
    }
    public User findByEmail(String email) {
        return userMapper.findByEmail(email);
    }
    public void insertUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");
        userMapper.insertUser(user);
    }
    public void updateUser(User user) {
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userMapper.updateUser(user);
    }
    public void updateTodayProfileId(User user) {
        userMapper.updateTodayProfileId(user);
    }

    public void todayRandom(User user) {
        logger.info("todayRandom user : {}", user.getId());
        List<User> arrayUserList = new ArrayList<>();


        if(user.getId() != null) {
            arrayUserList.add(selectUser(user));
        } else {
            List<User> userList = selectUserList();
            for (User item:userList) {
                arrayUserList.add(item);
            }
        }
        for (User item: arrayUserList) {
            String todayProfileId = "";
            if(item.getGender().equals("M")) {
                user.setGender("F");
                List<User> manRandomList = selectUserRandomList(user);
                for (User item2: manRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                updateTodayProfileId(user);
            } else {
                user.setGender("M");
                List<User> womanRandomList = selectUserRandomList(user);
                for (User item2: womanRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                updateTodayProfileId(user);
            }
        }
    }

}
