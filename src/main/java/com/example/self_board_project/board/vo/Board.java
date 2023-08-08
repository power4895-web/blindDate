package com.example.self_board_project.board.vo;

import com.example.self_board_project.core.support.Pagination;
import lombok.Getter;
import lombok.Setter;

import java.math.BigInteger;
import java.util.Date;
@Getter
@Setter
public class Board extends Pagination {
    private Integer id;
    private BigInteger userId;
    private String title;
    private String content;
    private Date createDate;
    private Date updateDate;
    private Integer createId;
    private Integer updateId;

    //user
    private String loginId;

}
