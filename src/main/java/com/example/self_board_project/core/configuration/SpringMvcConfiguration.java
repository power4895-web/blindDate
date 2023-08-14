package com.example.self_board_project.core.configuration;

import com.example.self_board_project.core.authority.UserHandlerMethodArgumentResolver;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.List;

@Configuration
public class SpringMvcConfiguration implements WebMvcConfigurer {

    private @Value("${file.root.path") String fileRootPath;
    private @Value("${deploy}") String deploy;
    /**
     * User argumentResolvers
     */
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(userHandlerMethodArgumentResolver());
    }

    /**
     * argument를 이용한 로그인 사용자 정보
     *
     * @return
     */
    @Bean
    public UserHandlerMethodArgumentResolver userHandlerMethodArgumentResolver() {
        return new UserHandlerMethodArgumentResolver();
    }


    /**
     * JSP View
     *
     * @return
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/view/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    /**
     * static resources
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
//		registry.addResourceHandler("/favicon.ico").addResourceLocations("/static/favicon.ico");
        System.out.println("deploy" + deploy);
        if("local".equals(deploy)) {
//            registry.addResourceHandler("/**").addResourceLocations("file:///" + fileRootPath + "/");
            registry.addResourceHandler("/datasdfsadfadsf/**").addResourceLocations("file:///" + fileRootPath + "/data/");
        }
    }


}
