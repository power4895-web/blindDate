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
public class NotificationService {
    // 기본 타임아웃 설정
    Logger logger = LoggerFactory.getLogger(getClass());
    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60; //1시간

    //35초정도
//    private static final Long DEFAULT_TIMEOUT = 60L * 600; //36초

    private final EmitterRepository emitterRepository;
    @Autowired
    private NotificationMapper notificationMapper;

//        1_1697103975531
//        1_1697103975516
    /**
     * 클라이언트가 구독을 위해 호출하는 메서드.
     *
     * @param userId - 구독하는 클라이언트의 사용자 아이디.
     * @return SseEmitter - 서버에서 보낸 이벤트 Emitter
     * 연결 요청에 의해 SseEmitter가 생성되면 더미 데이터를 보내줘야한다. sse 연결이 이뤄진 후,
     * 하나의 데이터도 전송되지 않는다면 SseEmitter의 유효 시간이 끝나면 503응답이 발생하는 문제가 있다. 따라서 연결시 바로 더미 데이터를 한 번 보내준다.
     */
    public SseEmitter subscribe(long userId, String lastEventId) {
        logger.info("subscribe Service start ");
        String emitterId = makeTimeIncludeId(userId); // (1-2)
        logger.info("emitterId : {}", emitterId);

        //emitter 등록, emitter를 등록한 번호로 send를 보내면 화면에서 알람을 받을 수 있다.
        SseEmitter emitter = createEmitter(emitterId);

        //emitter.send에 eventid를 같이 보낸다. 나중에 lastId를 받기 위함
        String eventId = makeTimeIncludeId(userId);
        logger.info("eventId : {}", eventId);

        logger.info("hasLostData {} ", hasLostData(lastEventId));
        logger.info("hasLostData는 lastEventId가 있을 때 즉: 네트워크상 문제로 인해 알람을 받지 못했을 때 데이터 손실이라 판단하여 true가 된다.");
        if (hasLostData(lastEventId)) {
            sendLostData(lastEventId, userId, emitterId, emitter);
        }

        //구독시 default로 미리 보내야 에러 방지
        sendNotification(emitter, eventId, emitterId, "EventStream Created. [userId=" + userId + "]");



        return emitter;
    }
    private String makeTimeIncludeId(long id) { // (3)
        return id + "_" + System.currentTimeMillis();
    }
    private boolean hasLostData(String lastEventId) { // (5)
        return !lastEventId.isEmpty();
    }
    private void sendLostData(String lastEventId, long userId, String emitterId, SseEmitter emitter) { // (6)
        logger.info("sendLostData start > 데이터 손실이 있다.");
        logger.info("userId : {} " , userId);
        logger.info("lastEventId : {} , " , lastEventId);
        logger.info("user의 pk값으로, userId_*******로 되어있는 모든 아이디들을 불러온다., 그 후 아래의 lastEventId과 시간을 따져봐야한다.");
        Map<String, Object> eventCaches = emitterRepository.findAllEventCacheStartWithByUserId(String.valueOf(userId));
        logger.info("eventCaches.toString() : {} ",eventCaches.toString());

        //lastEventId는 해당 웹브라우저가 마지막으로 수신하게된 eventId이다. lastEventId가 캐시에 저장된 eventId보다 작을경우(더 오래전일 경우) 음수를 반환하게 되고 sendNotification이
        //실행되어, 이전에 보내지 못했던 알람을 보내게 된다. 반대로 lastEventId가 더 큰경우(더 최근일 경우), 캐시에 저장된 아이
        //그럼 어떻게 lastEventId가 더 큰경우가 나오냐한다면, 일단 알람 수신이 되는순간 lastEventId는 현재 브라우저가 구독한 eventId이다. 예를 들어 7시라고 하자
        //그후  7시 10분에 emmit.send부분의 코드를 지우고, 알람을 요청했을 경우, cash에 7시10분의 eventId가 저장된다. 하지만 알람은 발생하지 않는다.수신이되지 않은것이다.
        //현재까지 lastEventId는 7시이다. 그러면 cash에 저장된 eventId보다 작을 수 있게 된다. 이 때 키값을 통해 알람을 보낸다.
        //테스트를 위해 코드를 지우고 테스트를 했지만, 클라이언트또는 서버, 아니면 시스템문제상 캐시에만 저장되고, 알람부분 제대로 동작을 안했을 경우를 대비한 것 이다.
        //테스트는, 일단 정상적으로 알람을 보낸다. 그리고 클라이언트가 알람보내는 send service부분에 알람보내는 부분을 주석하고
        // 시간 만료되어 deleteId가 발동되는 순간, 알람을 보낸다. 그러면 캐시만 저장한 상태이기 때문에, deleteId된걸 다시 서버가 자동으로 구독하려고 할 때 알람을 받을 수 있게된다.
        //어쨌든 알람을 보냈지만, 서버, 코드, sse끊김현상,네트워크등으로 알림을 송신하지 못했을 때, 다음번에 다시 구독을 요청할 때 알람을 받을 수 있다.

        eventCaches.entrySet().stream()
                .filter(entry -> lastEventId.compareTo(entry.getKey()) < 0)
                .forEach(entry -> sendNotification(emitter, entry.getKey(), emitterId, entry.getValue()));
    }

