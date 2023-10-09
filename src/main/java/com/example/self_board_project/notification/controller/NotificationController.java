package com.example.self_board_project.notification.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.notification.vo.Notification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

@Controller
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    Logger logger = LoggerFactory.getLogger(getClass());
    @RequestMapping(value = "/notifications/list")
    @ResponseBody
    public void notificationList(Auth auth, Model model) {
        logger.info("notificationList start");
        Notification notification = new Notification();
        notification.setUserId(auth.getId());
        notification.setReadYn("N");
        notification.setField("relationship");
        List<Notification> relationshioNotificationList = notificationService.selectNotificationList(notification);
        notification.setField("evaluation");
        List<Notification> evaluationNotificationList = notificationService.selectNotificationList(notification);
    }
    @RequestMapping(value = "/notification/count")
    @ResponseBody
    public Notification notificationCount(Auth auth, Model model) {
        logger.info("notificationCount start  : {}", auth.getId());
        Notification notification = new Notification();
        notification.setUserId(auth.getId());
        Notification notificationCount = notificationService.countNotification(notification);
        logger.info("notificationCount {}", notificationCount);
        return notificationCount;
    }
    @GetMapping(value = "/notifications/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(@PathVariable Long id) {
        logger.info("subscribe start id : {}", id);
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
