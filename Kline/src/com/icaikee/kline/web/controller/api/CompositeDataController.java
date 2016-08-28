package com.icaikee.kline.web.controller.api;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.biz.common.model.WrapStructures;
import com.icaikee.kline.biz.composite.CompositeService;
import com.icaikee.kline.biz.wrap.WrapService;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/composite")
@Controller
public class CompositeDataController {

	@Autowired
	private CompositeService compositeService;

	@Autowired
	private WrapService wrapService;

	@RequestMapping("/realtime")
	public Message realtime(@RequestParam(name = "stockcode") String code) {
		try {
			return new Message(compositeService.getRealtimeQuote(code));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			return new Message("error");
		}
	}

	@RequestMapping("/kline")
	public Message getKline(@RequestParam(name = "stockcode") String code, @RequestParam(name = "type") String type) {
		try {
			List<Object> data = new ArrayList<Object>();
			WrapStructures wrapStructures = wrapService.getWrapStructures(code, type, null);
			data.add(compositeService.getCandlesticks(code, type, null));
			data.add(wrapStructures.getPen());
			data.add(wrapStructures.getSegment());
			data.add(wrapStructures.getPenCenter());
			return new Message(data);
		} catch (ParseException e) {
			return new Message("error");
		}
	}

}
