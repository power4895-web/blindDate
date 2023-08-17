package com.example.self_board_project.file.service;

import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.file.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;
@Service
public class FileService {

    private @Value("${file.root.path}") String fileRootPath;
    private @Value("${upload.resource.path}") String uploadResourcePath;
    @Autowired
    FileMapper fileMapper;
    public void insertFile(FileInfo fileInfo, List<MultipartFile> files)throws Exception {
        List< FileInfo> list = new ArrayList< FileInfo>();

        String currentDate = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
        String projectPath = fileRootPath +  currentDate + "/";
        String resourcePathName = uploadResourcePath +  currentDate + "/";
        File folder = new File(projectPath);
        if(!folder.isDirectory()) {
            System.out.println("폴더없음");
            folder.mkdirs();
        }

        if (null != files && files.size() > 0) {

            for(MultipartFile multipartFile : files) {
                UUID uuid = UUID.randomUUID();
                String filename = uuid + "_" + multipartFile.getOriginalFilename();
                File saveFile = new File(projectPath, filename);
                multipartFile.transferTo(saveFile);
                fileInfo.setSystemFilename(filename);
                fileInfo.setOriginalFilename(multipartFile.getOriginalFilename());
                fileInfo.setFilepath(resourcePathName);
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
