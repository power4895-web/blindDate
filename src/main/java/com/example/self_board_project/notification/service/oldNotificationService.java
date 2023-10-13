package com.example.self_board_project.notification.service;

import com.example.self_board_project.notification.mapper.EmitterRepository;
import com.example.self_board_project.notification.mapper.NotificationMapper;
import com.example.self_board_project.notification.vo.Notification;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class oldNotificationService {
    // 기본 타임아웃 설정
    Logger logger = LoggerFactory.getLogger(getClass());
    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;

    private final EmitterRepository emitterRepository;
    @Autowired
    private NotificationMapper notificationMapper;



    /**
     * 클라이언트가 구독을 위해 호출하는 메서드.
     *
     * @param userId - 구독하는 클라이언트의 사용자 아이디.
     * @return SseEmitter - 서버에서 보낸 이벤트 Emitter
     * 연결 요청에 의해 SseEmitter가 생성되면 더미 데이터를 보내줘야한다. sse 연결이 이뤄진 후,
     * 하나의 데이터도 전송되지 않는다면 SseEmitter의 유효 시간이 끝나면 503응답이 발생하는 문제가 있다. 따라서 연결시 바로 더미 데이터를 한 번 보내준다.
     */
    public SseEmitter subscribe(String userId, String lastEventId, String realName) {
        String emitterId = makeTimeIncludeId(realName); // (1-2)
        SseEmitter emitter = createEmitter(userId);
        sendToClient(userId, "EventStream Created. [userId=" + userId + "]");  //default로 미리 보내야 에러 방지

        logger.info("hasLostData : {} ", hasLostData(lastEventId));
        if (hasLostData(lastEventId)) {
            sendLostData(lastEventId, realName, emitterId, emitter);
        }

        return emitter;
    }
    private String makeTimeIncludeId(String email) { // (3)
        return email + "_" + System.currentTimeMillis();
    }
    private boolean hasLostData(String lastEventId) { // (5)
        return !lastEventId.isEmpty();
    }
    private void sendLostData(String lastEventId, String userEmail, String emitterId, SseEmitter emitter) { // (6)
        Map<String, Object> eventCaches = emitterRepository.findAllEventCacheStartWithByUserId(String.valueOf(userEmail));
        eventCaches.entrySet().stream()
                .filter(entry -> lastEventId.compareTo(entry.getKey()) < 0)
                .forEach(entry -> sendNotification(emitter, entry.getKey(), emitterId, entry.getValue()));
    }

//    public SseEmitter subscribe(Long userId) {
//        SseEmitter emitter = createEmitter(userId);
//        sendToClient(userId, "EventStream Created. [userId=" + userId + "]");
//        return emitter;
//    }

    /**
     * 서버의 이벤트를 클라이언트에게 보내는 메서드
     * 다른 서비스 로직에서 이 메서드를 사용해 데이터를 Object event에 넣고 전송하면 된다.
     *
     * @param userId - 메세지를 전송할 사용자의 아이디.
     * @param event  - 전송할 이벤트 객체.
     */
    public void notify(String userId, Object event) {
        sendToClient(userId, event);
    }

    /**
     * 클라이언트에게 데이터를 전송
     *
     * @param id   - 데이터를 받을 사용자의 아이디.
     * @param data - 전송할 데이터.
     */
    private void sendToClient(String id, Object data) {
        SseEmitter emitter = emitterRepository.get(id);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().id(String.valueOf(id)).name("sse").data(data));
            } catch (IOException exception) {
                emitterRepository.deleteById(id);
                emitter.completeWithError(exception);
            }
        }
    }

    private void sendNotification(SseEmitter emitter, String eventId, String emitterId, Object data) { // (4)
        try {
            emitter.send(SseEmitter.event()
                    .id(eventId)
                    .name("sse")
                    .data(data)
            );
        } catch (IOException exception) {
            emitterRepository.deleteById(emitterId);
        }
    }

    /**
     * 사용자 아이디를 기반으로 이벤트 Emitter를 생성
     * id를 emmiter에 저장한다.
     *
     * @param id - 사용자 아이디.
     * @return SseEmitter - 생성된 이벤트 Emitter.
     */
    private SseEmitter createEmitter(String id) {

        /*
        클라이언트의 sse연결 요청에 응답하기 위해서는 SseEmitter 객체를 만들어 반환해줘야한다.
        SseEmitter 객체를 만들 때 유효 시간을 줄 수 있다. 이때 주는 시간 만큼 sse 연결이 유지되고, 시간이 지나면 자동으로 클라이언트에서 재연결 요청을 보내게 된다.
        id를 key로, SseEmitter를 value로 저장해둔다. 그리고 SseEmitter의 시간 초과 및 네트워크 오류를 포함한 모든 이유로 비동기 요청이 정상 동작할 수 없다면 저장해둔 SseEmitter를 삭제한다.
         */
        logger.info("createEmitter");
        logger.info("DEFAULT_TIMEOUT : {}" , DEFAULT_TIMEOUT);

        SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
        emitterRepository.save(id, emitter);
        // Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) Emitter를 삭제한다.
        emitter.onCompletion(() -> emitterRepository.deleteById(id));
        // Emitter가 타임아웃 되었을 때(지정된 시간동안 어떠한 이벤트도 전송되지 않았을 때) Emitter를 삭제한다.
        emitter.onTimeout(() -> emitterRepository.deleteById(id));



        return emitter;
    }


    public List<Notification> selectNotificationList(Notification notification) {
        return notificationMapper.selectNotificationList(notification);
    }
    public Notification countNotification(Notification notification) {
        System.out.println("countNotification Service");
        return notificationMapper.countNotification(notification);
    }

    public void insertNotification(Notification notification) {
        notificationMapper.insertNotification(notification);
    }
    public void updateNotification(Notification notification) {
        notificationMapper.updateNotification(notification);
    }

}
