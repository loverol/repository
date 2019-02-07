package com.rsy.ssm.service.impl;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.rsy.ssm.dao.SysUserDao;
import com.rsy.ssm.domain.SysUser;
import com.rsy.ssm.service.SysUserService;

@Service
@Transactional
public class SysUserServiceImpl implements SysUserService {

	@Resource
	private SysUserDao sysUserDao;
	
	@Override
	public SysUser checkUsernameAndPassword(String username, String password) {
		return sysUserDao.checkUsernameAndPassword(username, password);
	}
}
