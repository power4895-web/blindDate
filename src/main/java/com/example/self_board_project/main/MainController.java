package com.example.self_board_project.main;

import com.example.self_board_project.core.authority.Auth;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping(value="/")
    public String main (Auth auth)
    {
        return "main";
    }



}
