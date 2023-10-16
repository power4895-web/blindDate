package com.example.self_board_project.core.configuration;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class SocketHandlerOld extends TextWebSocketHandler {
    HashMap<String, WebSocketSession> sessionMap = new HashMap<>();//웹소켓을 담아둘 세션맵
    List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions

    Logger logger = LoggerFactory.getLogger(getClass());
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        logger.info("handleTextMessage : 메세지 발송");
        logger.info("rls size  : {}" , rls.size());
        //메시지 수신시 실행
        //메세지발송
        String msg = message.getPayload();
        logger.info("msg  : {}" , msg);
        JSONObject obj = jsonToObjectParser(msg);
        logger.info("obj  : {}" , obj);
        logger.info("roomnumber  : {}" , obj.get("roomNumber"));
        String rN = (String) obj.get("roomNumber");
        HashMap<String, Object> temp = new HashMap<String, Object>();


        if(rls.size() > 0) {
            logger.info("rls.size가 있다면");
            for(int i=0; i<rls.size(); i++) {
                logger.info("roomNumber : {}", rls.get(i).get("roomNumber"));
                String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
                if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
                    logger.info("같은값의 방이 존재한다면 : {}");
                    logger.info("roomNumber : {}", roomNumber);
                    logger.info("rls.get(i) : {}", rls.get(i));
                    temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                    break;
                }
            }
            //해당 방의 세션들만 찾아서 메시지를 발송해준다.
            for(String k : temp.keySet()) {
                logger.info("temp.keySet()");
                if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
                    logger.info("k : {}", k);
                    continue;
                }
                logger.info("temp.get(k) : {}", temp.get(k));
                WebSocketSession wss = (WebSocketSession) temp.get(k);
                logger.info("wss: {}", wss);
                if(wss != null) {
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
        String roomNumber = url.split("/chating/")[1];
        System.out.println("roomNumber : " + roomNumber);

        int idx = rls.size(); //방의 사이즈를 조사한다.
        System.out.println("rls.size() : " + rls.size());
        if(rls.size() > 0) {
            for(int i=0; i<rls.size(); i++) {
                String rN = (String) rls.get(i).get("roomNumber");
                System.out.println("rN : " + rN);
                System.out.println("i : " + i);
                if(rN.equals(roomNumber)) {
                    flag = true;
                    idx = i;
                    break;
                }
            }
        }
        System.out.println("flag : " +  flag);
        if(flag) { //존재하는 방이라면 세션만 추가한다.
            System.out.println("존재하는 방이라면 세션만 추가한다.");
            System.out.println("idx : " + idx);
            System.out.println("session.getId() : " + session.getId());
            System.out.println("session : " + session);

            //map에다가 왜 넣는거지??
            HashMap<String, Object> map = rls.get(idx);
            map.put(session.getId(), session);
        }else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
            System.out.println("최초 생성하는 방이라면 방번호와 세션을 추가한다. ");
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("roomNumber", roomNumber);
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
        if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
            for(int i=0; i<rls.size(); i++) {
                rls.get(i).remove(session.getId());
            }
        }
        super.afterConnectionClosed(session, status);
    }

    private static JSONObject jsonToObjectParser(String jsonStr) {
        System.out.println("jsonStr" + jsonStr);
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
