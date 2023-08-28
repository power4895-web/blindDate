package com.example.self_board_project.core.configuration;

import java.io.Serializable;

import com.example.self_board_project.user.vo.User;
import lombok.Getter;
@Getter
public class SessionUser implements Serializable {

    SessionUser() {}
    public SessionUser(User user) {
        this.name = user.getName() ;
        this.email = user.getEmail() ;
        this.picture = user.getPicture() ;
    }
    private String nickname;

    private String email;

    private String picture;

    private String gender;

    private String age;
    private String name;


}