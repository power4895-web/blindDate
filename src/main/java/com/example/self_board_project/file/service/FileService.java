package com.example.self_board_project.file.service;

import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.file.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
@Service
public class FileService {


    @Autowired
    FileMapper fileMapper;
    public void insertFile(FileInfo fileInfo, List<MultipartFile> files)throws Exception {
        List< FileInfo> list = new ArrayList< FileInfo>();

        String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
        System.out.println("files.size()" + files.size());
        if (null != files && files.size() > 0) {

            for(MultipartFile multipartFile : files) {
                UUID uuid = UUID.randomUUID();
                String filename = uuid + "_" + multipartFile.getOriginalFilename();
                File saveFile = new File(projectPath, filename);
                multipartFile.transferTo(saveFile);
                fileInfo.setSystemFilename(filename);
                fileInfo.setOriginalFilename(multipartFile.getOriginalFilename());
                fileInfo.setFilepath("/files" + projectPath);
                fileMapper.insertFile(fileInfo);
            }
        }
    }
    public void insertFile2(FileInfo fileInfo, MultipartFile file)throws Exception {
        String projectPath = System.getProperty("user.dir") + "\\src\\main\\resources\\static\\files";
        UUID uuid = UUID.randomUUID();
        System.out.println("insertFile" + file.getOriginalFilename());
        String filename = uuid + "_" + file.getOriginalFilename();

        File saveFile = new File(projectPath, filename);
        file.transferTo(saveFile);
        fileInfo.setSystemFilename(filename);
        fileInfo.setOriginalFilename(file.getOriginalFilename());
        fileInfo.setFilepath("/files" + projectPath);
        fileMapper.insertFile(fileInfo);

    }


}
