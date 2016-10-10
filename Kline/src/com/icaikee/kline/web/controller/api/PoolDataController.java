package com.icaikee.kline.web.controller.api;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/pool")
@Controller
public class PoolDataController {

	@RequestMapping("/fuzzyQuery")
	public Message get(HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute(WebConstants.USER_ID);
		return new Message(null);
	}

}
