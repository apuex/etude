package com.sample.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "loginCheckServlet", urlPatterns = {"/login-check"})
public class LoginCheckServlet extends HttpServlet {

  Logger log = LoggerFactory.getLogger(LoginCheckServlet.class);

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    doPost(req, rsp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    if(null == req.getUserPrincipal()) {
      rsp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    } else {
      log.info(String.format("AuthType: %s", req.getAuthType()));
      log.info(String.format("UserPrincipal: %s", req.getUserPrincipal()));
      log.info(String.format("UserPrincipal: %s", req.getUserPrincipal().getClass().getName()));
      log.info(String.format("request: %s", req.getClass().getName()));
      log.info(String.format("is admin role: %s", req.isUserInRole("admin")));
      rsp.setStatus(HttpServletResponse.SC_OK);
    }
  }
}
