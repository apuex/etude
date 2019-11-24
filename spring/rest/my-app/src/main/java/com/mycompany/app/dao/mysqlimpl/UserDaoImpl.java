package com.mycompany.app.dao.mysqlimpl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.mycompany.app.dao.UserDao;
import com.mycompany.app.valueobject.UserVo;

@Component
public class UserDaoImpl implements UserDao {
	@Autowired
	private JdbcTemplate jdbc;
	private RowMapper<UserVo> rowMapper = new RowMapper<UserVo>() {

		@Override
		public UserVo mapRow(ResultSet rs, int idx) throws SQLException {
			return new UserVo(rs.getString("name"), rs.getString("password"));
		}
		
	};
	
	public void createUser(UserVo user) {
		jdbc.update("INSERT INTO user(name, password) VALUES (?, ?)", user.getName(), user.getPassword());
	}

	@Override
	public UserVo retrieveUser(String name) {
		return jdbc.queryForObject("SELECT name, password FROM user WHERE name = ?", rowMapper, name);
	}
}
