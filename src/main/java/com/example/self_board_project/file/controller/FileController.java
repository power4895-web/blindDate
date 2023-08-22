package com.example.self_board_project.file.controller;


import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
//@RestController

public class FileController {

    @Autowired
    private FileService fileService;

    @ResponseBody
    @RequestMapping(value="/fileUploadList/{division}/{refid}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<FileInfo> fileUploadList (@PathVariable String division, @PathVariable("refid") Integer refid) throws Exception {
        System.out.println("refid" + refid);
        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(refid);
        fileInfo.setDivision(division);
        fileInfo.setFlag("S");
        return fileService.selectFileList( fileInfo);
    }
    @ResponseBody
    @RequestMapping(value="/fileUpload/{division}/{refid}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public void  fileUpload (@RequestParam("file") List<MultipartFile> file, @PathVariable String division, @PathVariable("refid") Integer refid) throws Exception {
        System.out.println("refid" + refid);
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
        System.out.println("result" + result);
        return result;
    }
}
