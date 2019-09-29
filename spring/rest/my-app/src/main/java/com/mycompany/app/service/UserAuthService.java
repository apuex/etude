package com.mycompany.app.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.mycompany.app.dao.UserDao;
import com.mycompany.app.valueobject.UserVo;

public class UserAuthService implements UserDetailsService {
	private final static Logger logger = LoggerFactory.getLogger(UserAuthService.class);
	@Autowired
	private UserDao userDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		logger.info("loading user: {}", username);
		try {
			UserVo userVo = userDao.retrieveUser(username);

			return User.builder().username(userVo.getName()).password("password").password(userVo.getPassword())
					.roles("USER").build();

		} catch (Exception sqlex) {
			sqlex.printStackTrace();
			logger.info("no user: {}", username);
			throw new UsernameNotFoundException("User not found.", sqlex);
		}
	}
}
