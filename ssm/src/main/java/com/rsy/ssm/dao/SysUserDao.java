package com.rsy.ssm.dao;

import org.apache.ibatis.annotations.Param;

import com.rsy.ssm.domain.SysUser;

public interface SysUserDao {
	public SysUser checkUsernameAndPassword(@Param("username") String username,
				@Param("password") String password);
}
