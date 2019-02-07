package com.rsy.ssm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 该类的主要作用就是往首页跳转 
 */
@Controller
public class IndexController {

	@RequestMapping("/index")
	public String toIndex() {
		return "index";
	}
}
