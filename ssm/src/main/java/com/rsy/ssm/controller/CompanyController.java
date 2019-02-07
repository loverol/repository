package com.rsy.ssm.controller;

import javax.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.rsy.ssm.service.CompanyService;

@RestController
@RequestMapping("company")
public class CompanyController {

	@Resource
	private CompanyService companyServiceImpl; 
	
	@RequestMapping
	public Object findAll() {
		return companyServiceImpl.findAll();
	}
}
