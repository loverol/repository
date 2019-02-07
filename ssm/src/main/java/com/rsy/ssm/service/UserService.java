package com.rsy.ssm.service;

import com.github.pagehelper.PageInfo;
import com.rsy.ssm.common.querybean.UserQuery;
import com.rsy.ssm.domain.User;

public interface UserService {
	public PageInfo<User> pageableUser(Integer offset, Integer limit, UserQuery userQuery);
	
	public void deleteUser(int[] ids);
	
	public User getUserById(Integer id);
	
	public void update(User user);
	
	/**
	 * 在服务层代码生产excel, 返回文件的完整路径，以便在 Controller层进行文件的下载 
	 */
	public String generateExcel(UserQuery userQuery);
}
