package com.example.self_board_project.notification.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Notification{
    private Integer id;
    private int userId;
    private String refId;
    private String field;
    private int relationshipCount;
    private int evaluationCount;
    private int totalNCount;
    private int totalCount;
    private String readYn;
    private Date createDate;

}
