package com.example.self_board_project.core.oauth.provider;

public interface OAuth2UserInfo {
    String getProviderId();
    String getGetProvider();
    String getEmail();
    String getName();
}
