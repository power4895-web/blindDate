package com.example.self_board_project.user.vo;

import lombok.Getter;
import lombok.Setter;

import java.math.BigInteger;
import java.util.Date;
@Getter
@Setter
public class User {
    private BigInteger id;
    private String loginId;
    private String password;
    private String realName;
    private String nickname;
    private String gender;
    private String age;
    private String email;
    private String introduce;
    private String phoneNumber;
    private Date createDate;
    private Date updateDate;
}
