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


//    @RequestMapping(value="/chat")
//    public String chat(Auth auth) {
//        System.out.println("chat");
//        return "user/chat";
//    }

    /**
     * 해당 채팅방 입장
     * @param auth
     * @return
     */
    @RequestMapping(value="/chat2/{roomId}")
    public String chat2(Auth auth , @PathVariable int roomId, Model model) {
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
            User user = new User();
            user.setId(yourId);
            user.setFlag("XS");
            User userInfo = userService.selectUser(user);
            model.addAttribute("yourNickname", userInfo.getNickname());
            model.addAttribute("imgUrl", userInfo.getImgUrl());

            Chat chat = new Chat();
            chat.setRoomId(roomId);
            List<Chat> chatList = chatService.selectChatList(chat);
            model.addAttribute("chatList", chatList);
        }
        //사용자 이름
        return "chat/chat";
    }


//    @RequestMapping(value="/chat/list")
//    public String chatList(Auth auth, Chat chat) {
//        logger.info("chatList");
//        chatService.selectChatList(chat);
//        return "front:user/chatList";
//    }
//    @RequestMapping(value="/chat/view")
//    public String chatView(Auth auth, Chat chat) {
//        logger.info("chatView");
//        chatService.selectChat(chat);
//        return "front:user/chatList";
//    }

    @RequestMapping(value="/chat/insert")
    @ResponseBody
    public int insertChat(Auth auth, Model model, Chat chat) {
        logger.info("chat start");
        Room room = new Room();
        room.setId(chat.getRoomId());
        Room roomInfo = roomService.selectRoom(room);
        if(roomInfo.getRoomBossId() == auth.getId()) {
            chat.setToId(roomInfo.getRoomStaffId());
        } else if(roomInfo.getRoomStaffId() == auth.getId()) {
            chat.setToId(roomInfo.getRoomBossId());
        }
        chat.setFromId(auth.getId());
        chatService.insertChat(chat);
        return chat.getId();
    }
}
