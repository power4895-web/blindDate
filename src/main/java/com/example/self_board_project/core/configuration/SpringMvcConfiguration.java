package com.example.self_board_project.core.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@Configuration
public class SpringMvcConfiguration implements WebMvcConfigurer {

    private @Value("${file.root.path}") String fileRootPath;
    private @Value("${upload.resource.path}") String uploadResourcePath;
    private @Value("${deploy}") String deploy;
    /**
     * User argumentResolvers
     */
//    @Override
//    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
//        argumentResolvers.add(userHandlerMethodArgumentResolver());
//    }

    /**
     * argument를 이용한 로그인 사용자 정보
     *
     * @return
     */
//    @Bean
//    public UserHandlerMethodArgumentResolver userHandlerMethodArgumentResolver() {
//        return new UserHandlerMethodArgumentResolver();
//    }
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

    /**
     * static resources
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
        if("local".equals(deploy)) {
            registry.addResourceHandler( uploadResourcePath + "**").addResourceLocations("file:///" + fileRootPath); //data 말고 다른 이름으로 해줘도 된다.
        }
    }


}
