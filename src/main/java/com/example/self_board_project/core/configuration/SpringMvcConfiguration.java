package com.example.self_board_project.core.configuration;

import com.example.self_board_project.core.authority.UserHandlerMethodArgumentResolver;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

import java.util.List;

@Configuration
public class SpringMvcConfiguration implements WebMvcConfigurer {

    private @Value("${file.root.path}") String fileRootPath;
    private @Value("${upload.resource.path}") String uploadResourcePath;
    private @Value("${deploy}") String deploy;
    /**
     * api에서 파라미터로 Auth auth 를 통해 유저정보를 가져올 수 있도록 하는 utill
     * Auth파라미터가 담긴 메소드정보를 통해 user정보를 가져오는 로직이 있는 userHandlerMethodArgumentResolver를  argumentResolvers에 등록해야한다.
     * User argumentResolvers
     */
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        System.out.println("addArgumentResolvers : " + argumentResolvers);
        argumentResolvers.add(userHandlerMethodArgumentResolver());
    }

    /**
     * api에서 파라미터로 Auth auth 를 통해 유저정보를 가져올 수 있도록 하는 utill
     * 빈에 userHandlerMethodArgumentResolver등록하기 (미리 만들어놔야함)
     *
     * @return
     */
    @Bean
    public UserHandlerMethodArgumentResolver userHandlerMethodArgumentResolver() {
        System.out.println("userHandlerMethodArgumentResolver : ");
        return new UserHandlerMethodArgumentResolver();
    }

    /**
     * static resources
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
//        registry.addResourceHandler("/favicon.ico").addResourceLocations("/static/favicon.ico");
//        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
        if("local".equals(deploy)) {
            //addResourceHandler안에서 세부적으로 addResourceLocations있는 경로의 파일들을 모두 뒤진다
            //DB의 파일위치와 addresourcehandler가 같아야 한다. 즉 db의 파일경로가 /upload/data/common/ 시작한다면 addresourcehandler도 /upload/data/common/로 시작
//          addResourceLocations에는 파일위치의 풀경로를 입력한다
            registry.addResourceHandler("/upload/data/common/**").addResourceLocations("file:///" + fileRootPath + "/data/common/");

//          registry.addResourceHandler("/upload/**").addResourceLocations("file:///" + fileRootPath + "/data/common/");
//            registry.addResourceHandler("/data/**").addResourceLocations("file:///" + fileRootPath + "/data/");
//            registry.addResourceHandler("/upload/**").addResourceLocations("file:///" + fileRootPath);
//            registry.addResourceHandler("/data/**").addResourceLocations("file:///" + fileRootPath + "/data/");
        }
    }

    /**
     * Max FileSize 4mb
     * 1024 * 1024  * 1000 * 4는 4GB
     * @return
     */
    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(1024 * 1024 * 4);
        return resolver;
    }

    /**
     * Tiles View
     *
     * @return
     */
    @Bean
    public UrlBasedViewResolver tilesViewResolver() {
        UrlBasedViewResolver resolver = new UrlBasedViewResolver();
        resolver.setViewClass(TilesView.class);
        resolver.setOrder(1);
        return resolver;
    }

    /**
     * Tiles View
     *
     * @return
     */
    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setDefinitions("/WEB-INF/tiles-*.xml");
        return tilesConfigurer;
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






}
