package com.example.self_board_project.evaluation.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class Evaluation {
    private Integer id;
    private int evaluationId;
    private int receiveId;
    private int score;
    private Date createDate;
}
