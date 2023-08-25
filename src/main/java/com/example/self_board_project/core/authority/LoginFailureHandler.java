package com.example.self_board_project.core.authority;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler  {

    protected Log logger = LogFactory.getLog(this.getClass());

    private String defaultFailureUrl = "";

    public LoginFailureHandler(String defaultFailureUrl) {
        this.defaultFailureUrl = defaultFailureUrl;
    }
    
    @Override
    public void onAuthenticationFailure(
        HttpServletRequest request, HttpServletResponse response, AuthenticationException exception
    ) throws IOException, ServletException {
        System.out.println("onAuthenticationFailure" );
        
     // Ajax 로그인 응답일 경우
        if( request.getHeader("AJAX") != null  && request.getHeader("AJAX").equals(Boolean.TRUE.toString())){
            System.out.println("Ajax 로그인 응답일 경우");
        	Map<String,Object> map = new HashMap<String, Object>();
        	map.put("isLogin", false);
        	MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
	        MediaType jsonMimeType = MediaType.APPLICATION_JSON;
            jsonConverter.write(map, jsonMimeType, new ServletServerHttpResponse(response));
            
      // 폼방식 로그인      
        }else {
        	RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
        	redirectStrategy.sendRedirect(request, response, this.defaultFailureUrl);
        }
        
        
        
    }
}