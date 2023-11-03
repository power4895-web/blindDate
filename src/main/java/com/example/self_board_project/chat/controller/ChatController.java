package com.example.self_board_project.chat.controller;

import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.chat.vo.Chat;
import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.room.service.RoomService;
import com.example.self_board_project.room.vo.Room;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ChatController {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    ChatService chatService;
    @Autowired
    RoomService roomService;
    @Autowired
    UserService userService;

    /**
     * 해당 채팅방 입장 => 채팅방의 방번호로 모든 리스트 가져오기
     * @param auth
     * @return
     */
    @RequestMapping(value="/chat/{roomId}")
    public String chat(Auth auth , @PathVariable int roomId, Model model) {
        logger.info("chat2 Start");
        logger.info("roomId : {}", roomId);

        model.addAttribute("userInfo",auth);
        model.addAttribute("roomId",roomId);

        Room room = new Room();
        room.setId(roomId);
        Room roomInfo = roomService.selectRoom(room);
        logger.info("roomInfo : {}", roomInfo.getId());
        if(roomInfo != null) {
            int yourId = 0;
            if(auth.getId() == roomInfo.getRoomBossId()) {
                yourId = roomInfo.getRoomStaffId();
            } else if (auth.getId() == roomInfo.getRoomStaffId()) {
                yourId = roomInfo.getRoomBossId();
            }
            logger.info("yourId : {}", yourId);

            if(roomInfo.getQuitId() != 0) {
                if(yourId == roomInfo.getQuitId()) {
                    logger.info("상대방이 나갔습니다.");
                }
            } else {
                logger.info("상대방이 존재합니다.");
                User user = new User();
                user.setId(yourId);
                user.setFlag("XS");
                User userInfo = userService.selectUser(user);
                model.addAttribute("yourInfo", userInfo);
                model.addAttribute("yourNickname", userInfo.getNickname());
                model.addAttribute("imgUrl", userInfo.getImgUrl());
            }

            Chat chat = new Chat();
            chat.setRoomId(roomId);
            
            List<Chat> chatList = chatService.selectChatList(chat);
            model.addAttribute("chatList", chatList);
            
            //마지막 채팅 시간
            Chat chatLastList = chatService.selectLastChat(chat);
            if(chatLastList != null) {
                model.addAttribute("chatLastList", chatLastList);
            }
        }
        //사용자 이름
        return "front:chat/chat";
    }
    /**
     * 마지막 채팅이력 가져오기
     * @param auth
     * @return
     */
    @RequestMapping(value="/lastChatTime/{roomId}")
    @ResponseBody
    public Chat lastChatTime(Auth auth , @PathVariable int roomId, Model model) {
        logger.info("lastChatTime Start");
        logger.info("roomId : {}", roomId);
        Chat chat = new Chat();
        chat.setRoomId(roomId);
        Chat chatInfo = chatService.selectLastChat(chat);
        if(chatInfo != null) {
            return chatInfo;
        }
        return chat;
    }

    /**
     * 채팅 insert
     * @param auth
     * @param model
     * @param chat
     * @return
     */
    @RequestMapping(value="/chat/insert")
    @ResponseBody
    public Chat insertChat(Auth auth, Model model, Chat chat) {
        logger.info("chat start");
        logger.info("content : {}", chat.getContent());
        logger.info("roomId : {}", chat.getRoomId());
        Room room = new Room();
        room.setId(chat.getRoomId());
        Room roomInfo = roomService.selectRoom(room);
        if(roomInfo.getRoomBossId() == auth.getId()) {
            chat.setToId(roomInfo.getRoomStaffId());
        } else if(roomInfo.getRoomStaffId() == auth.getId()) {
            chat.setToId(roomInfo.getRoomBossId());
        }
        chat.setFromId(auth.getId());
        Chat lastChatInfo = chatService.selectLastChat(chat);
        if(lastChatInfo != null) {
            logger.info("lastChatInfo : {}", lastChatInfo);
            chat.setLastCreateDate(lastChatInfo.getCreateDate());
            chat.setLastFromId(lastChatInfo.getFromId());
            chatService.insertChat(chat);
            Chat chatInfo = chatService.selectChat(chat);
            return chatInfo;
        } else {
            chatService.insertChat(chat);
            Chat chatInfo = chatService.selectChat(chat);
            return chatInfo;
        }
    }

    /**
     * //채팅방 들어온 아이디 읽지 않은거 모두 읽은걸로 업데이트
     * @param auth
     * @param model
     * @param chat
     * @return
     */
    @RequestMapping(value="/chat/update")
    @ResponseBody
    public int updateChat(Auth auth, Model model, Chat chat) {
        logger.info("updateChat start");
        logger.info("roomId : {}", chat.getRoomId());
        chat.setRoomId(chat.getRoomId());
        chat.setToId(auth.getId());
        chatService.updateChat(chat);
        return chat.getId();
    }
}
