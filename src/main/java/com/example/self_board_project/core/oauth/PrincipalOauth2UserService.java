package com.example.self_board_project.core.oauth;

import com.example.self_board_project.core.authority.Auth;
import com.example.self_board_project.core.authority.AuthInfo;
import com.example.self_board_project.user.mapper.AuthMapper;
import com.example.self_board_project.user.service.UserService;
import com.example.self_board_project.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
    @Autowired
    private UserService userService ;
    @Autowired
    private HttpSession httpSession ;
    @Autowired
    private AuthMapper mapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String provider = userRequest.getClientRegistration().getClientId(); //google
        String providerId = oAuth2User.getAttribute("sub");
        String username = provider + "_" + providerId; //필요는 없지만 그냥 만들어준다. 오스로 로그인했을 때
        String password = passwordEncoder.encode("겟인데어"); //필요는 없지만 그냥 만들어준다. 오스로 로그인했을 때
        String email = oAuth2User.getAttribute("email");
        String role = "ROLE_USER";

        Map<String, String> auth = new HashMap<String, String>();
        auth.put("username", username);
        Auth authInfo = (Auth)mapper.getUserInfo(auth);
        if(authInfo == null) {
            User user = new User();
            user.setPassword(password);
            user.setProvider(provider);
            user.setProviderId(providerId);
            user.setUsername(username);
            user.setLoginId(username);
            user.setRole(role);
            user.setEmail(email);
            userService.insertUser(user);
            System.out.println(">>>>>>" + user.getId());
            auth.put("id", String.valueOf(user.getId()));
            authInfo = (Auth)mapper.getUserInfo(auth);
        }
        System.out.println("authInfo" + authInfo.getId());
        return new AuthInfo(authInfo, oAuth2User.getAttributes()); //이 리턴이 authenticate 객체안에 들어간다.
        //일반적으로 로긴 하면 유저만 들고 있고, 오스로 로그인하면 유저랑 attibutes맵을 같이 들고 있게 된다.
    }
}
