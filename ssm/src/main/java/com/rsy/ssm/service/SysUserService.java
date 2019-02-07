package com.rsy.ssm.service;

import com.rsy.ssm.domain.SysUser;

public interface SysUserService {
	public SysUser checkUsernameAndPassword(String username, String password);
}
