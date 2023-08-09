package com.example.self_board_project.user.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
@Getter
@Setter
public class User {
    private Integer id;
    private String loginId;
    private String password;
    private String nickname;
    private String realName;
    private String age;
    private String gender;
    private String email;
    private String phoneNumber;
    private String introduce;
    private Date createDate;
    private Date updateDate;
    private Integer updateId;
}
