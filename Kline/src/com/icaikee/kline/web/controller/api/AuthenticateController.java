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

	@Autowired
	private UserService userService;

	@RequestMapping("/register")
	public Message register(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "loginName") String loginName, @RequestParam(name = "nickname") String nickname,
			@RequestParam(name = "password") String password, @RequestParam(name = "mobile") String mobile,
			@RequestParam(name = "verify") String verify) throws IOException {
		return new Message(userService.register(loginName, nickname, password, mobile, verify));
	}

	@RequestMapping("/login")
	public Message authenticate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "username") String username, @RequestParam(name = "password") String password)
			throws IOException {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
			return new Message("用户名或密码错误");
		String uid = userService.login(username, password);
		if ("error".equals(uid))
			return new Message("用户名或密码错误");
		request.getSession().setAttribute(WebConstants.USER_ID, uid);
		return new Message("success");
	}

	@RequestMapping("/logout")
	public Message logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().removeAttribute(WebConstants.USER_ID);
		return new Message("success");
	}

}
