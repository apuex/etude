package com.mycompany.app.service;

import com.mycompany.app.valueobject.UserVo;

public interface UserService {
	void createUser(UserVo user);
	UserVo retrieveUser(String name);
}
