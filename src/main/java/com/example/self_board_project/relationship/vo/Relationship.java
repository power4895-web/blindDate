package com.example.self_board_project.relationship.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Relationship {
    private Integer id;
    private int sendId;
    private int getId;
    private String acceptCheck;
    private Date createDate;
}
