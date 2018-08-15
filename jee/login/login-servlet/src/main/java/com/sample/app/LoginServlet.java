package com.sample.app;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "loginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = -3576984538468715015L;

	@Override
  public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    doPost(req, rsp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    if(null == req.getUserPrincipal()) {
      req.getSession();
      req.login(req.getParameter("username"), req.getParameter("password"));
      rsp.setStatus(HttpServletResponse.SC_OK);
    } else {
    }
  }
}
