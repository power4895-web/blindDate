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

    public int selectBoardCount() {
        System.out.println(">>");
        return 1;
    }
    public List<User> selectBoardList() {

        return userMapper.selectUserList();
    }
    public User selectBoard() {
        return userMapper.selectUser();
    }
    public void insertUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userMapper.insertUser(user);
    }
}
