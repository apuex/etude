package com.sample.app;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "loginCheckServlet", urlPatterns = {"/login-check"})
public class LoginCheckServlet extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    doPost(req, rsp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    rsp.setContentType("text/plain");
    if (null == req.getUserPrincipal()) {
      unauthorized(rsp);
    } else {
      authorized(req, rsp);
    }
  }

  private void authorized(HttpServletRequest req, HttpServletResponse rsp) throws IOException {
    rsp.setStatus(HttpServletResponse.SC_OK);
    PrintWriter pw = rsp.getWriter();
    pw.println(String.format("AuthType: %s", req.getAuthType()));
    pw.println(String.format("UserPrincipal: %s", req.getUserPrincipal()));
    pw.println(String.format("UserPrincipal Class: %s", req.getUserPrincipal().getClass().getName()));
    pw.println(String.format("HttpServletRequest Class: %s", req.getClass().getName()));
    pw.println(String.format("is admin role: %s", req.isUserInRole("admin")));
    pw.println(requestCookies(req));
    System.getProperties().store(pw, "# system properties:");
    pw.close();
  }

  private void authorizing(HttpServletResponse rsp) throws IOException {
    rsp.setStatus(HttpServletResponse.SC_OK);
    PrintWriter pw = rsp.getWriter();
    pw.println("No logged in.");
    System.getProperties().store(pw, "# system properties:");
    pw.close();
  }

  private void unauthorized(HttpServletResponse rsp) throws IOException {
    rsp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    rsp.addCookie(new Cookie("userName", "test"));
    rsp.addCookie(new Cookie("passWord", "test"));
    PrintWriter pw = rsp.getWriter();
    pw.println("No logged in.");
    System.getProperties().store(pw, "# system properties:");
    pw.close();
  }

  private String requestCookies(HttpServletRequest req) {
    Cookie[] cookies = req.getCookies();
    StringBuilder cookieString = new StringBuilder();
    cookieString.append("Cookie: ");
    for (Cookie c : cookies) {
      cookieString.append(String.format("%s=%s, maxAge=%s\n", c.getName(), c.getValue(), c.getMaxAge()));
    }
    return cookieString.toString();
  }

  private void login(HttpServletRequest req, HttpServletResponse rsp) {
    System.out.println("not logged in - try login.");
    Cookie[] cookies = req.getCookies();
    String username = "test";
    String password = "test";
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
