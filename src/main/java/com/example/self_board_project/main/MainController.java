package com.example.self_board_project.main;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.configuration.SessionUser;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
@RequiredArgsConstructor
@Controller
public class MainController {
    private final HttpSession httpSession;
    @RequestMapping("/")
    public String main (Auth auth, Model model)
    {
        SessionUser user = (SessionUser) httpSession.getAttribute("user");
        if (user != null) {
            model.addAttribute("userName", user.getName());
        }
        return "front:main";
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
