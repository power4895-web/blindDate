package com.example.self_board_project.evaluation.vo;

import com.example.self_board_project.user.vo.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Evaluation extends User {
    private Integer id;
    private int evaluationId;
    private int receiveId;
    private int score;
    private String type;
    private Date createDate;
}
