package com.example.self_board_project.room.controller;

import com.example.self_board_project.core.authority.Auth;
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
        logger.info("====setRoomName : {}", room.getRoomBossId());
        logger.info("====setRoomName : {}", room.getRoomStaffId());
//        room.setRoomNumber(++roomNumber);
        Room roomInfo = roomService.selectRoom(room);
        if(roomInfo == null) {
            return roomService.insertRoom(room);
        } else {
            return roomInfo.getId();
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
            mv.setViewName("/user/chat");
        }else {
            System.out.println("/user/room");
            mv.setViewName("/user/room");
        }
        return mv;
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
