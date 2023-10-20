package com.example.self_board_project.chat.service;

import com.example.self_board_project.chat.mapper.ChatMapper;
import com.example.self_board_project.chat.vo.Chat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatService {
    @Autowired
    ChatMapper chatMapper;
    Logger logger = LoggerFactory.getLogger(getClass());

    public int countChat(Chat chat) {
        return chatMapper.countChat(chat);
    }
    public List<Chat> selectChatList(Chat chat) {
        return chatMapper.selectChatList(chat);
    }

    public Chat selectChat(Chat chat) {
        return chatMapper.selectChat(chat);
    }
    public Chat selectLastChat(Chat chat) {
        return chatMapper.selectLastChat(chat);
    }

    public int insertChat(Chat chat) {
        return chatMapper.insertChat(chat);
    }
    public int updateChat(Chat chat) {
        return chatMapper.updateChat(chat);
    }
}
