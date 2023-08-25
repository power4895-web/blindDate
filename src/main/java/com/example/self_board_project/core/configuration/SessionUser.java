package com.example.self_board_project.core.configuration;

import java.io.Serializable;

import com.example.self_board_project.user.vo.User;
import lombok.Getter;
public class SessionUser implements Serializable {
    private String name ;
    private String email ;
    private String picture ;

    public SessionUser(User user) {
//        this.name = user.getName() ;
        this.email = user.getEmail() ;
//        this.picture = user.getPicture() ;
    }
}