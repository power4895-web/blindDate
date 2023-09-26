package com.example.self_board_project.core.configuration;

import com.example.self_board_project.core.authority.AuthService;
import com.example.self_board_project.core.authority.LoginFailureHandler;
import com.example.self_board_project.core.authority.LoginSuccessHandler;
import com.example.self_board_project.core.oauth.CustomOAuth2UserService;
import com.example.self_board_project.core.oauth.PrincipalOauth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfiguation extends WebSecurityConfigurerAdapter {


    private final CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private PrincipalOauth2UserService principalOauth2UserService;

    @Autowired
    private AuthService authService;

    public SecurityConfiguation(CustomOAuth2UserService customOAuth2UserService) {
        this.customOAuth2UserService = customOAuth2UserService;
    }

    // 스프링 시큐리티가 사용자를 인증하는 방법이 담긴 객체
//    @Override
//    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
//        auth.userDetailsService(authService).passwordEncoder(new BCryptPasswordEncoder());
//        //실제 인증을 진행할 Provider
//    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //시큐리티 설정을 하면 csrf의 공격으로 방어를 해준다. 그래서 외부에서 요청하는 api가 못들어오는 경우가 있다. 그래서 disable해주면 다 허용해준다는 것이다.
        //하지만 배포할 때 문제점이 있다. 배포했을 때 공격을 받을 수 있다는 것이다. 그래서 스프링에서는 권장하지 않는다. 그래서 나는 mail만 예외처리를 했다.
        //주석해버리면 loginProc도 403에러가 난다, form, ajax를 통해 서버로 요청할 때 모두 403이 뜬다. 그래서 form, ajax시
        // CSRF 토큰 값이 세션에 저장되어있는데 form에는
        // <input type="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}"> 이걸함께, ajax에는 header에 넣어서 보내면 403이 안뜬다.
        http.csrf().disable();
//        http.csrf().ignoringAntMatchers("/mail/**");//이메일만 csrf예외처리가 되긴 한다.
//        http.csrf().ignoringAntMatchers("/loginProc/**");//이메일만 csrf예외처리가 되긴 한다.
        http.authorizeRequests()

                .antMatchers("/user","/relationship","/evaluation/**").authenticated()
                .antMatchers("/manager/**").access("hasRole('ROLE_ADMIN') or hasRole('ROLE_MANAGER')")
                .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
                .anyRequest().permitAll()
                .and()
                .formLogin()
                .loginPage("/loginForm")
                .loginProcessingUrl("/loginProc")
                .defaultSuccessUrl( "/" )
                .successHandler(new LoginSuccessHandler(authService))
                .failureHandler(new LoginFailureHandler("/login?err=1"))
                .usernameParameter( "loginId" )
                .passwordParameter( "password" )
                .and()
                .oauth2Login()
                .loginPage("/loginForm")
                .userInfoEndpoint()
                .userService(principalOauth2UserService);

        ;

    }
    @Bean
    public static PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }


}