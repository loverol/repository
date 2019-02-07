package com.rsy.ssm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 该拦截器的作用是判断处理 index以外其他请求必须通过ajax的方式来获取。
 */
public class AjaxInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		/**
		 * 除了请求index，ajax请求头信息会携带 "X-Requested-With" 
		 */
		String string = request.getHeader("X-Requested-With");
		if("XMLHttpRequest".equals(string)) {
			return true;
		}else {
			response.sendRedirect("error.jsp");
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {	
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}
}
