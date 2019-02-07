package com.rsy.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rsy.ssm.common.querybean.UserQuery;
import com.rsy.ssm.dao.UserDao;
import com.rsy.ssm.domain.User;
import com.rsy.ssm.service.UserService;
import com.rsy.ssm.utils.DateUtils;
import com.rsy.ssm.utils.ExportExcel;

/**
 * 在spring进行扫描的时候，会将头顶上@Service, @Component, @Repository的类，会实例化，并且
 * 纳入到spring容器管理，就好比：
 * 	<bean id="userServiceImpl" class="com.rsy.ssm.service.impl" />
 */
@Service
@Transactional  /** 当方法中涉及多个db的操作，如果出现异常，会自动回滚 */
public class UserServiceImpl implements UserService {

	@Resource
	private UserDao userDao;
	
	/**
	 * 将 common.properties文件中的 cachePath注入给属性
	 */
	@Value("${cachePath}")
	private String cachePath;
	
	@Override
	public PageInfo<User> pageableUser(Integer offset, Integer limit, UserQuery userQuery) {
		PageHelper.offsetPage(null == offset ? 0 : offset, null == limit ? 10 : limit);
		List<User> userList = userDao.findAll(userQuery);
		PageInfo<User> pageInfo = new PageInfo<>(userList);
		return pageInfo;
	}

	@Override
	public void deleteUser(int[] ids) {
		userDao.deleteUser(ids);
	}

	@Override
	public User getUserById(Integer id) {
		return userDao.getUserById(id);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public String generateExcel(UserQuery userQuery) {
		List<User> userList = userDao.findAll(userQuery); //查询满足条件的数据
		String[] title = {"姓名", "性别", "生日", "邮件", "创建日期", "公司名称"};
		
		List<Object[]> datas = new ArrayList<>();
		userList.forEach(u -> {
			datas.add(new Object[] {u.getName(), 
					               "F".equals(u.getGender()) ? "女" : "男", 
					               DateUtils.dataToStr(u.getBirthday(), DateUtils.SIMPLE_PATTERN),
					               u.getEmail(),
					               DateUtils.dataToStr(u.getCreateTime(), DateUtils.MEDIUM_PATTERN),
					               u.getCompany().getName()
			});
		});
		
		ExportExcel exportExcel = new ExportExcel("用户信息", title, datas);
		
		RandomStringGenerator generator = new RandomStringGenerator.Builder()
				.withinRange(new char[] {'a', 'z'}, new char[] {'A', 'Z'}, new char[] {'0', '9'})
				.build();
		
		try {
			String fileName = generator.generate(8) + ".xlsx";
			exportExcel.export(cachePath + fileName);
			return fileName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
