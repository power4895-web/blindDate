package com.example.self_board_project.main;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.authority.AuthInfo;
import com.example.self_board_project.core.oauth.SessionUser;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
@RequiredArgsConstructor
@Controller
public class MainController {
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
        System.out.println("auth : " + authInfo.getUser());
        System.out.println("auth : " + auth.getId());
        System.out.println("auth : " + auth);

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
        System.out.println(">>>>loginForm");
        return "front:user/login";
    }
    /**
     * 회원가입 폼
     * @param model
     * @param user
     * @return
     */
    @RequestMapping(value = "/registerForm")
    public String userRegisterForm(Model model, User user) {
        System.out.println(">>>>registerForm");
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
        System.out.println("userRegister");
        userService.insertUser(user);
        return user.getId();
    }



    @RequestMapping(value="/pricying")
    public static String price (Auth auth)
    {
        return "front:pricing";
    }
    @RequestMapping(value="/about")
    public static String about (Auth auth)
    {
        return "front:about";
    }



}
