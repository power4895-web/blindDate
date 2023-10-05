package com.example.self_board_project.main;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.authority.AuthInfo;
import com.example.self_board_project.core.oauth.SessionUser;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@RequiredArgsConstructor
@Controller
public class MainController {
    Logger logger = LoggerFactory.getLogger(getClass());
    private final HttpSession httpSession;

    @Autowired
    private UserService userService;
    @RequestMapping("/")
    public String main (Auth auth, Model model)
    {
        SessionUser user = (SessionUser) httpSession.getAttribute("user");
        if (user != null) {
            model.addAttribute("userName", user.getName());
        }
        return "front:main";
    }
    @GetMapping(value = "/user")
    public @ResponseBody String user(@AuthenticationPrincipal AuthInfo authInfo, Auth auth) {
        return "user";
    }

    @Secured("ROLE_ADMIN")
    @GetMapping(value = "/admin")
    public @ResponseBody String admin() {
        return "admin";
    }
    @GetMapping(value = "/manager")
    public @ResponseBody String manager() {
        return "manager";
    }
    /**
     * 로그인폼
     * @param model
     * @param user
     * @return
     */
    @RequestMapping(value = "/loginForm")
    public String userLoginForm(Model model, User user) {
        logger.info("loginForm");
        return "front:user/loginForm";
    }

    @GetMapping(value = "/loginFail")
    public String loginFail(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "exception", required = false) String exception,
                            Model model) {
        logger.info("loginFail");
        logger.info("error : {}", error);
        logger.info("exception : {}", exception);
        model.addAttribute("error", error);
        model.addAttribute("exception", exception);
        return "front:user/loginForm";
    }
    /**
     * 회원가입 폼
     * @param model
     * @param user
     * @return
     */
    @RequestMapping(value = "/registerForm")
    public String userRegisterForm(Model model, User user) {
        return "front:user/registerForm";
    }

    /**
     * 회원등록
     * @param model
     * @param user
     * @return
     */

    @ResponseBody
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public Integer userRegister(Model model, User user) {
        userService.insertUser(user);
        return user.getId();
    }



    @RequestMapping(value="/pricing2")
    @ResponseBody
    public User price2 ( User user)
    {
        logger.info(">>>>>>>>>>>>>>>>>getLoginId : " + user.getLoginId());
        return user;
    }
    @RequestMapping(value="/pricing")
    public String price (User user) throws IOException {
        logger.info("pricing start");
        return "front:pricing";
    }


    @RequestMapping(value="/about")
    public static String about (Auth auth)
    {
        return "front:about";
    }



}
