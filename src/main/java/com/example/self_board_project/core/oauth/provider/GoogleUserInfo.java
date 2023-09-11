package com.example.self_board_project.core.oauth.provider;

import java.util.Map;

public class GoogleUserInfo implements OAuth2UserInfo{

    private Map<String,Object> attributes; //oAuth2User.getAttributes()
    public GoogleUserInfo(Map<String,Object> attributes) {
        System.out.println("구글생성자");
        this.attributes= attributes;
    }

    @Override
    public String getName() {
        System.out.println("getName");
        return (String) attributes.get("name");
    }

    @Override
    public String getGetProvider() {
        System.out.println("getGetProvider");
        return "google";
    }

    @Override
    public String getProviderId() {
        System.out.println("getProviderId");
        return (String) attributes.get("sub");
    }

    @Override
    public String getEmail() {
        System.out.println("getEmail");
        return (String) attributes.get("email");
    }
}
