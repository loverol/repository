package com.rsy.ssm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageInfo;
import com.rsy.ssm.common.beans.Datas;
import com.rsy.ssm.common.beans.Message;
import com.rsy.ssm.common.querybean.UserQuery;
import com.rsy.ssm.domain.Company;
import com.rsy.ssm.domain.User;
import com.rsy.ssm.service.UserService;

/**
 * 200: 服务器正常响应。
 * 400: 请求的参数有误(给的参数类型与服务器端接收的参数类型不符，比如服务端int age, 
 *  前段传入a
 *  )
 * 404: 资源没有找到
 * 405: 请求的协议错误，比如服务是get, 而发送post请求
 * 500: 服务器内部错误，说白了代码有问题。
 */
@RestController
@RequestMapping("user")
public class UserController {
	
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@Resource
	private UserService userServiceImpl;
	
	@Value("${cachePath}")
	private String cachePath;
	
	//获取分页的数据
	@RequestMapping
	public Object getPageableUser(Integer offset, Integer limit, UserQuery userQuery) {
		PageInfo<User> pageInfo = userServiceImpl.pageableUser(offset, limit, userQuery);
		
		Datas<User> datas = new Datas<>();
		datas.setRows(pageInfo.getList());
		datas.setTotal(pageInfo.getTotal());
		
		return datas;
	}
	
	// 根据id获取对应的用户
	@RequestMapping("/{id}")
	public Object getUser(@PathVariable(name="id") Integer id) {
		User user = userServiceImpl.getUserById(id);
		return user;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Object edit(User user, Integer companyId) {
		Company company = new Company();
		company.setId(companyId);
		
		user.setCompany(company);
		
		Message msg = new Message();
		try {
			userServiceImpl.update(user);
			msg.setSuccess(true);
			msg.setMsg("删除成功");
			msg.setCode(1);
		}catch(Exception ex) {
			logger.error(ex.getMessage());
			msg.setSuccess(false);
			msg.setMsg("删除失败");
			msg.setCode(-1);
		}
		
		return msg;
	}
	
	@RequestMapping("/delete")
	public Object delete(String ids) {
		String[] idStrArray = ids.split(";"); //用逗号来拆分的原因在于前端使用;来拼接的
		
		int[] idArray = new int[idStrArray.length];
		for(int i = 0; i < idStrArray.length; i++) {
			idArray[i] = Integer.parseInt(idStrArray[i]);
		}
		
		Message msg = new Message();
		try {
			userServiceImpl.deleteUser(idArray);
			msg.setSuccess(true);
			msg.setMsg("删除成功");
			msg.setCode(1);
		}catch(Exception ex) {
			logger.error(ex.getMessage());
			msg.setSuccess(false);
			msg.setMsg("删除失败");
			msg.setCode(-1);
		}
		
		return msg;
	}
	
	// excel的导出
	@RequestMapping("/export")
	public void export(UserQuery userQuery, HttpServletResponse resp) {
		String fileName = userServiceImpl.generateExcel(userQuery);
		
		resp.setContentType("application/octet-stream;charset=utf-8");
		resp.setHeader("Content-Disposition", "attachment;filename*=utf-8'zh_cn'" + fileName);
		try {
			FileCopyUtils.copy(new FileInputStream(new File(cachePath + fileName)), 
					resp.getOutputStream());
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
