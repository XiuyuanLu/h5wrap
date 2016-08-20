package com.icaikee.kline.web.controller.api;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icaikee.kline.WebConstants;
import com.icaikee.kline.core.message.Message;

@ResponseBody
@RequestMapping(WebConstants.API + "/composite")
public class CompositeDataController {

	public Message getComposite() {

		return new Message(null);
	}

}
