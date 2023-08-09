package com.example.self_board_project.user.mapper;

import com.example.self_board_project.user.vo.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public List<User> selectUserList();
    public User selectUser(int id);

    public void insertUser(User user);
}
