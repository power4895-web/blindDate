package com.example.self_board_project.room.service;

import com.example.self_board_project.room.mapper.RoomMapper;
import com.example.self_board_project.room.vo.Room;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomService {
    @Autowired
    RoomMapper roomMapper;
    Logger logger = LoggerFactory.getLogger(getClass());

    public List<Room> selectRoomList(Room room) {
        logger.info("===selectRoomList Start");
        return roomMapper.selectRoomList(room);

    }

    public Room selectRoom(Room room) {
        logger.info("===selectRoom Start");
        return roomMapper.selectRoom(room);
    }

    public int insertRoom(Room room) {
        logger.info("===insertRoom Start");
        return roomMapper.insertRoom(room);
    }
    public int updateRoom(Room room) {
        logger.info("===updateRoom Start");
        return roomMapper.updateRoom(room);
    }
    public int quitRoom(Room room) {
        logger.info("===quitRoom Start");
        return roomMapper.quitRoom(room);
    }
    public int deleteRoom(int id) {
        logger.info("===quitRoom Start");
        return roomMapper.deleteRoom(id);
    }
}
