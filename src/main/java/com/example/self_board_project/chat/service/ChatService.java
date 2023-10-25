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
        if(chatList.size() > 0) {
            int i=0;
            for (Chat item:chatList) {
                if(item.getLastCreateDate() == null) {
                    logger.info("lastDate없다");
                    item.setShowCreateDate(item.getCreateDate());
                } else {
                    logger.info("lastDate있다");
                    calendar.setTime(item.getCreateDate());
                    int yearValue = calendar.get(Calendar.YEAR);
                    int monthValue = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
                    int dayValue = calendar.get(Calendar.DAY_OF_MONTH);
                    logger.info("현재 채팅시점 연도 : {}" , yearValue);
                    logger.info("현재 채팅시점 월 : {}" , monthValue);
                    logger.info("현재 채팅시점 일 : {}" , dayValue);
                    calendar.setTime(item.getLastCreateDate());
                    int lastYearValue = calendar.get(Calendar.YEAR);
                    int lastMonthValue = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
                    int lastDayValue = calendar.get(Calendar.DAY_OF_MONTH);
                    logger.info("현재 채팅시점 연도 : {}" , lastYearValue);
                    logger.info("현재 채팅시점 월 : {}" , lastMonthValue);
                    logger.info("현재 채팅시점 일 : {}" , lastDayValue);

                    logger.info("현재 채팅시점 년,월,일 : {}" , yearValue + ":" + monthValue + "+" + dayValue);
                    logger.info("과거 채팅시점 년,월,일 : {}" , lastYearValue + ":" + lastMonthValue + "+" + lastDayValue);
                    String nowDate = yearValue + ":" + monthValue + "+" + dayValue;
                    String lastDate = lastYearValue + ":" + lastMonthValue + "+" + lastDayValue;
                    if(!nowDate.equals(lastDate)) {
                        logger.info("nowDate != lastDate");
                        item.setShowCreateDate(item.getCreateDate());
                    }

                }
                logger.info("create date : {}", item.getCreateDate());
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
