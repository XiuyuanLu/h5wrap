package com.icaikee.kline.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import com.icaikee.kline.WebConstants;

public class BaseInterceptor implements HandlerInterceptor {

	Logger logger = Logger.getLogger(this.getClass());

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if (handler instanceof ResourceHttpRequestHandler)
			return true;
		String servletPath = request.getServletPath();
		if (servletPath.startsWith("/" + WebConstants.PAGE + "/")) {
			// String base = request.getScheme() + "://" +
			// request.getServerName() + ":" + request.getServerPort()
			// + request.getContextPath() + "/";
			String base = request.getScheme() + "://m.chanlunjun.com" + request.getContextPath() + "/";
			request.getSession().setAttribute("base", base);
		}
		return true;
	}

}
