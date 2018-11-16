package com.sample.app;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AutoLoginFilter implements Filter {
  @Override
  public void init(FilterConfig filterConfig) throws ServletException {

  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletRequest req = (HttpServletRequest) request;
    HttpServletResponse rsp = (HttpServletResponse) response;
    if(null == req.getUserPrincipal()) {
      login(req, rsp);
    }
    chain.doFilter(request, response);
  }

  @Override
  public void destroy() {

  }

  private void login(HttpServletRequest req, HttpServletResponse rsp) {
    System.out.println("not logged in - try login.");
    Cookie[] cookies = req.getCookies();
    String username = null;
    String password = null;
    if (null != cookies) {
      for (Cookie c : cookies) {
        System.out.printf("%s = %s\n", c.getName(), c.getValue());
        if ("userName".equals(c.getName())) {
          username = c.getValue();
        }
        if ("passWord".equals(c.getName())) {
          password = c.getValue();
        }
      }
      if (null != username) {
        try {
          req.login(username, password);
          System.out.println("logged in.");
        } catch (Exception ex) {
          System.out.println("login failed.");
        }
      } else {
        System.out.println("no username - skip login.");
      }
    }
  }
}
