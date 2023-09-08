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
    private String todayProfileId;
    private Date createDate;
    private Date updateDate;
    private Integer updateId;

    //간편로그인
    private String roleKey;
    private String picture;
    private String name;
    private String role;
    private String provider;
    private String providerId;
    private String username;


//  file
    private String bossType;
    private String imageName;
    private String flag;
    private String filepath;
    private String systemFilename;


}
