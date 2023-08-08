package com.example.self_board_project.file.mapper;

import com.example.self_board_project.file.vo.FileInfo;
import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface FileMapper {

    public void insertFile(FileInfo fileInfo);

}
