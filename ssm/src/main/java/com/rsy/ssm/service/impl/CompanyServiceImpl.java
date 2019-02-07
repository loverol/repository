package com.rsy.ssm.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.rsy.ssm.dao.CompanyDao;
import com.rsy.ssm.domain.Company;
import com.rsy.ssm.service.CompanyService;

@Service
@Transactional
public class CompanyServiceImpl implements CompanyService {

	@Resource
	private CompanyDao companyDao;
	
	@Override
	public List<Company> findAll() {
		return companyDao.findAll();
	}
}
