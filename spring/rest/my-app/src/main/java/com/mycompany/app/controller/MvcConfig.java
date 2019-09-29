package com.mycompany.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

import java.io.File;

@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {
    private Logger logger = LoggerFactory.getLogger(MvcConfig.class);

    public void addViewControllers(ViewControllerRegistry registry) {
        logger.info("add view controllers.");
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/welcome").setViewName("welcome");
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/logout").setViewName("logged-out");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        logger.info("add static resource handlers.");
        String pathString = System.getProperty("static.content.dir", "src/main/resources/static");
        logger.info("static content dir: '{}'", pathString);
        File path = new File(pathString);
        if(null != pathString) {
            if (path.isDirectory()) {
                logger.info("static content dir(absolute): '{}'", path.getAbsolutePath());
                registry.addResourceHandler("/**").addResourceLocations(String.format("file://%s/", path.getAbsolutePath()));
                return;
            }
        }
    }
}
