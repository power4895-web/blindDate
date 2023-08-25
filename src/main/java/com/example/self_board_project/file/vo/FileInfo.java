package com.example.self_board_project.file.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class FileInfo {
    private Integer id;
    private Integer refId;
    private String filepath;
    private String originalFilename;
    private String systemFilename;
    private String uploadResourcePath;
    private String division;
    private String bossType;
    private Date createDate;
    private String imageName;
    private String flag;
    private List<Map<String,Object>> imageList;
}
