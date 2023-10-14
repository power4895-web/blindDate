package com.example.self_board_project.notification.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.notification.mapper.EmitterRepository;
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
    @Autowired
    private EmitterRepository emitterRepository;

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
     * 로그인한 회원 main, 또는 header에서 구독하기
     * @param id
     * @return
     * sse 통신을 하기 위해서는 MIME 타입을 text/event-stream로 해줘야한다.
     */
    @GetMapping(value = "/notifications/subscribe/{id}", produces = "text/event-stream")
    public SseEmitter subscribe(@PathVariable Long id, @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId) {
//        logger.info("subscribe controller start id : {}", id);
//        logger.info("lastEventId는 emitters가 만료되었을 때, 혹은 서버가 나갔을 때 클라이언트에서 보내서 서버에서 받을 수 있다" +
//                ". 하지만 서버를 내렸다 다시 올리면 캐시에 저장했던 알림 데이터는 모두 사라진다.");
//        logger.info("lastEventId : {}", lastEventId);

        String userId = String.valueOf(id);
        return notificationService.subscribe(id,lastEventId);
    }

    /**
     * 구독한 회원에게 알림보내기
     * @param id
     * @param data
     */
    @GetMapping("/notifications/send-data/{id}/{refId}/{data}")
    @ResponseBody
    public void sendData(@PathVariable String id, @PathVariable String data, @PathVariable int refId) {
        logger.info("sendData start");
        logger.info("id: {}", id);
        logger.info("data: {}", data);
        logger.info("refId: {}", refId);


        //알림 데이터 저장
        Notification notification = new Notification();
        notification.setUserId(Integer.parseInt(id));
        notification.setRefId(refId);
        if(data.equals("친구해요") || data.equals("승낙해요")) {
            notification.setField("relationship");
        } else {
            notification.setField("evaluation");
        }
        notificationService.insertNotification(notification);
//        Notification notificationInfo = notificationService.selectNotification(notification);
        notificationService.saveEventCacheAndSendNotification(id, data);
    }
    /**
     * 구독한 회원에게 알림보내기
     */
    @ResponseBody
    @RequestMapping("/notifications/update/{flag}")
    public Boolean updateNotification(Auth auth, @PathVariable String flag) {
        logger.info("updateNotification start , flag: {}", flag);
        Notification notification = new Notification();
        notification.setUserId(1);
        notification.setField(flag);
        notificationService.updateNotification(notification);
        return true;
    }
}