    /**
     * 캐시를 저장하고 궁극적인 emmiter.send가 있는 sendNotification으로 보내는 메소드이다.
     * 다른 서비스 로직에서 이 메서드를 사용해 데이터를 Object event에 넣고 전송하면 된다.
     *
     * @param userId - 메세지를 전송할 사용자의 아이디.
     * @param event  - 전송할 이벤트 객체.
     */
    public void saveEventCacheAndSendNotification(String userId, Object event) {
        logger.info("send Start");
        String eventId = userId + "_" + System.currentTimeMillis();
        Map<String, SseEmitter> emitters = emitterRepository.findAllEmitterStartWithByUserId(userId);
        logger.info("emitters.isEmpty : {}", emitters.isEmpty());
        logger.info("emitters : {}", emitters);
        emitters.forEach(
                (key, emitter) -> {
                    emitterRepository.saveEventCache(key, event);
                    sendNotification(emitter, eventId, key, event); //lst이벤트 테스트시 주석
                }
        );
    }

    /**
     * emitter로 send보내는 마지막 단계
     * @param emitter
     * @param eventId
     * @param emitterId
     * @param data
     */
    private void sendNotification(SseEmitter emitter, String eventId, String emitterId, Object data) { // (4)
        logger.info("sendNotification Start");
        logger.info("emitter : {}", emitter);
        logger.info("eventId : {}", eventId);
        logger.info("emitterId : {}", emitterId);
        logger.info("data : {}", data);
        try {
            emitter.send(SseEmitter.event().id(eventId).name("sse").data(data));
        } catch (IOException exception) {
            emitterRepository.deleteById(emitterId);
        }
    }

    /**
     * 사용자 아이디_시간을 기반으로 이벤트 Emitter를 생성
     * id_시간으로 emmiter를 생성한다.
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
        logger.info("createEmitter start emitterId : {}", id);
        SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
        emitterRepository.save(id, emitter);

        //설정한 DEFAULT_TIMEOUT가 지났을 때 또는 브라우저를 닫았을 때, deleteId메소드가 실행된다.
        // Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) Emitter를 삭제한다. (완료되도 삭제는 안되는 것 같다)
        emitter.onCompletion(() -> emitterRepository.deleteById(id));
        // Emitter가 타임아웃 되었을 때(지정된 시간동안 어떠한 이벤트도 전송되지 않았을 때) Emitter를 삭제한다.
        emitter.onTimeout(() -> emitterRepository.deleteById(id));

        return emitter;
    }


    public List<Notification> selectNotificationList(Notification notification) {
        return notificationMapper.selectNotificationList(notification);
    }
    public Notification selectNotification(Notification notification) {
        return notificationMapper.selectNotification(notification);
    }
    public Notification countNotification(Notification notification) {
        logger.info("countNotification Service");
        return notificationMapper.countNotification(notification);
    }

    public void insertNotification(Notification notification) {
        notificationMapper.insertNotification(notification);
    }
    public void updateNotification(Notification notification) {
        notificationMapper.updateNotification(notification);
    }

}
