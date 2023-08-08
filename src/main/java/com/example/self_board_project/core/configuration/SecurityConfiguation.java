package com.example.self_board_project.core.configuration;

import com.example.self_board_project.core.authority.AuthService;
import com.example.self_board_project.core.authority.LoginFailureHandler;
import com.example.self_board_project.core.authority.LoginSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfiguation extends WebSecurityConfigurerAdapter {

    @Autowired
    private AuthService authService;
    // 스프링 시큐리티가 사용자를 인증하는 방법이 담긴 객체
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth.userDetailsService(authService).passwordEncoder(new BCryptPasswordEncoder());
        //실제 인증을 진행할 Provider
    }
    /*
     * 스프링 시큐리티 룰을 무시할 URL 규칙 설정
     * 정적 자원에 대해서는 Security 설정을 적용하지 않음
     */
    @Override
    public void configure(WebSecurity web) {
        //이미지,자바스크립트,css 디렉토리 보안 설정
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //HTTP 관련 보안 설정 **가장 중요

        http
                .headers()
                .addHeaderWriter(new XFrameOptionsHeaderWriter(XFrameOptionsHeaderWriter.XFrameOptionsMode.SAMEORIGIN))		//X-Frame-Options 셋팅 , 크로스 사이트 스크립트 방지 해재 default 'DENY'
                .and()
                .addFilterAfter(new AjaxSessionTimeoutFilter(), ExceptionTranslationFilter.class)		//Ajax Session time out 체크, redirect 되기전에 상태 코드를 전송하게함
                .csrf().disable()
                .authorizeRequests()
			.antMatchers( "/login" ).permitAll()
                .and()
                .formLogin()
                .loginPage( "/login" )
                .loginProcessingUrl( "/loginProc" )
                .defaultSuccessUrl( "/" )
                .successHandler(new LoginSuccessHandler(authService))
                .failureHandler(new LoginFailureHandler("/login?err=1"))
                .usernameParameter( "loginId" )
                .passwordParameter( "password" )
                .and()
                .logout()
                .logoutRequestMatcher( new AntPathRequestMatcher( "/logout" ) )
                .logoutSuccessUrl( "/" )
                .deleteCookies( "JSESSIONID" )
//                .deleteCookies( "REMEMBER_ME_COOKE" )
                .invalidateHttpSession( true )
                .and()

        ;

    }
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }


}