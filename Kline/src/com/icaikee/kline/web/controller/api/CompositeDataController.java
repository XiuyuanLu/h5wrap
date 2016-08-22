package com.icaikee.kline.web.controller.api;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.common.CommonService;
import com.icaikee.kline.biz.composite.CompositeService;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/composite")
@Controller
public class CompositeDataController {

	@Autowired
	private CommonService commonService;

	@Autowired
	private CompositeService compositeService;

	@RequestMapping("/tradeTime")
	public Message getTradeTime() {
		return new Message(commonService.getTradeTime());
	}

	@RequestMapping("/kline")
	public Message getKline() {
		try {
			return new Message(compositeService.getCandlesticks(null, "2", null, null, null));
		} catch (ParseException e) {
			return new Message("error");
		}
	}

}
