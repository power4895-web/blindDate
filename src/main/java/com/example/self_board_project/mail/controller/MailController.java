package com.example.self_board_project.mail.controller;

import com.example.self_board_project.mail.service.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller

public class MailController {
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private MailService mailService;

    @ResponseBody
    @PostMapping("/mail")
    public String MailSend(String mail){
        logger.info("mail {}", mail);
        int number = mailService.sendMail(mail);
        String num = "" + number;
        return num;
    }
}
