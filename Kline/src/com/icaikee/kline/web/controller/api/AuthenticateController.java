package com.icaikee.kline.web.controller.api;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.user.UserDto;
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
			@RequestParam(name = "loginName") String loginName, @RequestParam(name = "password") String password,
			@RequestParam(name = "verify") String verify) throws IOException {
		return new Message(userService.register(loginName, password, verify));
	}

	@RequestMapping("/login")
	public Message authenticate(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "username") String username, @RequestParam(name = "password") String password)
			throws IOException {
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
			return new Message("用户名或密码错误");
		UserDto user = userService.login(username, password);
		if (StringUtils.isEmpty(user.getUid()))
			return new Message("用户名或密码错误");
		HttpSession session = request.getSession();
		session.setAttribute(WebConstants.USER_ID, user.getUid());
		session.setAttribute(WebConstants.LOGIN_NAME, user.getLoginName());
		session.setAttribute(WebConstants.STOCK_COUNT, user.getStockCount());
		session.setAttribute(WebConstants.VIP_ENDDATE, user.getVipEnddate());
		return new Message("success");
	}

	@RequestMapping("/logout")
	public Message logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().removeAttribute(WebConstants.USER_ID);
		return new Message("success");
	}

	@RequestMapping("/getVerify")
	public Message getVerify(@RequestParam(name = "mobile") String mobile) throws IOException {
		return new Message(userService.getVerify(mobile));
	}

}
