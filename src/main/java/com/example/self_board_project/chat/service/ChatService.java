package com.example.self_board_project.chat.service;

import com.example.self_board_project.chat.mapper.ChatMapper;
import com.example.self_board_project.chat.vo.Chat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
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
        logger.info("selectChatList Service");
        List<Chat> chatList = chatMapper.selectChatList(chat);

        Calendar calendar = Calendar.getInstance();

        int yearValue = 0;
        int monthValue = 0; // 월은 0부터 시작하므로 1을 더해줍니다.
        int dayValue = 0;
        int lastYearValue = 0;
        int lastMonthValue = 0;
        int lastDayValue = 0;

        if(chatList.size() > 0) {
            int i=0;
            for (Chat item:chatList) {
                if(item.getLastCreateDate() == null) {
//                    logger.info("lastDate없다");
                    item.setShowCreateDate(item.getCreateDate());
                } else {
//                    logger.info("lastDate있다");
                    //현재시간
                    calendar.setTime(item.getCreateDate());
                    yearValue = calendar.get(Calendar.YEAR);
                    monthValue = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
                    dayValue = calendar.get(Calendar.DAY_OF_MONTH);

                    //과거시간
                    calendar.setTime(item.getLastCreateDate());
                    lastYearValue = calendar.get(Calendar.YEAR);
                    lastMonthValue = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
                    lastDayValue = calendar.get(Calendar.DAY_OF_MONTH);

//                    logger.info("현재 채팅시점 년,월,일 : {}" , yearValue + ":" + monthValue + "+" + dayValue);
//                    logger.info("과거 채팅시점 년,월,일 : {}" , lastYearValue + ":" + lastMonthValue + "+" + lastDayValue);
                    String nowDate = yearValue + ":" + monthValue + "+" + dayValue;
                    String lastDate = lastYearValue + ":" + lastMonthValue + "+" + lastDayValue;
                    if(!nowDate.equals(lastDate)) {
//                        logger.info("nowDate != lastDate");
                        item.setShowCreateDate(item.getCreateDate());
                    }

                }
            }
        }




        return chatList;
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
