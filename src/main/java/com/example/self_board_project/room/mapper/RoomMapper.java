package com.example.self_board_project.room.mapper;

import com.example.self_board_project.room.vo.Room;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RoomMapper {
    public List<Room> selectRoomList (Room room) ;
    public Room selectRoom (Room room);

    public int insertRoom(Room room);
    public int updateRoom(Room room);
    public int quitRoom(Room room);
    public int deleteRoom(int id);
}
