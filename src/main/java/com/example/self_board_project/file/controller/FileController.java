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
    @RequestMapping(value="/fileUpload/{division}/{refid}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public void  fileUpload (@RequestParam("file") List<MultipartFile> file, @PathVariable String division, @PathVariable("refid") String refid) throws Exception {
        FileInfo fileInfo = new FileInfo();
        fileService.insertFile( fileInfo, file);
    }
}
