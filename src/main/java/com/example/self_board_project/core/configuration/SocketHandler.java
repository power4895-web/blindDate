package com.example.self_board_project.core.configuration;


import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.chat.vo.Chat;
import com.example.self_board_project.room.service.RoomService;
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

    /*
        한명만 접속했을 경우
        readyn은 한명이 접속한 뒤, 다른한명이 같은방에 접속하면 rls.get(i).size()가 3이 나오고, 그럴 때 DB의 readyn을 모두 Y로 바꿔준다. 그리고 rls의 같은 방번호에 먼저 들어가있는 세션에게
        메세지를 보낸다. type이 온라인으로, 그럼 먼저 들어온 사람이 가만히 있다가 메세지를 받는다 type이 온라인, 그럴 때, 내가 보낸메세지가 1이 되어있는걸 모두 없애준다.

        두명모두 접속했을 경우
        한명이 채팅을 보낸다. 그럼 handleTextMessage에 가지고 rls.get(i).size()가 3이면 readyn을 모두 업데이트하고 obj.put으로 ws.send를 보낼 때, readyn이 y로 보낸다.
        그러면 화면에서 자기가 보낸 메세지의 리턴을 받게 될텐데 readYn이 N이면, 1을 보여주면되고 Y면, 1을 안보여주면 된다.


     */

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    RoomService roomService;
    @Autowired
    ChatService chatService;

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {

        logger.info("handleTextMessage : 메세지 발송");
        logger.info("session  : {} : ", session);
        logger.info("session.getId()  : {} : ", session.getId());

        logger.info("message  : {} : ", message);
        logger.info("rls size  : {}", rls.size());
        logger.info("rls  : {}", rls);
        //메시지 수신시 실행
        //메세지발송
        String msg = message.getPayload();
        logger.info("msg  : {}", msg);
        JSONObject obj = jsonToObjectParser(msg);
        logger.info("obj  : {}", obj);
        logger.info("roomId  : {}", obj.get("roomId"));
        logger.info("type  : {}", obj.get("type"));

        String rN = (String) obj.get("roomId");
        HashMap<String, Object> temp = new HashMap<String, Object>();

        //rls.size는 방개수
        if (rls.size() > 0) {
            logger.info("rls.size가 있다면 개수: {}", rls.size());
            for (int i = 0; i < rls.size(); i++) {
                logger.info("roomId : {}", rls.get(i).get("roomId"));
                String roomId = (String) rls.get(i).get("roomId"); //세션리스트의 저장된 방번호를 가져와서
                if (roomId.equals(rN)) { //같은값의 방이 존재한다면
                    logger.info("같은값의 방이 존재한다면");
                    logger.info("roomId : {}", roomId);
                    logger.info("rls.get(i).size() : {}", rls.get(i).size());
                    //한명이면 2, 2명이면 3
                    if(rls.get(i).size() == 2) {
                        obj.put("readYn", "N");
                    }

                    //2명이면 catService 모두 업그레이드
                    if(rls.get(i).size() == 3) {
                        Chat chat = new Chat();
                        chat.setRoomId(Integer.parseInt(roomId));
                        chatService.updateChat(chat);
                        obj.put("readYn", "Y");
                    }
                    logger.info("rls.get(i) : {}", rls.get(i));
                    logger.info("id: {}", rls.get(i).get("id"));
                    logger.info("url(i) : {}", rls.get(i).get("url"));
                    logger.info("roomId(i) : {}", rls.get(i).get("roomId"));
                    temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                    logger.info("temp : {}", temp);
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

                        logger.info("obj.toJSONString() : {}", obj.toJSONString());
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
        logger.info(">>>afterConnectionEstablished  : 소켓연결");
        super.afterConnectionEstablished(session);
        boolean flag = false;
        String url = session.getUri().toString();
        logger.info("url: {}" , url);
        String roomId = url.split("/chating/")[1];
        logger.info("roomId {} " , roomId);


        int idx = rls.size(); //방의 사이즈를 조사한다.
        System.out.println("rls.size() : " + rls.size());
        if (rls.size() > 0) {
            for (int i = 0; i < rls.size(); i++) {
                String rN = (String) rls.get(i).get("roomId");
                logger.info("rN : {}" , rN);
                logger.info("i : {}" , i);
                if (rN.equals(roomId)) {
                    flag = true;
                    idx = i;
                    break;
                }
            }
        }

        logger.info("flag : {}" , flag);
        if (flag) { //존재하는 방이라면 세션만 추가한다.
            logger.info("존재하는 방이라면 세션만 추가한다.");
            logger.info("idx : {}" , idx);
            logger.info("session.getId() : {}" , session.getId());
            logger.info("session : {}" , session);

            //map에다가 왜 넣는거지??  , 주석하게 되면 본인이 사용한 메세지를 받을수 없다.
            //session_id, url, roomId


            for (int i = 0; i < rls.size(); i++) {

                    String rN = (String) rls.get(i).get("roomId");
                    if (roomId.equals(rN)) { //같은값의 방이 존재한다면
                        logger.info("rls.get(i) : {}", rls.get(i));
                        HashMap<String, Object> temp = new HashMap<String, Object>();
                        temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                        logger.info("temp : {}", temp);
                        logger.info("temp : {}", temp.get("id"));
                        //JSONObject obj = jsonToObjectParser(msg);
                        for (String k : temp.keySet()) {
                            logger.info("상대방 세션 아이디, k : {}", k);
                            if (k.equals("roomId")) { //다만 방번호일 경우에는 건너뛴다.
                                continue;
                            }
                            logger.info("temp.get(k) : {}", temp.get(k));
                            WebSocketSession wss = (WebSocketSession) temp.get(k);
                            logger.info("wss: {}", wss);
                            if (wss != null) {
                                try {
                                    Chat chat = new Chat();
                                    chat.setRoomId((Integer.parseInt(rN)));
                                    chatService.updateChat(chat);

                                    JSONObject obj = new JSONObject();
                                    obj.put("type", "online");

                                    wss.sendMessage(new TextMessage(obj.toJSONString()));
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    break;
                }

            logger.info("rls.get(idx) : {} " , rls.get(idx));
            HashMap<String, Object> map = rls.get(idx);
            map.put(session.getId(), session);
        } else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
            logger.info("최초 생성하는 방이라면 방번호와 세션을 추가한다. ");
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("roomId", roomId);
            logger.info("session.getId() : {} " , session.getId());
            logger.info("session : {} " , session);
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
