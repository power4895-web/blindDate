package com.example.self_board_project.relationship.vo;

import com.example.self_board_project.user.vo.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Relationship extends User {
    private Integer id;
    private int userId;
    private int sendId;
    private int getId;
    private String acceptCheck;
    private String type;
    private Date createDate;


    //user
    private String nickname;

    //  file
    private String bossType;
    private String imageName;
    private String flag;
    private String filepath;
    private String systemFilename;
    private String imgUrl;

    //evaluate
    private Integer evaluateId;
    private int evaluationId;
    private int receiveId;
    private int score;

    //room
    private String roomYn;

    //chat
    private String lastMessage;
    private Date lastChatCreateDate;
    private int readIsNotCount;

}
