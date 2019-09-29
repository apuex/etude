package com.mycompany.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mycompany.app.service.UserService;
import com.mycompany.app.valueobject.UserVo;

@RestController
@RequestMapping(value = "user")
public class UserController {
	private Logger logger = LoggerFactory.getLogger(UserController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@RequestMapping(value = "create-user", method = RequestMethod.POST, consumes = "application/json")
	public void createUser(@RequestBody UserVo user) {
		UserVo encrypted = new UserVo(user.getName(), passwordEncoder.encode(user.getPassword()));
		logger.info("User: {}", encrypted);
		userService.createUser(encrypted);
	}

	@RequestMapping(value = "retrieve-user", method = RequestMethod.POST, consumes = "application/json")
	public UserVo retrieveUser(@RequestBody UserVo user) {
		logger.info("User: {}", user);
		return userService.retrieveUser(user.getName());
	}

	@GetMapping(value = "name/{name}")
	public UserVo retrieveUser(@PathVariable String name) {
		logger.info("User: {}", name);
		return userService.retrieveUser(name);
	}
}
