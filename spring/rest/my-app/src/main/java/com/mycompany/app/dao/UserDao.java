package com.mycompany.app.dao;

import com.mycompany.app.valueobject.UserVo;

public interface UserDao {
	void createUser(UserVo user);
	UserVo retrieveUser(String name);
}
