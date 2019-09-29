package com.mycompany.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {
    private Logger logger = LoggerFactory.getLogger(MvcConfig.class);

    public void addViewControllers(ViewControllerRegistry registry) {
        logger.info("add view controllers.");
        registry.addViewController("/welcome").setViewName("welcome");
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/logout").setViewName("logged-out");
    }

}
