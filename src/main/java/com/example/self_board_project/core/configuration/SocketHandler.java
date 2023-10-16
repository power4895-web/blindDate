package com.example.self_board_project.core.configuration;


import com.example.self_board_project.room.service.RoomService;
import com.example.self_board_project.room.vo.Room;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component
public class SocketHandler extends TextWebSocketHandler {
    HashMap<String, WebSocketSession> sessionMap = new HashMap<>();//웹소켓을 담아둘 세션맵
    List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    RoomService roomService;

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        logger.info("handleTextMessage : 메세지 발송");
        logger.info("rls size  : {}", rls.size());
        logger.info("rls  : {}", rls);
        //메시지 수신시 실행
        //메세지발송
        String msg = message.getPayload();
        logger.info("msg  : {}", msg);
        JSONObject obj = jsonToObjectParser(msg);
        logger.info("obj  : {}", obj);
        logger.info("roomId  : {}", obj.get("roomId"));
        String rN = (String) obj.get("roomId");
        HashMap<String, Object> temp = new HashMap<String, Object>();

        Room room = new Room();
        room.setId(Integer.parseInt(rN));
        Room roomInfo = roomService.selectRoom(room);
        if (roomInfo != null) {
            System.out.println("roomInfo가 있다");

//            WebSocketSession wss = (WebSocketSession) temp.get(k);
//            logger.info("wss: {}", wss);
//            if (wss != null) {
//                try {
//                    wss.sendMessage(new TextMessage(obj.toJSONString()));
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }

        }

        if (rls.size() > 0) {
            logger.info("rls.size가 있다면");
            for (int i = 0; i < rls.size(); i++) {
                logger.info("roomId : {}", rls.get(i).get("roomId"));
                String roomId = (String) rls.get(i).get("roomId"); //세션리스트의 저장된 방번호를 가져와서
                if (roomId.equals(rN)) { //같은값의 방이 존재한다면
                    logger.info("같은값의 방이 존재한다면");
                    logger.info("roomId : {}", roomId);
                    logger.info("rls.get(i) : {}", rls.get(i));
                    temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                    break;
                }
            }
            //방정보 가져오기


            //해당 방의 세션들만 찾아서 메시지를 발송해준다.
            for (String k : temp.keySet()) {
                logger.info("temp.keySet()");
                logger.info("k : {}", k);
                if (k.equals("roomId")) { //다만 방번호일 경우에는 건너뛴다.
                    continue;
                }
                logger.info("temp.get(k) : {}", temp.get(k));
                WebSocketSession wss = (WebSocketSession) temp.get(k);
                logger.info("wss: {}", wss);
                if (wss != null) {
                    try {
                        wss.sendMessage(new TextMessage(obj.toJSONString()));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //소켓 연결되면 동작
        System.out.println(">>>afterConnectionEstablished  : 소켓연결");
        super.afterConnectionEstablished(session);
        boolean flag = false;
        String url = session.getUri().toString();
        System.out.println("url: " + url);
        String roomId = url.split("/chating/")[1];
        System.out.println("roomId : " + roomId);

        Room room = new Room();
        room.setRoomId(Integer.parseInt(roomId));
        Room roomInfo = roomService.selectRoom(room);
//        System.out.println("roomInfo : "  + roomInfo);
        int idx = rls.size(); //방의 사이즈를 조사한다.
        System.out.println("rls.size() : " + rls.size());
        if (rls.size() > 0) {
            for (int i = 0; i < rls.size(); i++) {
                String rN = (String) rls.get(i).get("roomId");
                System.out.println("rN : " + rN);
                System.out.println("i : " + i);
                if (rN.equals(roomId)) {
                    flag = true;
                    idx = i;
                    break;
                }
            }
        }
//        if (roomInfo != null) {
//            flag = true;
//        }
        System.out.println("flag : " + flag);
        if (flag) { //존재하는 방이라면 세션만 추가한다.
            System.out.println("존재하는 방이라면 세션만 추가한다.");
            System.out.println("idx : " + idx);
            System.out.println("session.getId() : " + session.getId());
            System.out.println("session : " + session);

            //map에다가 왜 넣는거지??  , 주석하게 되면 본인이 사용한 메세지를 받을수 없다.
            //session_id, url, roomId
            System.out.println("rls.get(idx) : " + rls.get(idx));
            HashMap<String, Object> map = rls.get(idx);
            map.put(session.getId(), session);
        } else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
            System.out.println("최초 생성하는 방이라면 방번호와 세션을 추가한다. ");
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("roomId", roomId);
            System.out.println("session.getId() : " + session.getId());
            System.out.println("session : " + session);
//            room.setSession(String.valueOf(session));
//            room.setSessionId(session.getId());
//            roomService.updateRoom(room);
            map.put(session.getId(), session);
            rls.add(map);
        }


        //json타입으로 보내기 위해 세팅
        JSONObject obj = new JSONObject();
        obj.put("type", "getId");
        obj.put("sessionId", session.getId());
        session.sendMessage(new TextMessage(obj.toJSONString()));

    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println(">>>afterConnectionClosed :  소켓종료");
        //소켓 종료되면 동작
        if (rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
            for (int i = 0; i < rls.size(); i++) {
                rls.get(i).remove(session.getId());
            }
        }
        super.afterConnectionClosed(session, status);
    }

    private static JSONObject jsonToObjectParser(String jsonStr) {
//        System.out.println("jsonStr" + jsonStr);
        JSONParser parser = new JSONParser();
        JSONObject obj = null;
        try {
            obj = (JSONObject) parser.parse(jsonStr);
            System.out.println("obj" + obj);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return obj;
    }

}
