package com.example.self_board_project.user.controller;


import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.authority.AuthInfo;
import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
//@RestController

public class UserController {

    Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private UserService userService;

    @Autowired
    private FileService fileService;

    /**
     * 회원목록
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/list")
    public String userList(Model model) {
        return "main";
    }

    /**
     * 회원상세
     * @param model
     * @return
     */
    @RequestMapping(value = "/user/detail")
    public String userDetail(Model model) {
        logger.info("detail : {}" );
        return "main";
    }



    /**
     * 회원수정폼
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/updateForm/{id}", method = RequestMethod.GET)
    public String updateForm(Model model, @PathVariable int id) {
        logger.info("updateForm_id : {}" ,id);
        User user = new User();
        user.setId(id);
        User userInfo = userService.selectUser(user);

        FileInfo fileInfo = new FileInfo();
        fileInfo.setRefId(id);
        fileInfo.setFlag("S");
        List<FileInfo> fileList = fileService.selectFileList(fileInfo);
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("fileList", fileList);
        return "front:user/updateForm";
    }


    /**
     * 회원수정
     * @param model
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public boolean userUpdate(Model model, User user) {
        userService.updateUser(user);
        return true;
    }



    @RequestMapping(value = "/todayProfile")
    public String todayProfile(Model model, @AuthenticationPrincipal AuthInfo authInfo) {
        User user = new User();
        logger.info("todayProfile id :  {}" , authInfo.getUser().getId());
        user.setId(authInfo.getUser().getId());
        User userInfo = userService.selectUser(user);
        String ids = userInfo.getTodayProfileId();
        String todayIds[] = ids.split(",");

        List<User> dataList = new ArrayList<>();
        for (String item3 : todayIds) {
            User todayUser = new User();
            todayUser.setId(Integer.parseInt(item3));
            todayUser.setBossType("B");
            todayUser.setFlag("S");

            User userInfo2 = userService.selectUser(todayUser);
            dataList.add(userInfo2);
        }
        model.addAttribute("dataList", dataList);
//        for (User item4: dataList) {
//            System.out.println("item4" + item4.getId());
//            User userInfo2 = userService.selectUser(Integer.parseInt(item3));
//            dataList.add(userInfo2);
//        }


        return "front:user/todayProfile";
    }

    @RequestMapping(value = "/todayProfile/update")
    public void todayProfileUpdate(Model model, User user, Auth auth) {
        List<User> userList = userService.selectUserList();
        for (User item : userList) {
            String todayProfileId = "";
            if (item.getGender().equals("M")) {
                user.setGender("F");
                List<User> manRandomList = userService.selectUserRandomList(user);
                for (User item2 : manRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                userService.updateTodayProfileId(user);
            } else {
                user.setGender("M");
                List<User> womanRandomList = userService.selectUserRandomList(user);
                for (User item2 : womanRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                userService.updateTodayProfileId(user);
            }
        }
    }

//    @RequestMapping(value = "/login")
//    public void login(Model model, User user) {
//        System.out.println(">>>>register" +  user.getLoginId());
//        System.out.println(">>>>register" +  user.getPassword());
//    }
//    @RequestMapping(value = "/user/update")
//    public String userUpdate(Model model) {
//        System.out.println(">>>>userList");
//        List<User> boardLIst = userService.selectBoardList();
//        model.addAttribute("boardLIst", boardLIst);
//        return "main";
//    }
//    @RequestMapping(value = "/user/delete")
//    public String userDelete(Model model) {
//        System.out.println(">>>>userList");
//        List<User> boardLIst = userService.selectBoardList();
//        model.addAttribute("boardLIst", boardLIst);
//        return "main";
//    }
}
