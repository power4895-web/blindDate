package com.example.self_board_project.file.mapper;

import com.example.self_board_project.file.vo.FileInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileMapper {

    public void selectFileCount(FileInfo fileInfo);
    public List<FileInfo> selectFileList(FileInfo fileInfo);
    public void selectFile(FileInfo fileInfo);
    public void insertFile(FileInfo fileInfo);

}
