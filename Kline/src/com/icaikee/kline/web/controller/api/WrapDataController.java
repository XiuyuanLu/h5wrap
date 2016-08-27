package com.icaikee.kline.web.controller.api;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.wrap.WrapService;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/wrap")
@Controller
public class WrapDataController {

	@Autowired
	private WrapService wrapService;

	@RequestMapping("/pen")
	public Message getWrapPen(@RequestParam(name = "stockcode") String code, @RequestParam(name = "type") String type) {
		try {
			return new Message(wrapService.getWrapPen(code, type, null));
		} catch (ParseException e) {
			return new Message("error");
		}
	}

	@RequestMapping("/segment")
	public Message getWrapSegment(@RequestParam(name = "stockcode") String code,
			@RequestParam(name = "type") String type) {
		try {
			return new Message(wrapService.getWrapSegment(code, type, null));
		} catch (ParseException e) {
			return new Message("error");
		}
	}
}
