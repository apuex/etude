package com.sample.app;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "logoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = -4083289737754047568L;

	@Override
  public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    doPost(req, rsp);
  }

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
    if(null == req.getUserPrincipal()) {
      rsp.setStatus(HttpServletResponse.SC_OK);
    } else {
      req.logout();
    }
  }
}
