package com.example.self_board_project.user.mapper;

import com.example.self_board_project.user.vo.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public List<User> selectUserList();
    public List<User> selectUserRandomList(User user);
    public User selectUser(int id);

    public void insertUser(User user);
    public void updateUser(User user);
    public void updateTodayProfileId(User user);
}
