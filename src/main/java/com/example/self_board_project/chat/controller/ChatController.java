package com.example.self_board_project.chat.controller;

import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.chat.vo.Chat;
import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    ChatService chatService;
    @Autowired
    RelationshipService relationshipService;
    @RequestMapping(value="/chat")
    public String chat(Auth auth) {
        System.out.println("chat");
        return "user/chat";
    }
    @RequestMapping(value="/chat2/{roomId}")
    public String chat2(Auth auth , @PathVariable int roomId, Model model) {
        logger.info("chat2 : {}", auth.getNickname());
        System.out.println("chat");
        model.addAttribute("nickname",auth.getNickname());
        model.addAttribute("roomId",roomId);
        //roomNumber
        //사용자 이름
        return "user/chat2";
    }
    @RequestMapping(value="/chatList")
    public String chatList(Auth auth) {
        System.out.println("chat");
        return "front:user/chatList";
    }
    @RequestMapping(value="/chat/acceptIsYRelationship")
    public String acceptIsYRelationship(Auth auth, Model model) {
        System.out.println("chat");
        Relationship relationship = new Relationship();
        relationship.setGetId(auth.getId());
        model.addAttribute("acceptIsYRelationshipList", relationshipService.selectAcceptIsYList(relationship));
        return "front:user/chatList";
    }
    @RequestMapping(value="/chat/insert")
    public int insertChat(Auth auth, Model model, Chat chat) {
        System.out.println("chat");
        chatService.insertChat(chat);
        return chat.getId();
    }
}
