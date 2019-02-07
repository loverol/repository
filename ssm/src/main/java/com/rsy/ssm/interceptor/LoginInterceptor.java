package com.rsy.ssm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{

	/**
	 * 在处理具体的资源之前调用， 
	 * 返回false，会停止往后走；返回true表示接着往走
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("userInfo");
		if(null == obj) {  //如果获取的userInfo信息为空,那么表示用户从来没有登录过
			response.sendRedirect("login.jsp");
			return false;
		}else { //用户登录过
			return true;
		}
	}

	/**
	 * 在处理完资源之后调用
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	/**
	 * 当视图渲染完毕以后才执行
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}
}
