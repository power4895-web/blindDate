package com.example.self_board_project.user.service;

import com.example.self_board_project.user.mapper.UserMapper;
import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

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
}
