package com.rsy.ssm.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.rsy.ssm.common.beans.Message;
import com.rsy.ssm.domain.SysUser;
import com.rsy.ssm.service.SysUserService;

@RestController
@RequestMapping("/login")
public class LoginController {

	@Resource
	private SysUserService sysUserServiceImpl;
	
	/**
	 * 用户登录
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping
	public Object login(String username, String password, HttpSession session) {
		SysUser sysUser = sysUserServiceImpl.checkUsernameAndPassword(username, DigestUtils.md5Hex(password));
		
		Message msg = new Message();
		if(null == sysUser) {
			msg.setCode(-1);
			msg.setMsg("用户名或密码错误.");
			msg.setSuccess(false);
		}else {
			msg.setCode(1);
			msg.setMsg("success");
			msg.setSuccess(true);
			session.setAttribute("userInfo", sysUser);  //登录成功一定要设置到session中
		}
		return msg;
	}
	
	public static void main(String[] args) {
		String str = "a";
		System.out.println(DigestUtils.md5Hex(str));
	}
}
