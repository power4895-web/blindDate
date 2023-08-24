package com.example.self_board_project.user.controller;


import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private UserService userService;
    @Autowired
    private FileService fileService;
    @RequestMapping(value = "/user/list")
    public String userList(Model model) {
        System.out.println(">>>>list");
        return "main";
    }
    @RequestMapping(value = "/user/detail")
    public String userDetail(Model model) {
        System.out.println(">>>>detail");
        return "main";
    }
    @RequestMapping(value = "/registerForm")
    public String userRegisterForm(Model model, User user) {
        System.out.println(">>>>registerForm");
        return "front:user/registerForm";
    }
    @RequestMapping(value = "/registerForm2")
    public String userRegisterForm2(Model model, User user) {
        System.out.println(">>>>registerForm");
        return "user/registerForm2";
    }

    @RequestMapping(value = "/updateForm/{id}", method = RequestMethod.GET)
    public String updateForm(Model model, @PathVariable int id) {
        System.out.println("id" + id);
        User user = new User();
        user.setId(id);
        User userInfo = userService.selectUser(user);
        System.out.println("userInfo");

        FileInfo fileInfo = new FileInfo();
//        fileInfo.setBossType("Y");
        fileInfo.setRefId(id);
        fileInfo.setFlag("S");
        List<FileInfo> fileList = fileService.selectFileList(fileInfo);
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("fileList", fileList);
        return "front:user/updateForm";
    }
    //레이아웃적용 안한거 테스트 > 레이아웃 끝나면 지울것
    @RequestMapping(value = "/updateForm2/{id}", method = RequestMethod.GET)
    public String updateForm2(Model model, @PathVariable int id) {
        System.out.println("id" + id);
        User user = new User();
        user.setId(id);
        User userInfo = userService.selectUser(user);
        System.out.println("userInfo");

        FileInfo fileInfo = new FileInfo();
//        fileInfo.setBossType("Y");
        fileInfo.setRefId(id);
        fileInfo.setFlag("S");
        List<FileInfo> fileList = fileService.selectFileList(fileInfo);
        model.addAttribute("userInfo", userInfo);
        model.addAttribute("fileList", fileList);
//        return "/user/updateForm";
        return "/user/updateForm2";
    }

    @ResponseBody
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public Integer userRegister(Model model, User user) {
       userService.insertUser(user);
       return user.getId();
    }
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public boolean userUpdate(Model model, User user) {
       userService.updateUser(user);
       return true;
    }
    @RequestMapping(value = "/login")
    public String userLoginForm(Model model, User user) {
        System.out.println(">>>>loginForm");
        return "user/login";
    }
    @RequestMapping(value = "/todayProfile")
    public String todayProfile(Model model, Auth auth) {

        System.out.println(">>>>todayProfile");
        User user = new User();
        user.setId(auth.getId());
        User userInfo = userService.selectUser(user);
        String ids = userInfo.getTodayProfileId();
        String todayIds[] = ids.split(",");

        List<User> dataList = new ArrayList<>();
        for (String item3: todayIds) {
            System.out.println(">>>>" + item3);
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
 

        return "user/todayProfile";
    }
    @RequestMapping(value="/todayProfile/update")
    public void todayProfileUpdate(Model model, User user, Auth auth) {
        List<User> userList = userService.selectUserList();
        for (User item: userList) {
            String todayProfileId = "";
            if(item.getGender().equals("M")) {
                user.setGender("F");
                List<User> manRandomList = userService.selectUserRandomList(user);
                for (User item2: manRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                userService.updateTodayProfileId(user);
//                String test[] = ids.split(",");
//                System.out.println("test : " + test);
//                List<String> dataList = new ArrayList<>();
//                for (String item3: test) {
//                    System.out.println("item3 : " + item3);
//                }
            } else {
                user.setGender("M");
                List<User> womanRandomList = userService.selectUserRandomList(user);
                for (User item2: womanRandomList) {
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
