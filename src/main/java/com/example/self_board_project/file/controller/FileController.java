package com.example.self_board_project.file.controller;


import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
//@RestController

public class FileController {

    Logger logger = LoggerFactory.getLogger(getClass());


    @Autowired
    private FileService fileService;

    /**
     * 파일목록
     * @param division
     * @param refid
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value="/fileUploadList/{division}/{refid}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<FileInfo> fileUploadList (@PathVariable String division, @PathVariable("refid") Integer refid) throws Exception {
        logger.info("refId : {}" + refid);
        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(refid);
        fileInfo.setDivision(division);
        return fileService.selectFileList( fileInfo);
    }

    /**
     * 파일등록
     * @param file
     * @param division
     * @param refid
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value="/fileUpload/{division}/{refid}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public void  fileUpload (@RequestParam("file") List<MultipartFile> file, @PathVariable String division, @PathVariable("refid") Integer refid) throws Exception {
        logger.info("fileUpload insert_ refId : {}" + refid);
        logger.info("file : {}" + file);
        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(refid);
        fileInfo.setDivision(division);
        fileService.insertFile( fileInfo, file);
    }

    /**
     * 파일삭제
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deleteFile/{id}")
    public boolean deleteFile(@PathVariable String id) {
        boolean result = fileService.deleteFile(id);
        int originalId = Integer.parseInt(id)- 1;
        FileInfo fileOriginal = fileService.selectFile(String.valueOf(originalId));
        if(fileOriginal.getFlag().equals("O")) {
            logger.info("O일 때");
            result = fileService.deleteFile(String.valueOf(originalId));
        }

        int MediumId = Integer.parseInt(id)+ 1;
        FileInfo fileMedium = fileService.selectFile(String.valueOf(MediumId));
        if(fileMedium.getFlag().equals("M")) {
            logger.info("M일 때");
            result = fileService.deleteFile(String.valueOf(MediumId));
        }
        return result;
    }
}
