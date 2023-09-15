package com.example.self_board_project.core.authority;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;


public class LoginFailureHandler extends SimpleUrlAuthenticationFailureHandler  {

    protected Log logger = LogFactory.getLog(this.getClass());

    private String defaultFailureUrl = "";

    public LoginFailureHandler(String defaultFailureUrl) {
        System.out.println("defaultFailureUrl" + defaultFailureUrl);
        this.defaultFailureUrl = defaultFailureUrl;
    }
    
    @Override
    public void onAuthenticationFailure(
        HttpServletRequest request, HttpServletResponse response, AuthenticationException exception
    ) throws IOException, ServletException {
        logger.info("onAuthenticationFailure {} : ", exception);
        String errorMessage;
        if(exception instanceof BadCredentialsException) {
            errorMessage = "아이디 또는 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if (exception instanceof InternalAuthenticationServiceException) {
            errorMessage = "내부 시스템 문제로 로그인 요청을 처리할 수 없습니다. 관리자에게 문의하세요. ";//아이디 중복일 때
        } else if (exception instanceof UsernameNotFoundException) {
            errorMessage = "존재하지 않는 계정입니다. 회원가입 후 로그인해주세요.";
        } else if (exception instanceof AuthenticationCredentialsNotFoundException) {
            errorMessage = "인증 요청이 거부되었습니다. 관리자에게 문의하세요.";
        } else {
            errorMessage = "알 수 없는 오류로 로그인 요청을 처리할 수 없습니다. 관리자에게 문의하세요.";
        }
        //아이디가 없거나 아이디와 비밀번호가 서로 맞지 않으면 BadCredentialsException이다. 보완상 이게 더 맞다. UsernameNotFoundException은 필요없긴하다.
        errorMessage = URLEncoder.encode(errorMessage, "UTF-8"); /* 한글 인코딩 깨진 문제 방지, 자바에서는 decode해줘야 한글로 보이고 이걸 jsp에서 보려면 encode해서 보내야한다.*/
        logger.info("errorMessage: {} " + errorMessage);

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
            setDefaultFailureUrl("/loginFail?error=true&exception="+errorMessage);
            super.onAuthenticationFailure(request, response, exception);
        }
    }
}