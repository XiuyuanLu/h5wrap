package com.icaikee.kline.web.controller.api;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.common.CommonService;
import com.icaikee.kline.biz.composite.CompositeService;
import com.icaikee.kline.biz.wrap.WrapService;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/composite")
@Controller
public class CompositeDataController {

	@Autowired
	private CommonService commonService;

	@Autowired
	private CompositeService compositeService;

	@Autowired
	private WrapService wrapService;

	@RequestMapping("/tradeTime")
	public Message getTradeTime() {
		return new Message(commonService.getTradeTime());
	}

	@RequestMapping("/kline")
	public Message getKline(@RequestParam(name = "code") String code, @RequestParam(name = "type") String type) {
		try {
			return new Message(compositeService.getCandlesticks(code, type, null));
		} catch (ParseException e) {
			return new Message("error");
		}
	}

	@RequestMapping("/wrap")
	public Message getWrap(@RequestParam(name = "code") String code, @RequestParam(name = "type") String type) {
		try {
			return new Message(wrapService.getWrap(code, type, null));
		} catch (ParseException e) {
			return new Message("error");
		}
	}

}
