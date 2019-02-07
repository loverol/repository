package com.rsy.ssm.dao;

import java.util.List;
import com.rsy.ssm.domain.Company;

public interface CompanyDao {
	public List<Company> findAll();
}
