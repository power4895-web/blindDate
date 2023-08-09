package com.example.self_board_project.user.controller;


import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
//@RestController

public class UserController {

    @Autowired
    private UserService userService;
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
        return "user/updateForm";
    }

    @RequestMapping(value = "/updateForm/{id}", method = RequestMethod.GET)
    public String updateForm(Model model, @PathVariable int id) {
        System.out.println("id" + id);
        User userInfo = userService.selectUser(id);
        model.addAttribute("userInfo", userInfo);
        return "user/updateForm";
    }

    @ResponseBody
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public Integer userRegister(Model model, User user) {
       userService.insertUser(user);
        return user.getId();
    }
    @RequestMapping(value = "/login")
    public String userLoginForm(Model model, User user) {
        System.out.println(">>>>loginForm");
        return "user/login";
    }
    @RequestMapping(value = "/todayProfile")
    public String todayProfile(Model model, User user) {
        System.out.println(">>>>loginForm");
        return "user/todayProfile";
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
