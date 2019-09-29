package com.mycompany.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    private Logger logger = LoggerFactory.getLogger(WebSecurityConfig.class);
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        logger.info("configure security...");
        SimpleUrlAuthenticationFailureHandler failureHandler = new SimpleUrlAuthenticationFailureHandler();
        //failureHandler.setUseForward(true);
        http
                .cors().disable()
                .csrf().disable()
                .addFilterBefore(new CaptchaFilter(failureHandler), UsernamePasswordAuthenticationFilter.class)
                .authorizeRequests()
                .antMatchers("/user/**").authenticated()
                .antMatchers("/employee/**").authenticated()
                .antMatchers("/department/**").authenticated()
                .antMatchers("/employee-department/**").authenticated()
                .antMatchers("/login-check").authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .failureHandler(failureHandler);

        logger.info("configure security completed.");
    }
}