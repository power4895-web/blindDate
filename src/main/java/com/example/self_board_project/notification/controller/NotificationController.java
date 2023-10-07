package com.example.self_board_project.notification.controller;

import com.example.self_board_project.notification.service.NotificationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    Logger logger = LoggerFactory.getLogger(getClass());
    @GetMapping(value = "/notifications/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(@PathVariable Long id) {
        logger.info("subscribe start");
        return notificationService.subscribe(id);
    }

    @GetMapping("/notifications/send-data/{id}/{data}")
    @ResponseBody
    public void sendData(@PathVariable Long id, @PathVariable String data) {
        logger.info("send-data start");
        logger.info("send-data start id: {}", id);
        logger.info("send-data start data: {}", data);
        notificationService.notify(id, data);
    }
}
