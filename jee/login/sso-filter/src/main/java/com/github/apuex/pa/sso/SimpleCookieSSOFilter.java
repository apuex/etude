package com.github.apuex.pa.sso;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SimpleCookieSSOFilter implements Filter {
  private final static Logger logger = LoggerFactory.getLogger(SimpleCookieSSOFilter.class);
  private String usernameField = "realm-user";
  private String passwordField = "realm-pw";

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse rsp = (HttpServletResponse) response;
    if (null == req.getUserPrincipal()) {
      if(!login(req, rsp)) {
        rsp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        return;
      }
    }
    chain.doFilter(request, response);
  }

  public void init(FilterConfig filterConfig) throws ServletException {
    String u = filterConfig.getInitParameter("usernameField");
    String p = filterConfig.getInitParameter("passwordField");
    if(null == u || null == p) {
      logger.warn("username/password field name is not set");
    } else {
      usernameField = u;
      passwordField = p;
    }
    logger.info("(username, password) field names are set to ({}, {}).", usernameField, passwordField);
  }

  private boolean login(HttpServletRequest req, HttpServletResponse rsp) {
    logger.info("not logged in - try login.");
    Cookie[] cookies = req.getCookies();
    String username = null;
    String password = null;
    if (null != cookies) {
      for (Cookie c : cookies) {
        System.out.printf("%s = %s\n", c.getName(), c.getValue());
        if (usernameField.equals(c.getName())) {
          username = c.getValue();
        }
        if (passwordField.equals(c.getName())) {
          password = c.getValue();
        }
      }
      if (null != username) {
        try {
          req.login(username, password);
          logger.info("logged in.");
          return true;
        } catch (Exception ex) {
          logger.info("login failed.");
        }
      } else {
        logger.info("no username - skip login.");
      }
    }
    return false;
  }
}
