package com.icaikee.kline.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.util.StringUtils;

public class PermissionInterceptor implements HandlerInterceptor {

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
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute(WebConstants.USER_ID);
		if (StringUtils.isEmpty(userId)) {
			response.sendRedirect("/Kline/page/home/login");
			return false;
		}
		return true;
	}

}
