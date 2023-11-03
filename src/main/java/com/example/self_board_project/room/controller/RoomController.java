package com.example.self_board_project.room.controller;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.room.service.RoomService;
import com.example.self_board_project.room.vo.Room;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class RoomController {
    Logger logger = LoggerFactory.getLogger(getClass());
    List<Room> roomList = new ArrayList<Room>();
    static int roomNumber = 0;
    @Autowired
    RoomService roomService;
    @Autowired
    RelationshipService relationshipService;

    @RequestMapping(value="/room")
    public String room(Auth auth) {
        System.out.println("chat");
        return "user/room";
    }

    /**
     * 방생성하기
     * @param model
     * @param auth
     * @param room
     * @return
     */
    @RequestMapping("/room/insert")
    @ResponseBody
    public int insertRoom(Model model , Auth auth, Room room){
        logger.info("====createRoom");
//        logger.info("====setRoomName : {}", room.getRoomName());
        logger.info("====getRoomBossId = get= 나 : {}", room.getRoomBossId());
        logger.info("====getRoomStaffId = send =상대방 : {}", room.getRoomStaffId());

        int oldBossId = room.getRoomBossId();
        int oldStaffId = room.getRoomStaffId();

        Room myRoomInfo = roomService.selectRoom(room);
        Room room2 = new Room();
        room2.setRoomBossId(oldStaffId);
        room2.setRoomStaffId(oldBossId);
        Room yourRoomInfo = roomService.selectRoom(room2);

        if(myRoomInfo == null && yourRoomInfo == null) {
            roomService.insertRoom(room);
            return room.getId();
        } else {
            if(myRoomInfo == null) {
                return yourRoomInfo.getId();
            } else {
                return myRoomInfo.getId();
            }
        }
    }

    @RequestMapping("/createRoom")
//    public @ResponseBody List<Room> createRoom(@RequestParam String params){
    public @ResponseBody List<Room> createRoom(@RequestParam HashMap<Object, Object> params){
//        String roomName = params;
        String roomName = (String)params.get("roomName");
//        System.out.println("roomName" + roomName);
        if(roomName != null && !roomName.trim().equals("")) {
            Room room = new Room();
            room.setRoomNumber(++roomNumber);
            room.setRoomName(roomName);
            roomList.add(room);
        }
        return roomList;
    }

    /**
     * 방 정보가져오기
     * @param params
     * @return
     */
    @RequestMapping("/getRoom")
    public @ResponseBody List<Room> getRoom(@RequestParam HashMap<Object, Object> params){
        return roomList;
    }



    /**
     * 채팅방
     * @return
     */
    @RequestMapping("/moveChating")
    public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
        ModelAndView mv = new ModelAndView();
        int roomNumber = Integer.parseInt((String) params.get("roomNumber"));

        List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
        System.out.println("new_list : " + new_list);
        System.out.println("new_list.size() : " + new_list.size());
        if(new_list != null && new_list.size() > 0) {
            System.out.println("/user/chat");
            mv.addObject("roomName", params.get("roomName"));
            mv.addObject("roomNumber", params.get("roomNumber"));
            mv.setViewName("chat/chat");
        }else {
            System.out.println("/user/room");
            mv.setViewName("/user/room");
        }
        return mv;
    }

    /**
     * 채팅방 나가기(최초 나갔을 때, 한명이 나간상태에서 다른 사람이 나갔을 때 방 상제)
     * @param room
     * @param userId
     * @param yourId
     * @return
     */
    @RequestMapping("/room/quit")
    @ResponseBody
    public boolean quitRoom(Room room, @RequestParam int userId, @RequestParam(required = false) int yourId){

        logger.info("room : {}", room.getId());
        logger.info("userId : {}", userId);
        logger.info("yourId : {}", yourId);
        Room roomInfo = roomService.selectRoom(room);
        Relationship relationship = new Relationship();

        if(roomInfo != null) {
            logger.info("roomInfo.getQuitId() : {}", roomInfo.getQuitId());
            if(roomInfo.getQuitId() != 0) {
                relationship.setSendId(roomInfo.getQuitId());
                relationship.setGetId(userId);
                Relationship relationshipInfo =  relationshipService.selectRelationship(relationship);
                if(relationshipInfo != null) {
                    logger.info("친구요청 지우기");
                    relationshipService.deleteRelationship(relationshipInfo.getId());
                }
                logger.info("한명이 나간상태 ->  room지우기");
                roomService.deleteRoom(room.getId());
            } else {
                logger.info("현재 2명이 있는 상태 > 한명이 나가는중");

                //내가 친구해요 지우기
                relationship.setSendId(yourId);
                relationship.setGetId(userId);
                Relationship relationshipInfo =  relationshipService.selectRelationship(relationship);
                if(relationshipInfo != null) {
                    relationshipService.deleteRelationship(relationshipInfo.getId());
                }
                //상대방이 친구해요 > quit_yn > y로 바꾸기
                relationship.setQuitYn("Y");
                relationship.setSendId(userId);
                relationship.setGetId(yourId);
                relationshipService.allowRelationship(relationship);

                if(roomInfo != null) {
                    room.setQuitId(userId);
                    roomService.quitRoom(room);
                }
            }
        }
        return true;
    }

//    @RequestMapping("/moveChating")
//    public ModelAndView chating(@RequestParam HashMap<Object, Object> params) {
//        ModelAndView mv = new ModelAndView();
//        int roomNumber = Integer.parseInt((String) params.get("roomNumber"));
//
//        List<Room> new_list = roomList.stream().filter(o->o.getRoomNumber()==roomNumber).collect(Collectors.toList());
//        if(new_list != null && new_list.size() > 0) {
//            mv.addObject("roomName", params.get("roomName"));
//            mv.addObject("roomNumber", params.get("roomNumber"));
//            mv.setViewName("chat");
//        }else {
//            mv.setViewName("room");
//        }
//        return mv;
//    }

}
