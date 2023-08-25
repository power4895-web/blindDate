package com.example.self_board_project.main;

import com.example.self_board_project.core.authority.Auth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping(value="/")
    public static String main (Auth auth)
    {
        return "front:main";
    }
    @RequestMapping(value="/pricing")
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
