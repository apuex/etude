package com.sample.controller;

import com.sample.message.LoginCmd;
import com.sample.message.Response;
import com.sample.message.ResponseType;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping(value = "authenticate", method = RequestMethod.POST)
public class AuthenticateController {

    @RequestMapping(value = "login", produces = "application/json")
    public ResponseEntity<Response> login(@RequestBody LoginCmd c, HttpServletRequest request, HttpServletResponse rsp) {
        try {
            request.getSession();
            request.login(c.getUsername(), c.getPassword());
            System.out.println(request);
            System.out.println(request.getUserPrincipal());

            return new ResponseEntity<>(
                    Response.newBuilder()
                            .setType(ResponseType.LOGIN_SUCCESS)
                            .setText("Login was successful.").build(),
                    HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(
                    Response.newBuilder()
                            .setType(ResponseType.LOGIN_FAILURE)
                            .setText("Login failed.").build(),
                    HttpStatus.UNAUTHORIZED);
        }
    }

    @RequestMapping(value = "logout", produces = "application/json")
    public ResponseEntity<Response> logout(@RequestBody LoginCmd c, HttpServletRequest request) {
        try {
            request.logout();
            return new ResponseEntity<>(
                    Response.newBuilder()
                            .setType(ResponseType.LOGOUT_SUCCESS)
                            .setText("Logout was successful.").build(),
                    HttpStatus.OK);
        } catch (ServletException ex) {
            return new ResponseEntity<>(
                    Response.newBuilder()
                            .setType(ResponseType.LOGOUT_FAILURE)
                            .setText("Logout failed.").build(),
                    HttpStatus.UNAUTHORIZED);
        }
    }

}
