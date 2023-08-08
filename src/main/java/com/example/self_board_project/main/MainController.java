package com.example.self_board_project.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping(value="/")
    public static String main ()
    {
        return "main";
    }



}
