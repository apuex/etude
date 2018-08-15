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
	private static final long serialVersionUID = 8603546152995257733L;

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
		doPost(req, rsp);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse rsp) throws IOException, ServletException {
		rsp.setContentType("text/plain");
		if (null == req.getUserPrincipal()) {
			rsp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			PrintWriter pw = rsp.getWriter();
			pw.println("No logged in.");
			pw.close();
		} else {
			rsp.setStatus(HttpServletResponse.SC_OK);
			PrintWriter pw = rsp.getWriter();
			pw.println(String.format("AuthType: %s", req.getAuthType()));
			pw.println(String.format("UserPrincipal: %s", req.getUserPrincipal()));
			pw.println(String.format("UserPrincipal Class: %s", req.getUserPrincipal().getClass().getName()));
			pw.println(String.format("HttpServletRequest Class: %s", req.getClass().getName()));
			pw.println(String.format("is admin role: %s", req.isUserInRole("admin")));
			pw.println(requestCookies(req));
			pw.close();
		}
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
}
