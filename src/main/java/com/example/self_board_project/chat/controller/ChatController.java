package com.example.self_board_project.chat.controller;

import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

    @Autowired
    ChatService chatService;
    @Autowired
    RelationshipService relationshipService;
    @RequestMapping(value="/chat")
    public String chat(Auth auth) {
        System.out.println("chat");
        return "user/chat";
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
}
