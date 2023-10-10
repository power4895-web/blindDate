package com.example.self_board_project.notification.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.notification.vo.Notification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;

@Controller
public class NotificationController {
    @Autowired
    private NotificationService notificationService;

    Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 알림 리스트
     * @param auth
     * @param model
     */
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

    /**
     * 알림카운트 (친구해요, 평가, 읽지 않은 알람, 읽거나 안읽은 모든 알람 개수)
     * @param auth
     * @param model
     * @return
     */
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

    /**
     * 로그인한 회원 구독하기
     * @param id
     * @return
     * sse 통신을 하기 위해서는 MIME 타입을 text/event-stream로 해줘야한다.
     */
//    @GetMapping(value = "/notifications/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
//    public SseEmitter subscribe(@PathVariable Long id) {
//        logger.info("subscribe start id : {}", id);
//        return notificationService.subscribe(id);
//    }
//    @GetMapping(value = "/notifications/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @GetMapping(value = "/notifications/subscribe/{id}", produces = "text/event-stream")
    public SseEmitter subscribe(@PathVariable Long id, @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId, Auth auth) {
        logger.info("subscribe start id : {}", id);
        logger.info("lastEventId : {}", lastEventId);
        String userId = String.valueOf(id);
        return notificationService.subscribe(userId,lastEventId,auth.getRealName());
    }

    /**
     * 구독한 회원에게 클라이언트로 호출하기
     * @param id
     * @param data
     */
    @GetMapping("/notifications/send-data/{id}/{refId}/{data}")
    @ResponseBody
    public void sendData(@PathVariable Long id, @PathVariable String data, @PathVariable int refId, Auth auth) {
        logger.info("send-data start");
        logger.info("send-data start id: {}", id);
        logger.info("send-data start data: {}", data);
        logger.info("send-data start refId: {}", refId);
        String userId = String.valueOf(id);
        String authId = String.valueOf(auth.getId());

        Notification notification = new Notification();
        notification.setUserId(Integer.parseInt(String.valueOf(id)));
        if(data.equals("친구해요") || data.equals("승낙해요")) {
            notification.setField("relationship");
        } else {
            notification.setField("evaluation");
        }
        notification.setRefId(refId);
        notificationService.insertNotification(notification);

        notificationService.notify(userId, data);
    }
}
