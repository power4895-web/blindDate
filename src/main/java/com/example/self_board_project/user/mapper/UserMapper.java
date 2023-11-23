package com.example.self_board_project.user.mapper;

import com.example.self_board_project.user.vo.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    public List<User> selectUserList(User user);
    public List<User> selectUserRandomList(User user);
    public User selectUser(User user);
    public User findByEmail(String email);

    public void insertUser(User user);
    public Boolean updateUser(User user);
    public void updateTodayProfileId(User user);
    public void deleteUserIds(User user);
}
