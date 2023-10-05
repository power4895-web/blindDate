package com.example.self_board_project.user.vo;

import com.example.self_board_project.file.vo.FileInfo;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
public class User {
    private Integer id;
    private List<Integer> ids;
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

    private String addressDoro;
    private String addressJibun;
    private Double latitude;
    private Double longitude;
    private String addressDetail;
    private String postalCode;
    private String gradeScore;
    private String gradeCode;
    private String job;
    private String workplace;
    private String purpose;
    private double distance;

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

    private String smokingYn;
    private String drinkingType;
    private String religionType;
    private String petType;
    private String hobby;
    private String idealType;
    private String mbti;
    private int height;
    private String academic;
    private String bodyType;
    private String personality;

//  file
    private String bossType;
    private String imageName;
    private String flag;
    private String filepath;
    private String systemFilename;
    private String imgUrl;
    private List<FileInfo> fileList;


    //relationship
    private String sendYn;

}
