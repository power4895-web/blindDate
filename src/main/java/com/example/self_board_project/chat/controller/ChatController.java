package com.example.self_board_project.chat.controller;

import com.example.self_board_project.core.authority.Auth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

    @RequestMapping(value="/chat")
    public String chat(Auth auth) {
        System.out.println("chat");
        return "user/chat";
    }
}
