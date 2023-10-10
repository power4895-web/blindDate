package com.example.self_board_project.notification.mapper;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Repository
public class EmitterRepository {
    // 모든 Emitters를 저장하는 ConcurrentHashMap
    // sseEmitter를 관리하는 스레드들이 콜백할때 스레드가 다를수 있기에 ThreadSafe한 구조인 ConcurrentHashMap을 사용해서 해당 메시지를 저장해야한다.
    /**
     * emitterRepo에 save(id, ssemitter(timeout))을 저장함으로써 향후 이벤트가 발생됐을때 클라이언트에게 데이터를 전송할 수있다.
     * 이때 repo에서는 sseEmitter를 관리하는 스레드들이 콜백할때 스레드가 다를수 있기에 ThreadSafe한 구조인 ConcurrentHashMap을 사용해서 해당 메시지를 저장해야한다.
     */
    private final Map<Long, SseEmitter> emitters = new ConcurrentHashMap<>();
    private final Map<String, Object> eventCache = new ConcurrentHashMap<>();
    /**
     * 주어진 아이디와 이미터를 저장
     *
     * @param id      - 사용자 아이디.
     * @param emitter - 이벤트 Emitter.
     */
    public void save(Long id, SseEmitter emitter) {
        emitters.put(id, emitter);
    }

    /**
     * 주어진 아이디의 Emitter를 제거
     *
     * @param id - 사용자 아이디.
     */
    public void deleteById(Long id) {
        emitters.remove(id);
    }

    /**
     * 주어진 아이디의 Emitter를 가져옴.
     *
     * @param id - 사용자 아이디.
     * @return SseEmitter - 이벤트 Emitter.
     */
    public SseEmitter get(Long id) {
        return emitters.get(id);
    }



//    public void saveEventCache(String id, Object event) {
//        eventCache.put(id, event);
//    }
//
//    public Map<String, SseEmitter> findAllStartById(String id) {
//        return emitters.entrySet().stream()
//                .filter(entry -> entry.getKey().startsWith(id))
//                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
//    }
//
//    public void deleteAllStartByWithId(String id) {
//        emitters.forEach((key, emitter) -> {
//            if (key.startsWith(id)) emitters.remove(key);
//        });
//    }

}