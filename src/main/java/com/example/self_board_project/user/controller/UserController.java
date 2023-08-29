package com.example.self_board_project.user.controller;


import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.file.service.FileService;
import com.example.self_board_project.file.vo.FileInfo;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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


    @ResponseBody
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public Integer userRegister(Model model, User user) {
        System.out.println("userRegister");
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
        return "front:user/login";
    }

    //    @RequestMapping(value = "/login/oauth2/code/naver")
    @GetMapping("/login/oauth2/code/naver")
    public OAuth2User naverLogin2(Authentication authentication , @AuthenticationPrincipal OAuth2User oauth) {
        System.out.println("네이버에서 콜백!!!!!!!!!!!!");


        // @AuthenticationPrincipal이라는 어노테이션을 통해서 세션정보를 받을 수 있다.
        System.out.println("=====IndexController.testLogin====");
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        System.out.println("oAuth2User.getAttributes() = " + oAuth2User.getAttributes());
        // oAuth2User.getAttributes() = {sub=103489475512635244738, name=‍고경환[재학 / 정보통신공학과], given_name=고경환[재학 / 정보통신공학과], family_name=‍, profile=https://plus.google.com/103489475512635244738, picture=https://lh3.googleusercontent.com/a/AItbvmlIUxyycyZvUHNNhzX20-5mvGrmrDbw6G1_Ylqn=s96-c, email={이메일}, email_verified=true, locale=ko, hd=hufs.ac.kr}
        System.out.println("oauth.getAttributes() = " + oauth.getAttributes());
        // oauth.getAttributes() = {sub=103489475512635244738, name=‍고경환[재학 / 정보통신공학과], given_name=고경환[재학 / 정보통신공학과], family_name=‍, profile=https://plus.google.com/103489475512635244738, picture=https://lh3.googleusercontent.com/a/AItbvmlIUxyycyZvUHNNhzX20-5mvGrmrDbw6G1_Ylqn=s96-c, email={이메일}, email_verified=true, locale=ko, hd=hufs.ac.kr}
        return oAuth2User;
    }
    @GetMapping("/test/oauth/login")
    public @ResponseBody String testOAuthLogin(Authentication authentication , @AuthenticationPrincipal OAuth2User oauth){// DI(의존성주입)
        // @AuthenticationPrincipal이라는 어노테이션을 통해서 세션정보를 받을 수 있다.
        System.out.println("=====IndexController.testLogin====");
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();
        System.out.println("oAuth2User.getAttributes() = " + oAuth2User.getAttributes());
        // oAuth2User.getAttributes() = {sub=103489475512635244738, name=‍고경환[재학 / 정보통신공학과], given_name=고경환[재학 / 정보통신공학과], family_name=‍, profile=https://plus.google.com/103489475512635244738, picture=https://lh3.googleusercontent.com/a/AItbvmlIUxyycyZvUHNNhzX20-5mvGrmrDbw6G1_Ylqn=s96-c, email={이메일}, email_verified=true, locale=ko, hd=hufs.ac.kr}
        System.out.println("oauth.getAttributes() = " + oauth.getAttributes());
        // oauth.getAttributes() = {sub=103489475512635244738, name=‍고경환[재학 / 정보통신공학과], given_name=고경환[재학 / 정보통신공학과], family_name=‍, profile=https://plus.google.com/103489475512635244738, picture=https://lh3.googleusercontent.com/a/AItbvmlIUxyycyZvUHNNhzX20-5mvGrmrDbw6G1_Ylqn=s96-c, email={이메일}, email_verified=true, locale=ko, hd=hufs.ac.kr}
        return "세션 정보 확인하기";
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
