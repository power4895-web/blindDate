package com.example.self_board_project.room.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Room {
    private int id;
    private int roomNumber;
    private String roomName;
    private int roomId;
    private int roomBossId;
    private int roomStaffId;
    private String sessionId;
    private String session;
    private Date createDate;
}
