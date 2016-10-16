package com.icaikee.kline.web.controller.api;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.user.ShoppingDto;
import com.icaikee.kline.biz.user.UserDto;
import com.icaikee.kline.biz.user.UserMsgDto;
import com.icaikee.kline.biz.user.UserService;
import com.icaikee.kline.core.message.Message;

@Controller
@ResponseBody
@RequestMapping(WebConstants.API + "/user")
public class UserDataController {

	@Autowired
	private UserService userService;

	@RequestMapping("/info")
	public Message info(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute(WebConstants.USER_ID);
		UserDto user = userService.getUserInfo(uid);
		return new Message(user);
	}

	@RequestMapping("/shopping")
	public Message shopping(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute(WebConstants.USER_ID);
		List<ShoppingDto> shoppings = userService.getShopping(uid);
		return new Message(shoppings);
	}

	@RequestMapping("/message")
	public Message message(HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute(WebConstants.USER_ID);
		List<UserMsgDto> messages = userService.getMessages(uid);
		return new Message(messages);
	}

	@RequestMapping("/password")
	public Message password(HttpServletRequest request, @RequestParam(name = "oldPassword") String oldPassword,
			@RequestParam(name = "newPassword") String newPassword) throws IOException {
		HttpSession session = request.getSession();
		String uid = (String) session.getAttribute(WebConstants.USER_ID);
		return new Message(userService.modifyPassword(uid, oldPassword, newPassword));
	}

}
