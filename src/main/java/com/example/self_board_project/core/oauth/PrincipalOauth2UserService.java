package com.example.self_board_project.core.oauth;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.authority.AuthInfo;
import com.example.self_board_project.core.oauth.provider.FacebookUserInfo;
import com.example.self_board_project.core.oauth.provider.GoogleUserInfo;
import com.example.self_board_project.core.oauth.provider.NaverUserInfo;
import com.example.self_board_project.core.oauth.provider.OAuth2UserInfo;
import com.example.self_board_project.user.mapper.AuthMapper;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private UserService userService ;
    @Autowired
    private AuthMapper mapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        logger.info("getClientRegistration : {}" , userRequest.getClientRegistration());
        logger.info("getTokenValue : {}" , userRequest.getAccessToken().getTokenValue());

        OAuth2User oAuth2User = super.loadUser(userRequest);
        logger.info("oAuth2User : {}" , oAuth2User);
        logger.info("getAttributes : {}" , oAuth2User.getAttributes());

        OAuth2UserInfo oAuth2UserInfo = null;
        if(userRequest.getClientRegistration().getRegistrationId().equals("google")) {
            oAuth2UserInfo = new GoogleUserInfo(oAuth2User.getAttributes());
        } else if (userRequest.getClientRegistration().getRegistrationId().equals("facebook")){
            oAuth2UserInfo = new FacebookUserInfo(oAuth2User.getAttributes());
        } else if (userRequest.getClientRegistration().getRegistrationId().equals("naver")) {
            oAuth2UserInfo = new NaverUserInfo((Map)oAuth2User.getAttributes().get("response"));
        } else {
            logger.info("우리는 구글,페이스북, 네이버만 지원합니다.");
        }

        String provider = oAuth2UserInfo.getGetProvider();
        String providerId = oAuth2UserInfo.getProviderId();
        String nickname = oAuth2UserInfo.getName();
        String username = provider + "_" + providerId; //필요는 없지만 그냥 만들어준다. 오스로 로그인했을 때
        String password = passwordEncoder.encode("겟인데어"); //필요는 없지만 그냥 만들어준다. 오스로 로그인했을 때, 겟인데어는 아무말이나 쓴것
        String email = oAuth2UserInfo.getEmail();
        String role = "ROLE_USER";

        Map<String, String> auth = new HashMap<String, String>();
        auth.put("username", username);
        Auth authInfo = (Auth)mapper.getUserInfo(auth);
        if(authInfo == null) {
            logger.info("OAuth 로그인이 최초입니다.");
            User user = new User();
            user.setPassword(password);
            user.setProvider(provider);
            user.setProviderId(providerId);
            user.setUsername(username);
            user.setLoginId(username);
            user.setRole(role);
            user.setEmail(email);
            user.setNickname(nickname);
            userService.insertUser(user);
            auth.put("id", String.valueOf(user.getId()));
            authInfo = (Auth)mapper.getUserInfo(auth);
        }
        return new AuthInfo(authInfo, oAuth2User.getAttributes()); //이 리턴이 authenticate 객체안에 들어간다.
        //일반적으로 로긴 하면 유저만 들고 있고, 오스로 로그인하면 유저랑 attibutes맵을 같이 들고 있게 된다.
    }
}
