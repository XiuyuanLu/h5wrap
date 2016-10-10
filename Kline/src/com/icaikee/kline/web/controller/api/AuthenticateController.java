package com.icaikee.kline.web.controller.api;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.user.UserService;
import com.icaikee.kline.core.message.Message;
import com.icaikee.kline.util.StringUtils;

@Controller
@ResponseBody
@RequestMapping(WebConstants.API + "/authenticate")
public class AuthenticateController {

	private static final String REQUEST_URL = "http://api.test.icaikee.com//api/chanlun/v1/optional/query/22?token=429913d34677b9dde13eff6aa83e90f5&appId=icaikeeApp";

	@Autowired
	private UserService userService;

	@RequestMapping("/register")
	public Message register(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "username") String username, @RequestParam(name = "password") String password,
			@RequestParam(name = "mobile") String mobile, @RequestParam(name = "verify") String verify)
			throws IOException {
		userService.register(username, password, mobile, verify);
		return new Message("success");
	}

	@RequestMapping("/login")
	public Message authenticate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "username") String username, @RequestParam(name = "password") String password)
			throws IOException {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
			return new Message("用户名或密码错误");
		request.getSession().setAttribute(WebConstants.USER_ID, "22");

		return new Message("success");
	}

}
