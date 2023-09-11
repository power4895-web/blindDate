package com.example.self_board_project.core.authority;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler  {

    Logger logger = LoggerFactory.getLogger(getClass());
    
  private AuthService authService;
    
    public LoginSuccessHandler(UserDetailsService authService) {
        this.authService = (AuthService)authService;
    }

    
    @Override
    public void onAuthenticationSuccess(
        HttpServletRequest request, HttpServletResponse response,  Authentication authentication)
    throws ServletException, IOException {
        logger.info("onAuthenticationSuccess");
        logger.info("authentication.getPrincipal() : {}" , authentication.getPrincipal());
        AuthInfo user = (AuthInfo) authentication.getPrincipal();
//        OAuth2User user = (OAuth2User) authentication.getPrincipal();
//        System.out.println("user" + user.getUsername());
        MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
        MediaType jsonMimeType = MediaType.APPLICATION_JSON;
        if(user != null) {
        	
        	HttpSession session = request.getSession();
            session.setMaxInactiveInterval(60 * 30);		//초단위 30분
            
            //로그인 시간 저장
//            String ip = SysUtil.getRemoteIp(request);
//            authService.insertLoginLog(user.getUser().getId(),ip);
            

            // Ajax 로그인 응답일 경우
            if( request.getHeader("AJAX") != null  && request.getHeader("AJAX").equals(Boolean.TRUE.toString())){
                System.out.println("Ajax 로그인 응답일 경우");
                Map<String,Object> map = new HashMap<String, Object>();
            	map.put("isLogin", true);
                jsonConverter.write(map, jsonMimeType, new ServletServerHttpResponse(response));
            }else {
           		super.onAuthenticationSuccess(request, response, authentication);
            }
            
        }
        
    }
   

}