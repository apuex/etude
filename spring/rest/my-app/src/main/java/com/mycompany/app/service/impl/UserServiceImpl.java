package com.mycompany.app.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.app.dao.UserDao;
import com.mycompany.app.service.UserService;
import com.mycompany.app.valueobject.UserVo;

@Component
public class UserServiceImpl implements UserService {
	@Autowired 
	private UserDao userDao;
	
	@Override
	@Transactional
	public void createUser(UserVo user) {
		userDao.createUser(user);
	}

	@Override
	public UserVo retrieveUser(String name) {
		return userDao.retrieveUser(name);
	}

}
