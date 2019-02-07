package com.rsy.ssm.dao;

import java.util.List;
import com.rsy.ssm.common.querybean.UserQuery;
import com.rsy.ssm.domain.User;

public interface UserDao {
	public List<User> findAll(UserQuery userQuery);
	
	public void deleteUser(int[] ids);
	
	public User getUserById(Integer id);
	
	public void update(User user);
}
