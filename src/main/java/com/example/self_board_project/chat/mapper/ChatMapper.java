package com.example.self_board_project.chat.mapper;

import com.example.self_board_project.chat.vo.Chat;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ChatMapper {
    public int countChat (Chat chat);
    public List<Chat> selectChatList (Chat chat) ;
    public Chat selectChat (Chat chat);
    public Chat selectLastChat (Chat chat);
    public int insertChat (Chat chat);
    public int updateChat (Chat chat);
}
