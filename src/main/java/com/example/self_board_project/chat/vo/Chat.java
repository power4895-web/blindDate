package com.example.self_board_project.chat.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Setter
@Getter
public class Chat {
    private int id;
    private int roomId;
    private int fromId;
    private int toId;
    private int lastFromId;
    private String sessionId;
    private String content;
    private Date createDate;
    private Date lastCreateDate;
    private Date showCreateDate;
    private String readYn;

}
